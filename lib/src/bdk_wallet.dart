import 'package:bdk_flutter/bdk_flutter.dart';
import 'package:bdk_flutter/src/enums/entropy.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge.dart';
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
        sync();
      } else {
        var key = await restoreExtendedKey(network:network, mnemonic:mnemonic!.toString());
        var descriptor = createDescriptor(key.xprv);
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

Future<String> generateMnemonic({required Network network, required WordCount wordCount, required Entropy entropy}) async {
  try{
    var res = await generateExtendedKey(network: network, wordCount: wordCount, entropy: entropy);
    return res.mnemonic.toString();
  } on FfiException catch(e) {
    print(e.message);
    return e.message.toString();
  }
}
Future<String> createXprv({required Network network, required WordCount wordCount, required Entropy entropy}) async {
  try{
    var res = await generateExtendedKey(network: network, wordCount: wordCount, entropy: entropy);
    return res.xprv.toString();
  } on FfiException catch(e) {
    print(e.message);
    return e.message.toString();
  }
}

Future<ExtendedKeyInfo> generateExtendedKey({required Network network, required WordCount wordCount, String ? password, required Entropy entropy}) async {
  var res = await loaderApi.generateKey(nodeNetwork: network.name.toString(), wordCount: wordCount.name.toString(), password: password.toString(), entropy: 15);
  return res;
}
Future<ExtendedKeyInfo> restoreExtendedKey(
    {required Network network, required String mnemonic, String ? password}) async {
  var res = await loaderApi.restoreKey(nodeNetwork: network.name.toString(), mnemonic: mnemonic, password: password );
  return res;
}
String createDescriptor( String xprv){
  return  "wpkh($xprv/84'/1'/0'/0/*)";
}
String createChangeDescriptor( String xprv){
  return  "wpkh($xprv/84'/1'/0'/1/*)";
}