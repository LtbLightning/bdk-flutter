import 'dart:collection';
import 'package:bdk_flutter/src/enums/blockchain_enum.dart';
import 'package:bdk_flutter/src/enums/network_enum.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'bdk_flutter_platform_interface.dart';

/// An implementation of [BdkFlutterPlatform] that uses method channels.
class MethodChannelBdkFlutter extends BdkFlutterPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('bdk_flutter');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
    await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<String?> getNewAddress() async {
    final String? result = await methodChannel.invokeMethod('getNewAddress');
    return result;
  }

  @override
  Future<String?> genSeed() async {
    final response = await methodChannel.invokeMethod<String>('genSeed');
    return response;
  }

  @override
  Future<dynamic> getWallet() async {
    final response = await methodChannel.invokeMethod<dynamic>('getWallet');
    return response;
  }
  @override
  Future<String?> createAndSign({required String recipient, required double amount}) async {
    Map<String, dynamic> arguments = {"recipient": recipient, "amount": amount};
    final response = await methodChannel.invokeMethod<String>('createAndSign', arguments );
    return response;
  }

  @override
  Future<bool?> walletExists() async {
    final response = await methodChannel.invokeMethod<bool>('walletExists');
    return response;
  }

  @override
  Future<bool?> resetWallet() async {
    final response = await methodChannel.invokeMethod('resetWallet');
    return response;
  }

  @override
  createWallet(
      {String? password,
        required String mnemonic,
        Network? network,
        Blockchain? blockChain,
        String? blockChainConfigUrl,
        String? blockChainSocket5,
        String? retry,
        String? timeOut}) async {
    Map<String, dynamic> arguments = {
      "password": password,
      "mnemonic": mnemonic,
      "network": network.toString(),
      "blockChainConfigUrl": blockChainConfigUrl,
      "blockChainSocket5": blockChainSocket5,
      "retry": retry,
      "timeOut": timeOut,
      "blockChain": blockChain.toString(),
    };
    final response =
    await methodChannel.invokeMethod('createWallet', arguments);
    return response;
  }

  @override
  Future<List<dynamic>?> getPendingTransactions() async {
    final response = await methodChannel.invokeMethod('getPendingTransactions');
    return response;
  }

  @override
  Future<List<dynamic>?> getConfirmedTransactions() async {
    final response =
    await methodChannel.invokeMethod('getConfirmedTransactions');
    return response;
  }

  @override
  Future<String?> getBalance() async {
    final result = await methodChannel.invokeMethod('getBalance');
    return result.toString();
  }

  @override
  Future<dynamic> restoreWallet({
    String? password,
    required String mnemonic,
    Network? network,
    Blockchain? blockchain,
    String? blockChainConfigUrl,
    Blockchain? blockChain,
    String? blockChainSocket5,
  }) async {
    Map<String, dynamic> arguments = {
      "password": password,
      "mnemonic": mnemonic,
      "network": network.toString(),
      "blockChainConfigUrl": blockChainConfigUrl,
      "blockChainSocket5": blockChainSocket5,
      "blockChain": blockChain.toString(),
    };
    final response =
    await methodChannel.invokeMethod('restoreWallet', arguments);
    return response;
  }

  @override
  Future<dynamic> broadcastTransaction(
      {required String recipient, required double amount}) async {
    Map<String, dynamic> arguments = {"recipient": recipient, "amount": amount};
    final response = await methodChannel.invokeMethod('broadcastTx', arguments);
    return response;
  }

  @override
  sync() async {
    final result = await methodChannel.invokeMethod('sync');
    return result.toString();
  }
}
