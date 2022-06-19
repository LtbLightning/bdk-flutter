
import 'bdk_flutter_platform_interface.dart';

class BdkFlutter {
  Future<String?> getPlatformVersion() {
    return BdkFlutterPlatform.instance.getPlatformVersion();
  }
  Future<String?> getNewAddress() {
    return BdkFlutterPlatform.instance.getNewAddress();
  }
  Future<String?> genSeed() {
    return BdkFlutterPlatform.instance.genSeed();
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
   sync()  {
    return BdkFlutterPlatform.instance.sync();
  }
   Future<String?> getWallet() async {
    return BdkFlutterPlatform.instance.getWallet();
  }
  Future<dynamic> restoreWallet({String? password, required String mnemonic}) {
    return BdkFlutterPlatform.instance.restoreWallet(password:password,
        mnemonic:mnemonic);
  }
  Future<dynamic> createWallet({String? password, required String mnemonic}) {
    return BdkFlutterPlatform.instance.createWallet(password:password,
        mnemonic:mnemonic);
  }
  Future<List<dynamic>?> getTransactions() {
    return BdkFlutterPlatform.instance.getTransactions();
  }
  Future<dynamic> broadcastTransaction({required String recipient, required
  double amount}) {
    return BdkFlutterPlatform.instance.broadcastTransaction(recipient:recipient,
        amount:amount);
  }
  
}
