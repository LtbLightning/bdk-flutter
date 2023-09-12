import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bdk/flutter_bdk.dart';
import 'package:flutter_bdk/flutter_bdk_platform_interface.dart';
import 'package:flutter_bdk/flutter_bdk_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterBdkPlatform
    with MockPlatformInterfaceMixin
    implements FlutterBdkPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FlutterBdkPlatform initialPlatform = FlutterBdkPlatform.instance;

  test('$MethodChannelFlutterBdk is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterBdk>());
  });

  test('getPlatformVersion', () async {
    FlutterBdk flutterBdkPlugin = FlutterBdk();
    MockFlutterBdkPlatform fakePlatform = MockFlutterBdkPlatform();
    FlutterBdkPlatform.instance = fakePlatform;

    expect(await flutterBdkPlugin.getPlatformVersion(), '42');
  });
}
