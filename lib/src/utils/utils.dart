import '../generated/frb_generated.dart';

export 'exceptions.dart';

class LibBdk {
  static Future<void> initialize() async {
    try {
      if (!core.instance.initialized) {
        await core.init();
      }
    } catch (e) {
      debugPrint("Failed to initialize bdk-flutter: $e");
      throw Exception("Failed to initialize bdk-flutter");
    }
  }
}
