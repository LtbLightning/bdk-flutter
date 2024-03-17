// This file is automatically generated, so please do not edit it.
// Generated by `flutter_rust_bridge`@ 2.0.0-dev.25.

// ignore_for_file: invalid_use_of_internal_member, unused_import, unnecessary_import

import '../frb_generated.dart';
import 'blockchain.dart';
import 'error.dart';
import 'key.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge_for_generated.dart';
import 'types.dart';

// Rust type: RustOpaqueNom<flutter_rust_bridge::for_generated::rust_async::RwLock<Arc < keys :: DescriptorPublicKey >>>
@sealed
class ArcKeysDescriptorPublicKey extends RustOpaque {
  ArcKeysDescriptorPublicKey.dcoDecode(List<dynamic> wire)
      : super.dcoDecode(wire, _kStaticData);

  ArcKeysDescriptorPublicKey.sseDecode(int ptr, int externalSizeOnNative)
      : super.sseDecode(ptr, externalSizeOnNative, _kStaticData);

  static final _kStaticData = RustArcStaticData(
    rustArcIncrementStrongCount: BdkCore.instance.api
        .rust_arc_increment_strong_count_ArcKeysDescriptorPublicKey,
    rustArcDecrementStrongCount: BdkCore.instance.api
        .rust_arc_decrement_strong_count_ArcKeysDescriptorPublicKey,
    rustArcDecrementStrongCountPtr: BdkCore.instance.api
        .rust_arc_decrement_strong_count_ArcKeysDescriptorPublicKeyPtr,
  );
}

// Rust type: RustOpaqueNom<flutter_rust_bridge::for_generated::rust_async::RwLock<Arc < keys :: DescriptorSecretKey >>>
@sealed
class ArcKeysDescriptorSecretKey extends RustOpaque {
  ArcKeysDescriptorSecretKey.dcoDecode(List<dynamic> wire)
      : super.dcoDecode(wire, _kStaticData);

  ArcKeysDescriptorSecretKey.sseDecode(int ptr, int externalSizeOnNative)
      : super.sseDecode(ptr, externalSizeOnNative, _kStaticData);

  static final _kStaticData = RustArcStaticData(
    rustArcIncrementStrongCount: BdkCore.instance.api
        .rust_arc_increment_strong_count_ArcKeysDescriptorSecretKey,
    rustArcDecrementStrongCount: BdkCore.instance.api
        .rust_arc_decrement_strong_count_ArcKeysDescriptorSecretKey,
    rustArcDecrementStrongCountPtr: BdkCore.instance.api
        .rust_arc_decrement_strong_count_ArcKeysDescriptorSecretKeyPtr,
  );
}

// Rust type: RustOpaqueNom<flutter_rust_bridge::for_generated::rust_async::RwLock<ExtendedDescriptor>>
@sealed
class ExtendedDescriptor extends RustOpaque {
  ExtendedDescriptor.dcoDecode(List<dynamic> wire)
      : super.dcoDecode(wire, _kStaticData);

  ExtendedDescriptor.sseDecode(int ptr, int externalSizeOnNative)
      : super.sseDecode(ptr, externalSizeOnNative, _kStaticData);

  static final _kStaticData = RustArcStaticData(
    rustArcIncrementStrongCount:
        BdkCore.instance.api.rust_arc_increment_strong_count_ExtendedDescriptor,
    rustArcDecrementStrongCount:
        BdkCore.instance.api.rust_arc_decrement_strong_count_ExtendedDescriptor,
    rustArcDecrementStrongCountPtr: BdkCore
        .instance.api.rust_arc_decrement_strong_count_ExtendedDescriptorPtr,
  );
}

// Rust type: RustOpaqueNom<flutter_rust_bridge::for_generated::rust_async::RwLock<keys :: KeyMap>>
@sealed
class KeysKeyMap extends RustOpaque {
  KeysKeyMap.dcoDecode(List<dynamic> wire)
      : super.dcoDecode(wire, _kStaticData);

  KeysKeyMap.sseDecode(int ptr, int externalSizeOnNative)
      : super.sseDecode(ptr, externalSizeOnNative, _kStaticData);

  static final _kStaticData = RustArcStaticData(
    rustArcIncrementStrongCount:
        BdkCore.instance.api.rust_arc_increment_strong_count_KeysKeyMap,
    rustArcDecrementStrongCount:
        BdkCore.instance.api.rust_arc_decrement_strong_count_KeysKeyMap,
    rustArcDecrementStrongCountPtr:
        BdkCore.instance.api.rust_arc_decrement_strong_count_KeysKeyMapPtr,
  );
}

