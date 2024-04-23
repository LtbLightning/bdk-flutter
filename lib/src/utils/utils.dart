import '../generated/frb_generated.dart';

export 'exceptions.dart';

class Api {
  static Future<void> initialize() async {
    try {
      if (!CApi.instance.initialized) {
        await CApi.init();
      }
    } catch (e) {
      throw Exception("Failed to initialize bdk-flutter");
    }
  }
}
