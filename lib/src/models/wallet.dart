import 'dart:convert';

import 'package:bdk_flutter/src/enums/blockchain_enum.dart';
import 'package:bdk_flutter/src/enums/network_enum.dart';


class Wallet {
  final String? password;
  final String? mnemonic;
  final Network? network;
  final Blockchain? blockChain;
  final String? blockChainConfigUrl;
  final String? blockChainSocket5;
  final String? retry;
  final String? timeOut;

  Wallet(
      this.password,
      this.mnemonic,
      this.network,
      this.blockChain,
      this.blockChainConfigUrl,
      this.blockChainSocket5,
      this.retry,
      this.timeOut);

  Wallet copyWith({
    String? password,
    String? mnemonic,
    Network? network,
    Blockchain? blockChain,
    String? blockChainConfigUrl,
    String? blockChainSocket5,
    String? retry,
    String? timeOut,
  }) {
    return Wallet(
      password ?? this.password,
      mnemonic ?? this.mnemonic,
      network ?? this.network,
      blockChain ?? this.blockChain,
      blockChainConfigUrl ?? this.blockChainConfigUrl,
      blockChainSocket5 ?? this.blockChainSocket5,
      retry ?? this.retry,
      timeOut ?? this.timeOut,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'password': password,
      'mnemonic': mnemonic,
      'network': network?.toString(),
      'blockChain': blockChain?.toString(),
      'blockChainConfigUrl': blockChainConfigUrl,
      'blockChainSocket5': blockChainSocket5,
      'retry': retry,
      'timeOut': timeOut,
    };
  }

  factory Wallet.fromMap(Map<String, dynamic> map) {
    return Wallet(
      map['password'],
      map['mnemonic'],
      map['network'] != null ? Network.TESTNET : null,
      map['blockChain'] != null ? Blockchain.ELECTRUM : null,
      map['blockChainConfigUrl'],
      map['blockChainSocket5'],
      map['retry'],
      map['timeOut'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Wallet.fromJson(String source) => Wallet.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Wallet(password: $password, mnemonic: $mnemonic, network: $network, blockChain: $blockChain, blockChainConfigUrl: $blockChainConfigUrl, blockChainSocket5: $blockChainSocket5, retry: $retry, timeOut: $timeOut)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Wallet &&
        other.password == password &&
        other.mnemonic == mnemonic &&
        other.network == network &&
        other.blockChain == blockChain &&
        other.blockChainConfigUrl == blockChainConfigUrl &&
        other.blockChainSocket5 == blockChainSocket5 &&
        other.retry == retry &&
        other.timeOut == timeOut;
  }

  @override
  int get hashCode {
    return password.hashCode ^
        mnemonic.hashCode ^
        network.hashCode ^
        blockChain.hashCode ^
        blockChainConfigUrl.hashCode ^
        blockChainSocket5.hashCode ^
        retry.hashCode ^
        timeOut.hashCode;
  }
}
