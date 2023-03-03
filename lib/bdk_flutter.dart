///A Flutter library for the [Bitcoin Development Kit](https://bitcoindevkit.org/).
library bdk_flutter;

export './src/generated/bridge_definitions.dart'
    hide
        BlockchainInstance,
        WalletInstance,
        Rust,
        BlockchainConfig_Electrum,
        BlockchainConfig_Rpc,
        BlockchainConfig_Esplora,
        DatabaseConfig_Memory,
        DatabaseConfig_Sqlite,
        AddressIndex_Reset,
        AddressIndex_Peek,
        AddressIndex_New,
        AddressIndex_LastUnused,
        BdkDescriptor,
        DatabaseConfig_Sled;

export './src/root.dart';
