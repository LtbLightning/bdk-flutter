

import 'dart:ffi';
import 'dart:io';
import 'dart:convert' show utf8  ;
import 'package:bdk_flutter/src/enums/blockchain_enum.dart';
import 'package:bdk_flutter/src/enums/network_enum.dart';
import 'package:ffi/ffi.dart';

import 'bdk_flutter_platform_interface.dart';
import 'loader.dart';

typedef RustType = Pointer<Utf8> Function(
    Pointer<Utf8> syncBalance,
    );
typedef DartType = Pointer<Utf8> Function();

class BdkWallet {
  bool isChecked = false;
   getPlatformVersion()  {
  final func = nativeLib.lookupFunction<RustType, RustType>("rust_greeting");
// Prepare the parameters
     final nameStr = "John Smith";
     final Pointer<Utf8> namePtr = nameStr.toNativeUtf8();
     print("- Calling rust_greeting with argument:  $namePtr");

// Call rust_greeting
     final Pointer<Utf8> resultPtr = func(namePtr);
     print("- Result pointer:  $resultPtr");

// Handle the result pointer
     final String greetingStr = resultPtr.toDartString();
     print("- Response string:  $greetingStr");


  }
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
