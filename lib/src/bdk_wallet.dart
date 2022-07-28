import 'package:bdk_flutter/src/enums/network_enum.dart';
import 'bridge_generated.dart';
import 'loader.dart';

class BdkWallet {
  final String descriptor;
  final String changeDescriptor;
  final Network network;
  BdkWallet({required this.descriptor, required this.changeDescriptor, required this.network});

  Future<String> getNewAddress() async {
    final obj = WalletObj(descriptor: descriptor, changeDescriptor: changeDescriptor, network: network.name.toString());
    var res = await loaderApi.getNewAddress(wallet: obj);
    return res.toString();
  }

  Future<int> getBalance() async {
    final obj = WalletObj(descriptor: descriptor, changeDescriptor: changeDescriptor, network: network.name.toString());
    var res = await loaderApi.getBalance(wallet: obj);
    return res;
  }

  sync() async {
    final obj = WalletObj(descriptor: descriptor, changeDescriptor: changeDescriptor, network: network.name.toString());
    await  loaderApi.syncWallet(wallet: obj);
  }

  Future<List<Transaction>> getAllTransactions() async{
    final obj = WalletObj(descriptor: descriptor, changeDescriptor: changeDescriptor, network: network.name.toString());
    final res = await loaderApi.getTransactions(wallet: obj);
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
  Future<String> createTransaction() async{
    final obj = WalletObj(descriptor: descriptor, changeDescriptor: changeDescriptor, network: network.name.toString());
    final res = await loaderApi.createTransaction(recipient: "mkHS9ne12qx9pS9VojpwU5xtRd4T7X7ZUt", amount: 1200, feeRate: 1, wallet: obj);
    await loaderApi.signAndBroadcast(wallet: obj, psbtStr: res);
    return res;
  }


}

Future<String> generateSeed(Network network) async {
  var res = await loaderApi.generateKey(nodeNetwork: network.name.toString());
  return res.mnemonic.toString();
}
Future<ExtendedKeyInfo> generateExtendedKey(Network network) async {
  var res = await loaderApi.generateKey(nodeNetwork: network.name.toString());
  return res;
}
Future<ExtendedKeyInfo> restoreExtendedKey(Network network, String mnemonic) async {
  var res = await loaderApi.restoreKey(nodeNetwork: network.name.toString(), mnemonic: mnemonic);
  return res;
}
String createDescriptor( String xprv){
  return  "wpkh($xprv/84'/1'/0'/0/*)";
}
String createChangeDescriptor( String xprv){
  return  "wpkh($xprv/84'/1'/0'/1/*)";
}