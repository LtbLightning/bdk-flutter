import 'dart:ffi';
import 'dart:io';

import 'package:ffi/ffi.dart';

final DynamicLibrary nativeLib = _open();

DynamicLibrary _open() {
  if (Platform.isMacOS) {
    return DynamicLibrary.open("librust.dylib");
  } else if (Platform.isAndroid) {
    return DynamicLibrary.open("librust.so");
  }
  else {
    return DynamicLibrary.process();
  }
}

typedef _FreeStringFunc = void Function(Pointer<Utf8>);
typedef _FreeStringFuncNative = Void Function(Pointer<Utf8>);

late final loader = _Loader._();

class _Loader {
  _Loader._();

  late final _FreeStringFunc freeCString = nativeLib
      .lookupFunction<_FreeStringFuncNative, _FreeStringFunc>("rust_cstr_free");

  Pointer<Uint8> uint8ListToArray(List<int>? list) {
    if (list == null) {
      return nullptr;
    }
    final ptr = calloc.allocate<Uint8>(list.length);
    for (var i = 0; i < list.length; i++) {
      ptr.elementAt(i).value = list[i];
    }
    return ptr;
  }

  List<int> uint8ArrayToList(Pointer<Uint8> pointer, int length) {
    List<int> result = List.filled(length, 0);
    for (var i = 0; i < length; i++) {
      result[i] = pointer.elementAt(i).value;
    }
    return result;
  }

  Pointer<Uint16> uint16ListToArray(List<int> list) {
    final ptr = calloc.allocate<Uint16>(list.length);
    for (var i = 0; i < list.length; i++) {
      ptr.elementAt(i).value = list[i];
    }
    return ptr;
  }

  Pointer<Uint32> uint32ListToArray(List<int> list) {
    final ptr = calloc.allocate<Uint32>(list.length);
    for (var i = 0; i < list.length; i++) {
      ptr.elementAt(i).value = list[i];
    }
    return ptr;
  }

  void freeCStrings(List<Pointer<Utf8>> pointerList) {
    for (Pointer<Utf8> element in pointerList) {
      freeCString(element);
    }
  }

  void freePointer<T extends NativeType>(Pointer<T> pointer) {
    calloc.free(pointer);
  }

  void freePointerList<T extends NativeType>(List<Pointer<T>> pointerList) {
    for (Pointer<T> element in pointerList) {
      calloc.free(element);
    }
  }
}

/// Wrap the error with uninit
class UnInitializationError extends Error {
  final Object? message;

  UnInitializationError([this.message]);

  @override
  String toString() {
    if (message != null) {
      return "UnInitialized error: ${Error.safeToString(message)}";
    }
    return "UnInitialized error";
  }
}