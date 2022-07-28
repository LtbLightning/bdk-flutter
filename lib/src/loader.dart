import 'dart:ffi';
import 'dart:io';

import 'bridge_generated.dart';

final dylib = Platform.isIOS
    ? DynamicLibrary.process()
    : Platform.isMacOS
    ? DynamicLibrary.executable()
    : DynamicLibrary.open('librust.so');
final loaderApi = RustImpl(dylib);