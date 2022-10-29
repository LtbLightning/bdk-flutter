import '../../bdk_flutter.dart';
final defaultConfig = BlockchainConfig.electrum(
    config: ElectrumConfig(
        stopGap: 10,
        timeout: 5,
        retry: 5,
        url: "ssl://electrum.blockstream.info:60002"));