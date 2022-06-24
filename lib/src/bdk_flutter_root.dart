

import 'package:bdk_flutter/src/enums/blockchain_enum.dart';
import 'package:bdk_flutter/src/enums/network_enum.dart';

import 'bdk_flutter_platform_interface.dart';

class BdkWallet {

  Future<String?> getNewAddress() {
    return BdkFlutterPlatform.instance.getNewAddress();
  }

  Future<String?> genSeed() {
    return BdkFlutterPlatform.instance.genSeed();
  }
  Future<String?> createAndSign ({required String recipient, required double amount}) {
    return BdkFlutterPlatform.instance.createAndSign( amount:amount, recipient: recipient);
  }

  Future<bool?> walletExists() {
    return BdkFlutterPlatform.instance.walletExists();
  }

  Future<bool?> unlockWallet() {
    return BdkFlutterPlatform.instance.unlockWallet();
  }

  Future<bool?> resetWallet() {
    return BdkFlutterPlatform.instance.resetWallet();
  }

  Future<String?> getBalance() async {
    return BdkFlutterPlatform.instance.getBalance();
  }

  sync() {
    return BdkFlutterPlatform.instance.sync();
  }

  Future<dynamic> getWallet() async {
    var res = BdkFlutterPlatform.instance.getWallet();
    print(res);
    return BdkFlutterPlatform.instance.getWallet();
  }

  Future<dynamic> restoreWallet({
    String? password,
    required String mnemonic,
    Network? network,
    Blockchain? blockChain,
    String? blockChainConfigUrl,
    String? blockChainSocket5,
  }) {
    return BdkFlutterPlatform.instance.restoreWallet(
        password: password,
        mnemonic: mnemonic,
        network: network,
        blockChain: blockChain,
        blockChainConfigUrl: blockChainConfigUrl,
        blockChainSocket5: blockChainConfigUrl);
  }

  Future<dynamic> createWallet(
      {String? password,
        required String mnemonic,
        Network? network,
        String? blockChainConfigUrl,
        Blockchain? blockChain,
        String? blockChainSocket5,
        String? retry,
        String? timeOut}) {
    return BdkFlutterPlatform.instance.createWallet(
        password: password,
        mnemonic: mnemonic,
        network: network,
        blockChain: blockChain,
        blockChainConfigUrl: blockChainConfigUrl,
        blockChainSocket5: blockChainConfigUrl,
        timeOut: timeOut,
        retry: retry);
  }

  Future<List<dynamic>?> getPendingTransactions() {
    return BdkFlutterPlatform.instance.getPendingTransactions();
  }

  Future<List<dynamic>?> getConfirmedTransactions() {
    return BdkFlutterPlatform.instance.getConfirmedTransactions();
  }

  Future<dynamic> broadcastTransaction(
      {required String recipient, required double amount}) {
    return BdkFlutterPlatform.instance
        .broadcastTransaction(recipient: recipient, amount: amount);
  }
}
