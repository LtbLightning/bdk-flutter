import 'package:bdk_flutter/bdk_flutter.dart';
import 'package:bdk_flutter/src/utils/exceptions/broadcast_exceptions.dart';
import 'package:bdk_flutter/src/utils/exceptions/key_exceptions.dart';
import 'package:bdk_flutter/src/utils/exceptions/wallet_exceptions.dart';
import 'package:bdk_flutter/src/utils/validators.dart';

import 'package:flutter_rust_bridge/flutter_rust_bridge.dart';
import 'utils/loader.dart';

class BdkWallet {
  Future<ResponseWallet> createWallet(
      {String? mnemonic,
        String? password,
        String? descriptor,
        String? changeDescriptor,
        required Network network,
        required String blockChainConfigUrl,
        String? socks5OrProxy,
        required Blockchain blockchain,
        String? retry,
        String? timeOut}) async {
    try {
      if ((mnemonic == null || mnemonic.isEmpty ) && (descriptor == null || descriptor.isEmpty)) {
        throw const WalletException.insufficientCoreArguments("Requires a mnemonic or a descriptor");
      }
      if((mnemonic != null )&& (descriptor != null ))
      {
        throw const WalletException.repetitiousArguments("Provided both mnemonic and descriptor.");
      }
      if (blockChainConfigUrl.isEmpty||blockChainConfigUrl == null ) {
        throw const WalletException.invalidBlockchainUrl();
      }
      if (descriptor != null && changeDescriptor!=null) {
        await loaderApi.walletInit(
            descriptor: descriptor.toString(),
            changeDescriptor: changeDescriptor.toString(),
            network: network.name.toString(),
            blockchain: blockchain.name.toString(),
            socks5OrProxy: socks5OrProxy.toString(),
            url: blockChainConfigUrl);
      } else {

        var key = await createExtendedKey(
            network: network,
            mnemonic: mnemonic.toString(),
            password: password);
        var descriptor = await createDescriptor(xprv: key.xprv, type: Descriptor.P2WPKH);
        var changeDescriptor = createChangeDescriptor(descriptor:descriptor);
        await loaderApi.walletInit(
            descriptor: descriptor.toString(),
            changeDescriptor: changeDescriptor.toString(),
            network: network.name.toString(),
            blockchain: blockchain.name.toString(),
            url: blockChainConfigUrl,
            socks5OrProxy: socks5OrProxy.toString());
      }
      final res = await loaderApi.getWallet();
      return res;
    } on FfiException catch (e) {
      throw WalletException.unexpected( e.message);
    }
  }

  Future<ResponseWallet> getWallet() async {
    try {
      return await loaderApi.getWallet();
    } on FfiException catch (e) {
      throw WalletException.unexpected(e.message);
    }
  }

  Future<String> getNewAddress() async {
    try {
      var res = await loaderApi.getNewAddress();
      return res.toString();
    } on FfiException catch (e) {
      throw WalletException.unexpected( e.message);
    }
  }

  Future<String> getBalance() async {
    try {
      var res = await loaderApi.getBalance();
      return res.toString();
    } on FfiException catch (e) {
      throw WalletException.unexpected(e.message);
    }
  }

  Future<String> getLastUnusedAddress() async {
    try {
      var res = await loaderApi.getLastUnusedAddress();
      return res.toString();
    } on FfiException catch (e) {
      throw WalletException.unexpected(e.message);
    }
  }

  syncWallet() async {
    try {
      print("Syncing Wallet");
      await loaderApi.syncWallet();
    } on FfiException catch (e) {
      throw WalletException.unexpected(e.message);
    }
  }

  Future<List<Transaction>> getTransactions() async {
    try {
      final res = await loaderApi.getTransactions();
      return res;
    } on FfiException catch (e) {
      throw WalletException.unexpected(e.message);
    }

  }

  Future<List<Transaction>> getPendingTransactions() async {
    try {
      List<Transaction> unConfirmed = [];
      final res = await getTransactions();
      for (var e in res) {
        e.maybeMap(
            orElse: () {},
            unconfirmed: (e) {
              unConfirmed.add(e);
            });
      }
      return unConfirmed;
    } on WalletException catch (e) {
      rethrow;
    }
  }

  Future<List<Transaction>> getConfirmedTransactions() async {
    try {
      List<Transaction> confirmed = [];
      final res = await getTransactions();
      for (var e in res) {
        e.maybeMap(
            orElse: () {},
            confirmed: (e) {
              confirmed.add(e);
            });
      }
      return confirmed;
    } on WalletException catch (e) {
      rethrow;
    }
  }

  Future<String> createTransaction(
      {required String recipient,
        required int amount,
        required double feeRate}) async {
    try {
      if(amount<100) throw const BroadcastException.insufficientAmount( "The minimum amount should be greater 100");
      final res = await loaderApi.createTransaction(
          recipient: recipient, amount: amount, feeRate: feeRate);
      return res;
    } on FfiException catch (e) {
      throw BroadcastException.unexpected(e.message);
    }
  }

