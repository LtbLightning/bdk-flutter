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
}
