import 'package:bdk_flutter/bdk_flutter.dart';
import 'package:bdk_flutter/src/enums/descriptor.dart';
import 'package:bdk_flutter/src/enums/entropy.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge.dart';
import 'enums/network.dart';
import 'enums/word_count.dart';
import 'generated/bindings.dart';
import 'utils/loader.dart';

class BdkWallet {
  Future<void> createWallet({
    String? mnemonic,
    String? password,
    bool useDescriptors = false,
    String? descriptor,
    String? changeDescriptor,
    required Network network,
    required String blockChainConfigUrl,
    String?  socks5OrProxy,
    required Blockchain blockchain,
    String? retry,
    String? timeOut
  }) async {
    try{
      if (useDescriptors) {
        await loaderApi.walletInit(
            descriptor: descriptor.toString(),
            changeDescriptor: changeDescriptor.toString(),
            network: network.name.toString(),
            blockchain: blockchain.name.toString(),
            socks5OrProxy: socks5OrProxy.toString(),
            url: blockChainConfigUrl);
      } else {
        var key = await createExtendedKey(network:network, mnemonic:mnemonic!.toString());
        var descriptor = createDescriptor( xprv: key.xprv, descriptor: Descriptor.P2WPKH);
        var changeDescriptor = createChangeDescriptor(key.xprv);
        await loaderApi.walletInit(
            descriptor: descriptor.toString(),
            changeDescriptor: changeDescriptor.toString(),
            network: network.name.toString(),
            blockchain: blockchain.name.toString(),
            url: blockChainConfigUrl,
            socks5OrProxy: socks5OrProxy.toString());
      }
    } on FfiException catch(e) {
      print(e.message);
    }
  }
  Future<BdkFlutterWallet> getWallet() async {
   try{
     return   await loaderApi.getWallet();
    } on FfiException catch(e) {
       rethrow  ;
    }
  }
  Future<String> getNewAddress() async {
    try{
      var res = await loaderApi.getNewAddress();
      return res.toString();
    }  on FfiException catch(e) {
      return e.message.toString();
    }
  }
  Future<String> getBalance() async {
    try{
      var res = await loaderApi.getBalance();
      print(res.toString());
      return res.toString();
    } on FfiException catch(e) {
      print(e.message);
      return e.message.toString();
    }
  }
  Future<String> getLastUnusedAddress() async {
    try {
      var res = await loaderApi.getLastUnusedAddress();
      return res.toString();
    } on FfiException catch(e) {
      print(e.message);
      return e.message.toString();
    }
  }

  sync() async {
    try{
      print("Syncing Wallet");
      await loaderApi.syncWallet();
    } on FfiException catch(e) {
      print(e.message);
    }
  }

  Future<List<Transaction>> getAllTransactions() async{
    final res = await loaderApi.getTransactions();
    return res;
  }
  Future<List<Transaction>> getPendingTransactions() async {
    List<Transaction>  unConfirmed = [];
    final res = await getAllTransactions();
    for (var e in res) {
      e.maybeMap(orElse:() {},
          unconfirmed: (e) {
            unConfirmed.add(e);
          });
    }
    return unConfirmed;
  }
  Future<List<Transaction>> getConfirmedTransactions() async {
    List<Transaction>  confirmed = [];
    final res = await getAllTransactions();
    for (var e in res) {
      e.maybeMap(orElse:() {},
          confirmed: (e) {
            confirmed.add(e);
          });
    }
    return confirmed;
  }
  Future<String> broadcastTransaction({required String recipient, required int amount, required double feeRate}) async{
    try  {
      final res = await loaderApi.createTransaction(
          recipient: recipient, amount: amount, feeRate: feeRate);
      final txid = await loaderApi.signAndBroadcast(psbtStr: res);
      return txid;
    }on FfiException catch(e) {
      print(e.message);
      return e.message.toString();
    }
  }
}

Future<String> generateMnemonic({ WordCount wordCount= WordCount.Words12,Entropy entropy = Entropy.Entropy128}) async {
  try{
    var res = await loaderApi.generateMnemonicSeed(wordCount: wordCount.name.toString(), entropy: entropy.name.toString());
    return res;
  } on FfiException catch(e) {
    print(e.message);
    return e.message.toString();
  }
}
Future<String> createXprv({required Network network,  required String mnemonic, String ? password = ''}) async {
  try{
    var res = await createExtendedKey(network: network, mnemonic: mnemonic, password: password.toString());
    return res.xprv.toString();
  } on FfiException catch(e) {
    print(e.message);
    return e.message.toString();
  }
}

Future<ExtendedKeyInfo> createExtendedKey({required Network network, required String mnemonic, String ? password = ''}) async {
  var res = await loaderApi.createKey(nodeNetwork: network.name.toString(), mnemonic: mnemonic,password: password.toString());
  return res;
}

String createChangeDescriptor( String descriptor){
  return  descriptor.replaceAll("/84'/1'/0'/0/*", "/84'/1'/0'/1/*");
}

String createDescriptor({String? xprv, ExtendedKeyInfo? keyInfo,  Descriptor? descriptor}){
  if(keyInfo == null&& (xprv==null||xprv.isEmpty)) throw Exception("Missing both keyInfo and xprv");
  var xprvStr = xprv?? keyInfo?.xprv;
  switch(descriptor) {
    case Descriptor.P2PKH: return "pkh($xprvStr/84'/1'/0'/0/*)";
    case Descriptor.P2WPKH: return "wpkh($xprvStr/84'/1'/0'/0/*)";
    case Descriptor.P2PK: return "wpkh($xprvStr/84'/1'/0'/0/*)";
    case Descriptor.P2SHP2WPKH: return "sh(wpkh($xprvStr/84'/1'/0'/0/*))";
    case Descriptor.P2SHP2WSHP2PKH: return "sh(wsh(pkh($xprvStr/84'/1'/0'/0/*)))";
    default: return  "wpkh($xprvStr/84'/1'/0'/0/*)";
  }
}
