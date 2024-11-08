// This file is automatically generated, so please do not edit it.
// @generated by `flutter_rust_bridge`@ 2.4.0.

// ignore_for_file: invalid_use_of_internal_member, unused_import, unnecessary_import

import '../frb_generated.dart';
import 'error.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge_for_generated.dart';

// These functions are ignored because they are not marked as `pub`: `get_store`

// Rust type: RustOpaqueNom<std :: sync :: Mutex < bdk_wallet :: rusqlite :: Connection >>
abstract class MutexConnection implements RustOpaqueInterface {}

class FfiConnection {
  final MutexConnection field0;

  const FfiConnection({
    required this.field0,
  });

  // HINT: Make it `#[frb(sync)]` to let it become the default constructor of Dart class.
  static Future<FfiConnection> newInstance({required String path}) =>
      core.instance.api.crateApiStoreFfiConnectionNew(path: path);

  static Future<FfiConnection> newInMemory() =>
      core.instance.api.crateApiStoreFfiConnectionNewInMemory();

  @override
  int get hashCode => field0.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FfiConnection &&
          runtimeType == other.runtimeType &&
          field0 == other.field0;
}
