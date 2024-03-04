import 'package:flutter/cupertino.dart';

import '../frb/generated/frb_generated.dart';

export 'exceptions.dart';

class Frb {
  static Future<void> verifyInit() async {
    try {
      if (!BdkCore.instance.initialized) {
        await BdkCore.init();
      }
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(
          "Failed to initialize bdk-flutter: Ensure that BdkConfig.initialize() is called and awaited (if in an async environment) before using bdk-flutter service.");
    }
  }
}
