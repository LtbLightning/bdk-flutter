import 'dart:ffi';
import 'dart:io';

import '../generated/bindings.dart';

DynamicLibrary _open() {
  if (Platform.isMacOS) {
    return DynamicLibrary.executable();
  } else if (Platform.isAndroid) {
    return DynamicLibrary.open("librust_bdk_ffi.so");
  } else if (Platform.isWindows) {
    return DynamicLibrary.open("librust_bdk_ffi.dll");
  } else {
    return DynamicLibrary.process();
  }
}

final loaderApi = RustBdkFfiImpl(_open());
