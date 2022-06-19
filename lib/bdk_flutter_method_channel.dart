import 'dart:collection';

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
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
  @override
  Future<String?>  getNewAddress() async {
    final String? result = await methodChannel.invokeMethod('getNewAddress');
    return result;
  }
  @override
  Future<String?> genSeed() async {
    final response = await methodChannel.invokeMethod<String>('genSeed');
    return response;
  }
   @override
  Future<String?> getWallet() async {
    final response = await methodChannel.invokeMethod<String>('getWallet');
    return response;
  }
  @override
  Future<bool?> walletExists() async {
    final response = await methodChannel.invokeMethod<bool>('walletExists');
    return response;
  }
  @override
  Future<bool?> unlockWallet() async {
    final response = await methodChannel.invokeMethod<bool>('unlockWallet');
    return response;
  }
  @override
  Future<bool?> resetWallet() async {
    final response = await methodChannel.invokeMethod<bool>('resetWallet');
    return response;
  }
  @override
  createWallet({String? password, required String? mnemonic}) async {
    Map<String, dynamic>  arguments = {"password": password, "mnemonic":
    mnemonic};
    final response = await methodChannel.invokeMethod(
        'createWallet', arguments);
    return response;
  }
  @override
  Future<List<dynamic>?>getTransactions() async {
    final response = await methodChannel.invokeMethod('getTransactions');
    return response;
  }
   @override
   Future<String?> getBalance() async {
     final  result = await methodChannel.invokeMethod('getBalance');
    return result.toString();
   }
  @override
  Future<dynamic> restoreWallet({String? password, required String mnemonic})
  async{
    Map<String, dynamic>  arguments = {"password": password, "mnemonic":
    mnemonic};
    final response = await methodChannel.invokeMethod(
        'restoreWallet', arguments);
    return response;
  }
  @override
  Future<dynamic> broadcastTransaction({required String recipient, required  double
  amount})  async{
    Map<String, dynamic>  arguments = {"recipient": recipient, "amount":
    amount};
    final response = await methodChannel.invokeMethod(
        'broadcastTx', arguments);
    return response;
  }
  @override
  sync() async {
   final  result = await methodChannel.invokeMethod('sync');
    return result.toString();
  }
//   static Future<Map<String, dynamic>?> restoreWallet(
//       {String? password, required String? mnemonic}) async {
//     Map arguments = {"password": password, "mnemonic": mnemonic};
//     final response = await methodChannel.invokeMethod<Map<String, dynamic>>(
//         'restoreWallet', arguments);
//     return response;
//   }

//   static Future<bool?> resetWallet() async {
//     final response = await methodChannel.invokeMethod<bool>('resetWallet');
//     return response;
//   }

//   static Future<Map<String, dynamic>?> getBalance() async {
//     final response =
//         await methodChannel.invokeMethod<Map<String, dynamic>>('getBalance');
//     return response;
//   }



//   static Future<Map<String, dynamic>?> broadcastTx(
//       {required String address, required int amount}) async {
//     Map arguments = {"address": address, "amount": amount};

//     final response = await methodChannel.invokeMethod<Map<String, dynamic>>(
//         'broadcastTx', arguments);
//     return response;
//   }
}