  Future<void> signTransaction({required String psbt}) async {
    try {
      await loaderApi.sign(psbtStr: psbt);
    } on FfiException catch (e) {
      throw BroadcastException.unexpected( e.message);
    }
  }

  Future<String> broadcastTransaction({required String psbt}) async {
    try {
      final txid = await loaderApi.broadcast(psbtStr: psbt);
      return txid;
    } on FfiException catch (e) {
      throw BroadcastException.unexpected(e.message);
    }
  }

  Future<String> quickSend({required String recipient,
    required int amount,
    required double feeRate}) async {
    try {
      if(amount<100) throw const BroadcastException.insufficientAmount( "The minimum amount should be greater 100");
      final psbt = await createTransaction(recipient: recipient, amount: amount, feeRate: feeRate);
      await signTransaction(psbt: psbt);
      final txid = await broadcastTransaction(psbt: psbt);
      return txid;
    } on FfiException catch (e) {
      throw BroadcastException.unexpected( e.message);
    }
  }
}

Future<String> generateMnemonic(
    {WordCount ? wordCount ,
      Entropy? entropy }) async {
  try {
    if((wordCount != null  ) && (entropy != null ))
    {
      var res = await loaderApi.generateSeedFromEntropy(entropy: entropy.name.toString());
      return res;
    } else if( wordCount != null ) {
      var res = await loaderApi.generateSeedFromWordCount(wordCount: wordCount.name.toString());
      return res;
    } else if(entropy != null )
    {
      var res = await loaderApi.generateSeedFromEntropy(entropy: entropy.name.toString());
      return res;
    } else{
      var res = await loaderApi.generateSeedFromEntropy(entropy: Entropy.Entropy128.name.toString());
      return res;
    }
  } on FfiException catch (e) {
    throw KeyException.unexpected(e.message);
  }
}

Future<String> createXprv(
    {required Network network,
      required String mnemonic,
      String? password = ''}) async {
  try {
    var res = await createExtendedKey(network: network, mnemonic: mnemonic, password: password.toString());
    return res.xprv.toString();
  } on KeyException  {
    rethrow;
  }
}
Future<String> getXpub({
  required Network network,
  required String mnemonic,
  String? password = ''}) async {
  try {
    var res = await loaderApi.getXpub( nodeNetwork: network.name.toString(),
        mnemonic: mnemonic,
        password: password.toString());
    return res.toString();
  } on FfiException catch (e) {
    throw KeyException.unexpected(e.message);
  }
}

Future<ExtendedKeyInfo> createExtendedKey(
    {required Network network,
      required String mnemonic,
      String? password = ''}) async {
  try {
    if(!isValidMnemonic(mnemonic.toString())) throw const KeyException.invalidMnemonic("The mnemonic length must be a multiple of 6 greater than or equal to 12 and less than 24");
    var res = await loaderApi.createKey(
        nodeNetwork: network.name.toString(),
        mnemonic: mnemonic,
        password: password.toString());
    return res;
  } on FfiException catch (e) {
    throw KeyException.unexpected(e.message);
  }
}


String createChangeDescriptor({required String descriptor}) {
  return descriptor.replaceAll("/84'/1'/0'/0/*", "/84'/1'/0'/1/*");
}

Future<String> createDescriptor({String? xprv, Descriptor? type, String? mnemonic, Network ?network, String? password, List<String>? publicKeys , int? threshold = 4}) async {
  if ((mnemonic == null ) && (xprv == null )) {
    throw const KeyException.insufficientCoreVariables("Require a mnemonic or xprv.");
  }
  if((mnemonic != null  ) && (xprv != null ))
  {
    throw const KeyException.repetitiousArguments("Provided both mnemonic and xprv.");
  }
  if(mnemonic != null ) {
    if(network ==null) throw const KeyException.invalidNetwork();
  }

  var xprvStr = xprv ?? (await createXprv(network: network!, mnemonic: mnemonic.toString()));
  switch (type) {
    case Descriptor.P2PKH:
      return "pkh($xprvStr/84'/1'/0'/0/*)";
    case Descriptor.P2WPKH:
      return "wpkh($xprvStr/84'/1'/0'/0/*)";
    case Descriptor.P2SHP2WPKH:
      return "sh(wpkh($xprvStr/84'/1'/0'/0/*))";
    case Descriptor.P2SHP2WSHP2PKH:
      return "sh(wsh(pkh($xprvStr/84'/1'/0'/0/*)))";
    case Descriptor.MULTI:
      return _createMultiSigDescriptor(publicKeys: publicKeys, threshold: threshold!.toInt(),xprv: xprv.toString());;
    default:
      return "wpkh($xprvStr/84'/1'/0'/0/*)";
  }
}

String _createMultiSigDescriptor({required List<String>? publicKeys, int threshold = 2, required String xprv}){
  if( publicKeys == null ) {
    throw const KeyException.invalidPublicKey("Public key must not be null");
  }
  if (threshold == 0 || threshold > publicKeys.length + 1) throw const KeyException.invalidThresholdValue();
  return "wsh(thresh($threshold,$xprv/84'/1'/0'/0/*,${publicKeys.reduce((value, element) => '$value,$element')}, sdv:older(2)))";
}


