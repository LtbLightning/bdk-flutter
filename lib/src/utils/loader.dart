import 'dart:ffi';
import 'dart:io';

import '../generated/bindings.dart';

final dylib = Platform.isIOS
    ? DynamicLibrary.process()
    : DynamicLibrary.open('libbdk.so');
final loaderApi = RustImpl(dylib);
