import 'package:bdk_flutter/bdk_flutter.dart';
import 'package:bdk_flutter/src/enums/network_enum.dart';
import 'bridge_generated.dart';
import 'loader.dart';

class BdkWallet {
  Future<void> init(String descriptor, String changeDescriptor, Network network) async {
    await loaderApi.walletInit(descriptor: descriptor, changeDescriptor: changeDescriptor, network: network.name.toString());
  }
  Future<String> getNewAddress() async {
    var res = await loaderApi.getNewAddress();
    return res.toString();
  }
  Future<String> getBalance() async {
    var res = await loaderApi.getBalance();
    return res.toString();
  }
  Future<String> getLastUnusedAddress() async {
    var res = await loaderApi.getLastUnusedAddress();
    return res.toString();
  }

  sync() async {
    print("Syncing Wallet");
    await loaderApi.syncWallet();
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
    final res = await loaderApi.createTransaction(recipient: recipient, amount: amount, feeRate: feeRate);
    final txid= await loaderApi.signAndBroadcast(psbtStr: res);
    return txid;
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