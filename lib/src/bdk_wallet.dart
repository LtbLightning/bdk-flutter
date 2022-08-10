import 'package:bdk_flutter/bdk_flutter.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge.dart';
import 'utils/loader.dart';

class BdkWallet {
  Future<void> createWallet(
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
        throw Exception("Missing both mnemonic and descriptor");
      } else if((mnemonic != null )&& (descriptor != null || descriptor!.isNotEmpty))
      {
        throw Exception("Provided both mnemonic and descriptor");
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
    } on FfiException catch (e) {
      print(e.message);
    }
  }

  Future<BdkFlutterWallet> getWallet() async {
    try {
      return await loaderApi.getWallet();
    } on FfiException catch (e) {
      rethrow;
    }
  }

  Future<String> getNewAddress() async {
    try {
      var res = await loaderApi.getNewAddress();
      return res.toString();
    } on FfiException catch (e) {
      return e.message.toString();
    }
  }

  Future<String> getBalance() async {
    try {
      var res = await loaderApi.getBalance();
      return res.toString();
    } on FfiException catch (e) {
      print(e.message);
      return e.message.toString();
    }
  }

  Future<String> getLastUnusedAddress() async {
    try {
      var res = await loaderApi.getLastUnusedAddress();
      return res.toString();
    } on FfiException catch (e) {
      print(e.message);
      return e.message.toString();
    }
  }

  syncWallet() async {
    try {
      print("Syncing Wallet");
      await loaderApi.syncWallet();
    } on FfiException catch (e) {
      print(e.message);
    }
  }

  Future<List<Transaction>> getTransactions() async {
    final res = await loaderApi.getTransactions();
    return res;
  }

  Future<List<Transaction>> getPendingTransactions() async {
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
  }

  Future<List<Transaction>> getConfirmedTransactions() async {
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
  }

  Future<String> createPartiallySignedTransaction(
      {required String recipient,
        required int amount,
        required double feeRate}) async {
    try {
      final res = await loaderApi.createTransaction(
          recipient: recipient, amount: amount, feeRate: feeRate);

      return res;
    } on FfiException catch (e) {
      print(e.message);
      return e.message.toString();
    }
  }

  Future<void> signTransaction({required String psbt}) async {
    try {
      await loaderApi.sign(psbtStr: psbt);
    } on FfiException catch (e) {
      print(e.message);
    }
  }

  Future<String> broadcastTransaction({required String psbt}) async {
    try {
      final txid = await loaderApi.broadcast(psbtStr: psbt);
      return txid;
    } on FfiException catch (e) {
      print(e.message);
      return e.message.toString();
    }
  }

  Future<String> signAndBroadcast({required String psbt}) async {
    try {
      final txid = await loaderApi.signAndBroadcast(psbtStr: psbt);
      return txid;
    } on FfiException catch (e) {
      print(e.message);
      return e.message.toString();
    }
  }
}

Future<String> generateMnemonic(
    {WordCount wordCount = WordCount.Words12,
      Entropy entropy = Entropy.Entropy128}) async {
  try {
    var res = await loaderApi.generateMnemonicSeed(
        wordCount: wordCount.name.toString(), entropy: entropy.name.toString());
    return res;
  } on FfiException catch (e) {
    print(e.message);
    return e.message.toString();
  }
}

Future<String> createXprv(
    {required Network network,
      required String mnemonic,
      String? password = ''}) async {
  try {
    var res = await createExtendedKey(
        network: network, mnemonic: mnemonic, password: password.toString());
    return res.xprv.toString();
  } on FfiException catch (e) {
    print(e.message);
    return e.message.toString();
  }
}

Future<ExtendedKeyInfo> createExtendedKey(
    {required Network network,
      required String mnemonic,
      String? password = ''}) async {
  var res = await loaderApi.createKey(
      nodeNetwork: network.name.toString(),
      mnemonic: mnemonic,
      password: password.toString());
  return res;
}
String createChangeDescriptor({required String descriptor}) {
  return descriptor.replaceAll("/84'/1'/0'/0/*", "/84'/1'/0'/1/*");
}

Future<String> createDescriptor({String? xprv, Descriptor? type, String? mnemonic, Network ?network, String? password, List<String>? publicKeys, int? threshold = 4}) async {
  if ((mnemonic == null ) && (xprv == null )) {
    throw Exception("Missing both mnemonic and xprv");
  }
  if((mnemonic != null  ) && (xprv != null ))
  {
    throw Exception("Provided both mnemonic and xprv");
  }

  if(mnemonic != null ) {
    if(network ==null) throw Exception("Network is required, when using mnemonic");
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
      return "sh(wsh(pkh($xprvStr/84'/1'/0'/0/*)))";
    default:
      return "wpkh($xprvStr/84'/1'/0'/0/*)";
  }
}

String _createMutliSigDescriptor(
    {List<String>? publicKeys, int? threshold = 4,}){
  return '';
}