class DescriptorBase {
  final ExtendedDescriptor extendedDescriptor;
  final KeysKeyMap keyMap;

  const DescriptorBase({
    required this.extendedDescriptor,
    required this.keyMap,
  });

  Future<String> asString({dynamic hint}) =>
      BdkCore.instance.api.descriptorBaseAsString(
        that: this,
      );

  Future<String> asStringPrivate({dynamic hint}) =>
      BdkCore.instance.api.descriptorBaseAsStringPrivate(
        that: this,
      );

  Future<int> maxSatisfactionWeight({dynamic hint}) =>
      BdkCore.instance.api.descriptorBaseMaxSatisfactionWeight(
        that: this,
      );

  static Future<DescriptorBase> newDescriptorBase(
          {required String descriptor,
          required Network network,
          dynamic hint}) =>
      BdkCore.instance.api.descriptorBaseNew(
          descriptor: descriptor, network: network, hint: hint);

  static Future<DescriptorBase> newBip44(
          {required DescriptorSecretKeyBase secretKey,
          required KeychainKind keychainKind,
          required Network network,
          dynamic hint}) =>
      BdkCore.instance.api.descriptorBaseNewBip44(
          secretKey: secretKey,
          keychainKind: keychainKind,
          network: network,
          hint: hint);

  static Future<DescriptorBase> newBip44Public(
          {required DescriptorPublicKeyBase publicKey,
          required String fingerprint,
          required KeychainKind keychainKind,
          required Network network,
          dynamic hint}) =>
      BdkCore.instance.api.descriptorBaseNewBip44Public(
          publicKey: publicKey,
          fingerprint: fingerprint,
          keychainKind: keychainKind,
          network: network,
          hint: hint);

  static Future<DescriptorBase> newBip49(
          {required DescriptorSecretKeyBase secretKey,
          required KeychainKind keychainKind,
          required Network network,
          dynamic hint}) =>
      BdkCore.instance.api.descriptorBaseNewBip49(
          secretKey: secretKey,
          keychainKind: keychainKind,
          network: network,
          hint: hint);

  static Future<DescriptorBase> newBip49Public(
          {required DescriptorPublicKeyBase publicKey,
          required String fingerprint,
          required KeychainKind keychainKind,
          required Network network,
          dynamic hint}) =>
      BdkCore.instance.api.descriptorBaseNewBip49Public(
          publicKey: publicKey,
          fingerprint: fingerprint,
          keychainKind: keychainKind,
          network: network,
          hint: hint);

  static Future<DescriptorBase> newBip84(
          {required DescriptorSecretKeyBase secretKey,
          required KeychainKind keychainKind,
          required Network network,
          dynamic hint}) =>
      BdkCore.instance.api.descriptorBaseNewBip84(
          secretKey: secretKey,
          keychainKind: keychainKind,
          network: network,
          hint: hint);

  static Future<DescriptorBase> newBip84Public(
          {required DescriptorPublicKeyBase publicKey,
          required String fingerprint,
          required KeychainKind keychainKind,
          required Network network,
          dynamic hint}) =>
      BdkCore.instance.api.descriptorBaseNewBip84Public(
          publicKey: publicKey,
          fingerprint: fingerprint,
          keychainKind: keychainKind,
          network: network,
          hint: hint);

  static Future<DescriptorBase> newBip86(
          {required DescriptorSecretKeyBase secretKey,
          required KeychainKind keychainKind,
          required Network network,
          dynamic hint}) =>
      BdkCore.instance.api.descriptorBaseNewBip86(
          secretKey: secretKey,
          keychainKind: keychainKind,
          network: network,
          hint: hint);

  static Future<DescriptorBase> newBip86Public(
          {required DescriptorPublicKeyBase publicKey,
          required String fingerprint,
          required KeychainKind keychainKind,
          required Network network,
          dynamic hint}) =>
      BdkCore.instance.api.descriptorBaseNewBip86Public(
          publicKey: publicKey,
          fingerprint: fingerprint,
          keychainKind: keychainKind,
          network: network,
          hint: hint);

  @override
  int get hashCode => extendedDescriptor.hashCode ^ keyMap.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DescriptorBase &&
          runtimeType == other.runtimeType &&
          extendedDescriptor == other.extendedDescriptor &&
          keyMap == other.keyMap;
}