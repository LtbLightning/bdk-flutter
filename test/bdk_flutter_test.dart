import 'package:bdk_flutter/src/bdk_flutter_method_channel.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bdk_flutter/bdk_flutter.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockBdkFlutterPlatform
    with MockPlatformInterfaceMixin
    implements BdkFlutterPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Future<String?> getNewAddress() => Future.value('42');

  @override
  Future<Map<String, dynamic>?> createWallet(
      {String? password,
      required String mnemonic,
      Network? network,
      Blockchain? blockChain,
      String? blockChainConfigUrl,
      String? blockChainSocket5,
      String? retry,
      String? timeOut}) {
    // TODO: implement createWallet
    throw UnimplementedError();
  }

  @override
  Future<String?> genSeed() {
    // TODO: implement genSeed
    throw UnimplementedError();
  }

  @override
  Future<String?> getBalance() {
    // TODO: implement getBalance
    throw UnimplementedError();
  }


  @override
  Future<bool?> resetWallet() {
    // TODO: implement resetWallet
    throw UnimplementedError();
  }

  @override
  Future<bool?> unlockWallet() {
    // TODO: implement unlockWallet
    throw UnimplementedError();
  }

  @override
  Future<bool?> walletExists() {
    // TODO: implement walletExists
    throw UnimplementedError();
  }

  @override
  Future broadcastTransaction(
      {required String recipient, required double amount}) {
    // TODO: implement broadcastTransaction
    throw UnimplementedError();
  }

  @override
  Future restoreWallet(
      {String? password,
      required String mnemonic,
      Network? network,
      Blockchain? blockChain,
      String? blockChainConfigUrl,
      String? blockChainSocket5,
      String? retry,
      String? timeOut}) {
    // TODO: implement restoreWallet
    throw UnimplementedError();
  }

  @override
  sync() {
    // TODO: implement sync
    throw UnimplementedError();
  }

  @override
  Future<List?> getConfirmedTransactions() {
    // TODO: implement getConfirmedTransactions
    throw UnimplementedError();
  }

  @override
  Future<List?> getPendingTransactions() {
    // TODO: implement getPendingTransactions
    throw UnimplementedError();
  }

  @override
  Future<String?> createAndSign({required String recipient, required double amount}) {
    // TODO: implement createAndSign
    throw UnimplementedError();
  }

  @override
  Future<Map<String, dynamic>> getWallet() {
    // TODO: implement getWallet
    throw UnimplementedError();
  }
}

void main() {
  final BdkFlutterPlatform initialPlatform = BdkFlutterPlatform.instance;

  test('$MethodChannelBdkFlutter is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelBdkFlutter>());
  });

  test('getPlatformVersion', () async {
    BdkWallet bdkFlutterPlugin = BdkWallet();
    MockBdkFlutterPlatform fakePlatform = MockBdkFlutterPlatform();
    BdkFlutterPlatform.instance = fakePlatform;


  });
}
