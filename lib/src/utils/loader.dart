import 'dart:ffi';
import 'dart:io';

import '../generated/bindings.dart';

final dylib = Platform.isIOS
    ? DynamicLibrary.process()
    : Platform.isMacOS
        //? DynamicLibrary.open('macos/librust_bdk_ffi.dylib')
        ? DynamicLibrary.executable()
        : DynamicLibrary.open('librust_bdk_ffi.so');
final loaderApi = RustBdkFfiImpl(dylib);
