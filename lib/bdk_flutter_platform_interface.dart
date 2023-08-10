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
}
