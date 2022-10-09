import 'package:bdk_flutter/bdk_flutter.dart';
const DEFAUTLT_DESCRIPTOR_PATH = "m/84'/1'/0'/0";
const DEFAUTLT_CHANGE_DESCRIPTOR_PATH = "m/84'/1'/0'/1";
final DEFAUTL_CONFIG = BlockchainConfig.electrum(
    config: ElectrumConfig(
        stopGap: 10,
        timeout: 5,
        retry: 5,
        url: "ssl://electrum.blockstream.info:60002"));
const DEFAULT_NETWORK = Network.TESTNET;