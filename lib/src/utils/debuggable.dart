import 'dart:ffi';
import 'dart:io';

const String _kMacOSTestDylib = 'macos/librust_bdk_ffi.dylib';
const String _kWindowsTestLib = 'windows/librust_bdk_ffi.dll';
const String _kLinuxTestLib = 'linux/librust_bdk_ffi.so';

DynamicLibrary get testLoaderApi {
  final path = Directory.current;
  if (path.path.endsWith('example')) {
    return DynamicLibrary.open('../${_getByPlatformFileName()}');
  } else {
    return DynamicLibrary.open(_getByPlatformFileName());
  }
}

String _getByPlatformFileName() {
  if (Platform.isMacOS) {
    return _kMacOSTestDylib;
  } else if (Platform.isWindows) {
    return _kWindowsTestLib;
  } else if (Platform.isLinux) {
    return _kLinuxTestLib;
  } else {
    throw Exception("not support platform:${Platform.operatingSystem}");
  }
}
