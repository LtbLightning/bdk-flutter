import 'dart:ffi';
import 'dart:io';
import 'dart:convert' show json, utf8  ;
import 'package:bdk_flutter/bridge_generated.dart';
import 'package:bdk_flutter/src/enums/blockchain_enum.dart';
import 'package:bdk_flutter/src/enums/network_enum.dart';
import 'package:ffi/ffi.dart';

import 'bdk_flutter_platform_interface.dart';



class BdkWallet {
  final path = 'librust.so';
  late final dylib = Platform.isIOS
      ? DynamicLibrary.process()
      : Platform.isMacOS
      ? DynamicLibrary.executable()
      : DynamicLibrary.open(path);
  late final api = RustImpl(dylib);



  Future<String?> getNewAddress() async {
    var arguments = {"": ""};
    var res= await  api.handleRust(function: "get_new_address", arguments: json.encode(arguments));
    return res;
  }

  Future<String?> generateSeed(Network network) async {
    var arguments = {"network": network.name.toString()};
    var res= await  api.handleRust(function: "generate_seed", arguments: json.encode(arguments));
    print(res);
    return res;
  }

  Future<String?> getBalance() async {
    var arg = {"":""};
    var resp= await  api.handleRust(function: "get_balance", arguments: json.encode(arg));
    return resp;
  }

  Future<dynamic> getWallet() async {
    var arg = {"":""};
    var resp= await  api.handleRust(function: "get_wallet", arguments: json.encode(arg));
    return resp;
  }
  Future<dynamic> getNetwork() async {
    var arg = {"":""};
    var resp= await  api.handleRust(function: "get_network", arguments: json.encode(arg));
    print(resp);
    return resp;
  }
  Future<dynamic> restoreWallet(
      {String? password,
        required String mnemonic,
        required Network network,
        String? blockChainConfigUrl,
        Blockchain? blockChain,
        String? socket5,
      }) async {
    var arguments = {
      "network": network.name.toString(),
      "mnemonic":mnemonic,
      "blockchain_type": blockChain!.name,
      "url":blockChainConfigUrl,
      "socket5": socket5};
    var jStr = json.encode(arguments);
    var resp= await api.handleRust(function: "create_or_restore", arguments: jStr );
    return resp;
  }

  Future<dynamic> createWallet(
      {String? password,
        required String mnemonic,
        required Network network,
        String? blockChainConfigUrl,
        Blockchain? blockChain,
        String? socket5,
      }) async {

    var arguments = {
      "network": network.name.toString(),
      "mnemonic":mnemonic,
      "blockchain_type": blockChain!.name,
      "url":blockChainConfigUrl,
      "socket5": socket5};
    var resp= await  api.handleRust(function: "create_or_restore", arguments: json.encode(arguments));
    return resp;
  }

  Future<String> getPendingTransactions() async {
    var arg = {"":""};
    var resp= await  api.handleRust(function: "get_transactions", arguments: json.encode(arg));
    print(resp);
    return resp;
  }

  Future<List<dynamic>?> getConfirmedTransactions() {
    return BdkFlutterPlatform.instance.getConfirmedTransactions();
  }
  Future<dynamic> sync() async {
    var arg = {"":""};
    var resp= await  api.handleRust(function: "sync", arguments: json.encode(arg));
    return resp;
  }
  Future<dynamic> broadcastTransaction(
      {required String recipient, required double amount}) {
    return BdkFlutterPlatform.instance
        .broadcastTransaction(recipient: recipient, amount: amount);
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
}
