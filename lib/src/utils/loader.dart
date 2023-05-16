import 'dart:ffi';
import 'dart:io';

import '../generated/bindings.dart';

final dylib = Platform.isIOS
    ? DynamicLibrary.process()
    : DynamicLibrary.open('librust_bdk_ffi.so');
final loaderApi = RustBdkFfiImpl(dylib);
