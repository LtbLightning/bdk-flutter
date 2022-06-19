import 'package:bdk_flutter/src/enums/blockchain_enum.dart';
import 'package:bdk_flutter/src/enums/network_enum.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'bdk_flutter_method_channel.dart';

abstract class BdkFlutterPlatform extends PlatformInterface {
  /// Constructs a BdkFlutterPlatform.
  BdkFlutterPlatform() : super(token: _token);

  static final Object _token = Object();

  static BdkFlutterPlatform _instance = MethodChannelBdkFlutter();

  /// The default instance of [BdkFlutterPlatform] to use.
  ///
  /// Defaults to [MethodChannelBdkFlutter].
  static BdkFlutterPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [BdkFlutterPlatform] when
  /// they register themselves.
  static set instance(BdkFlutterPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<String?> getNewAddress() async {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<String?> genSeed() async {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<bool?> walletExists() async {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<bool?> unlockWallet() async {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<bool?> resetWallet() async {
    throw UnimplementedError('resetWallet() has not been implemented.');
  }

  Future<String?> getWallet() async {
    throw UnimplementedError(' getWallet() has not been implemented.');
  }

  Future<String?> getBalance() async {
    throw UnimplementedError(' getBalance() has not been implemented.');
  }

  Future<dynamic> createWallet(
      {String? password,
      required String mnemonic,
      Network? network,
      String? blockChainConfigUrl,
      Blockchain? blockChain,
      String? blockChainSocket5,
      String? retry,
      String? timeOut}) async {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<dynamic> restoreWallet({
    String? password,
    required String mnemonic,
    Network? network,
    String? blockChainConfigUrl,
    Blockchain? blockChain,
    String? blockChainSocket5,
  }) {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<dynamic> broadcastTransaction(
      {required String recipient, required double amount}) {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  sync() async {
    throw UnimplementedError(' getWallet() has not been implemented.');
  }

  Future<List<dynamic>?> getPendingTransactions() async {
    throw UnimplementedError(
        'getPendingTransactions has not been implemented.');
  }

  Future<List<dynamic>?> getConfirmedTransactions() async {
    throw UnimplementedError(
        'getConfirmedTransactions has not been implemented.');
  }
}
