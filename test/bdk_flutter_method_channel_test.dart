import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bdk_flutter/bdk_flutter_method_channel.dart';

void main() {
  MethodChannelBdkFlutter platform = MethodChannelBdkFlutter();
  const MethodChannel channel = MethodChannel('bdk_flutter');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
