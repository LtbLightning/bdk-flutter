
import 'flutter_bdk_platform_interface.dart';

class FlutterBdk {
  Future<String?> getPlatformVersion() {
    return FlutterBdkPlatform.instance.getPlatformVersion();
  }
}
