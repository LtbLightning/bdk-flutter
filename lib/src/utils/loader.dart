import 'dart:ffi';
import 'dart:io';

import '../generated/bindings.dart';
import 'debuggable.dart';

DynamicLibrary _open() {
  if (Platform.environment.containsKey('FLUTTER_TEST') &&
      Platform.environment['FLUTTER_TEST'] == 'true') {
    return testLoaderApi;
  }
  if (Platform.isIOS) {
    return DynamicLibrary.process();
  } else if (Platform.isAndroid) {
    return DynamicLibrary.open("librust_bdk_ffi.so");
  } else if (Platform.isMacOS) {
    return DynamicLibrary.open('librust_bdk_ffi.dylib');
  } else {
    return DynamicLibrary.executable();
  }
}

final loaderApi = RustBdkFfiImpl(_open());
