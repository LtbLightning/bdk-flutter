import '../generated/frb_generated.dart';

export 'exceptions.dart';

class Frb {
  static Future<void> verifyInit() async {
    try {
      if (!BdkCore.instance.initialized) {
        await BdkCore.init();
      }
    } catch (e) {
      throw Exception("Failed to initialize bdk-flutter");
    }
  }
}
