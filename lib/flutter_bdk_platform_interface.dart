import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_bdk_method_channel.dart';

abstract class FlutterBdkPlatform extends PlatformInterface {
  /// Constructs a FlutterBdkPlatform.
  FlutterBdkPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterBdkPlatform _instance = MethodChannelFlutterBdk();

  /// The default instance of [FlutterBdkPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterBdk].
  static FlutterBdkPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterBdkPlatform] when
  /// they register themselves.
  static set instance(FlutterBdkPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
