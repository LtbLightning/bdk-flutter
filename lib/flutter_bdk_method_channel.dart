import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_bdk_platform_interface.dart';

/// An implementation of [FlutterBdkPlatform] that uses method channels.
class MethodChannelFlutterBdk extends FlutterBdkPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_bdk');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
