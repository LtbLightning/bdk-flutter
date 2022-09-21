import 'dart:ffi';
import 'dart:io';
import '../generated/bindings.dart';


final dylib = Platform.isIOS
    ? DynamicLibrary.process()
    : Platform.isMacOS
? DynamicLibrary.open('macos/librust.dylib')
//     ? DynamicLibrary.executable()
    : DynamicLibrary.open('librust.so');
final loaderApi = RustImpl(dylib);