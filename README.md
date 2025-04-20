### Bdk Flutter

<p>
  <a href="https://github.com/LtbLightning/bdk-flutter/blob/HEAD/LICENSE">
    <img src="https://img.shields.io/badge/license-MIT-blue.svg" alt="BDK is released under the MIT license." />
  </a>
  <a href="https://pub.dev/documentation/bdk_flutter/latest/">
    <img src="https://img.shields.io/badge/docs-red.svg" alt="Docs" />
  </a>
  <a href="https://pub.dev/packages/bdk_flutter">
    <img src="https://img.shields.io/pub/v/bdk_flutter?color=blueviolet" alt="Current pub package version." />
  </a>
    <a href="https://github.com/LtbLightning/bdk-flutter/issues">
    <img src="https://img.shields.io/github/issues/LtbLightning/bdk-flutter.svg" alt="Issues" />
  </a>
  <a href="https://github.com/LtbLightning/bdk-flutter/stargazers">
    <img src="https://img.shields.io/github/stars/LtbLightning/bdk-flutter.svg" alt="Stars" />
  </a>
  <a href="https://github.com/LtbLightning/bdk-flutter/forks">
    <img src="https://img.shields.io/github/forks/LtbLightning/bdk-flutter.svg?color=brightgreen" alt="Forks" />
  </a>
  <a href="https://github.com/LtbLightning/bdk-flutter-quickstart">
    <img src="https://img.shields.io/badge/Demo App-orange" alt="Demo App" />
  </a>
</p>

A Flutter library for the [Bitcoin Development Kit](https://bitcoindevkit.org/).
The bdk library aims to be the core building block for Bitcoin Applications of any kind.

### Requirements

- Flutter : 3.0 or higher
- Android minSdkVersion. : API 23 or higher.
- Deployment target : iOS 12.0 or greater.

### How to Use

To use the `bdk_flutter` package in your project, add it as a dependency in your project's pubspec.yaml:

```dart
dependencies:
  bdk_flutter: ^0.31.3
```

### Examples

### Create a Wallet & sync the balance of a descriptor

```dart
import 'package:bdk_flutter/bdk_flutter.dart';

// ....

final mnemonic = await Mnemonic.create(WordCount.words12);
final descriptorSecretKey = await DescriptorSecretKey.create( network: Network.testnet,
                                                              mnemonic: mnemonic );
final externalDescriptor = await Descriptor.newBip44( secretKey: descriptorSecretKey,
                                                      network: Network.testnet,
                                                      keychain: KeychainKind.externalChain );
final internalDescriptor = await Descriptor.newBip44( secretKey: descriptorSecretKey,
                                                      network: Network.testnet,
                                                      keychain: KeyChainKind.internalChain );
final blockchain = await Blockchain.create( config: BlockchainConfig.electrum(
                                                                        config: ElectrumConfig(
                                                                            stopGap: 10,
                                                                            timeout: 5,
                                                                            retry: 5,
                                                                            url: "ssl://electrum.blockstream.info:60002" )));
final wallet = await Wallet.create( descriptor: externalDescriptor,
                                    changeDescriptor: internalDescriptor,
                                    network: Network.testnet,
                                    databaseConfig: const DatabaseConfig.memory() );
final _ = await wallet.sync( blockchain );
```

### Create a `public` wallet descriptor

```dart
import 'package:bdk_flutter/bdk_flutter.dart';

// ....

final mnemonic = await Mnemonic.create(WordCount.words12);
final descriptorSecretKey = await DescriptorSecretKey.create( network: Network.testnet,
                                                              mnemonic: mnemonic );
final externalDescriptor = await Descriptor.newBip44( secretKey: descriptorSecretKey,
                                                      network: Network.testnet,
                                                      keychain: KeychainKind.externalChain  );
final externalPublicDescriptor = await Descriptor.create( descriptor: externalDescriptor.toString(),
                                                    network: Network.testnet);
```

### Get the transaction details

```dart
import 'package:bdk_flutter/bdk_flutter.dart';

final bdkWallet = .....

// ....

final txBuilder  = TxBuilder();
final address = await Address.fromString(s: "mv4rnyY3Su5gjcDNzbMLKBQkBicCtHUtFB", network: Network.testnet);

final script =  address.scriptPubkey();
final feeRate = await blockchain.estimateFee(target: 25);

final (psbt, transactionDetails) = await txBuilder.feeRate( feeRate.satPerVb )
                                       .addRecipient( script, 2000 )
                                       .finish( bdkWallet );

final serializedPsbt =  psbt.jsonSerialize();
final jsonObject = json.decode(serializedPsbt);
final outputs = jsonObject['unsigned_tx']['output'] as List;
final inputs = jsonObject['inputs'][0]['non_witness_utxo']['output'] as List;

debugPrint("=========Inputs=====");
    for (var e in inputs) {
      debugPrint("amount: ${e['value']}");
      debugPrint("script_pubkey: ${e['script_pubkey']}");
    }

debugPrint("=========Outputs=====");
    for (var e in outputs) {
      debugPrint("amount: ${e['value']}");
      debugPrint("script_pubkey: ${e['script_pubkey']}");
    }

```

### Create an `internal` and `extarnal` wallet descriptors from derivation path.

```dart
import 'package:bdk_flutter/bdk_flutter.dart';


final mnemonic = await Mnemonic.create(WordCount.words12);
final descriptorSecretKey = await DescriptorSecretKey.create(
        network: Network.testnet, mnemonic: mnemonic);

// create external descriptor
final derivationPath = await DerivationPath.create(path: "m/44h/1h/0h/0");
final descriptorPrivateKey =
         descriptorSecretKey.derive(derivationPath);
final Descriptor descriptorPrivate = await Descriptor.create(
      descriptor: "pkh(${descriptorPrivateKey.toString()})",
      network: Network.testnet,
    );

// create internal descriptor
final derivationPathInt =
        await DerivationPath.create(path: "m/44h/1h/0h/1");
final descriptorPrivateKeyInt =
         descriptorSecretKey.derive(derivationPathInt);
final Descriptor descriptorPrivateInt = await Descriptor.create(
      descriptor: "pkh(${descriptorPrivateKeyInt.toString()})",
      network: Network.testnet,
    );

final bdkWallet = await Wallet.create(
      descriptor: descriptorPrivate,
      changeDescriptor: descriptorPrivateInt,
      network: Network.testnet,
      databaseConfig: const DatabaseConfig.memory(),
    );

final address =
        bdkWallet.getAddress(addressIndex: const AddressIndex.increase());
final internalAddress =
        bdkWallet.getInternalAddress(addressIndex: const AddressIndex.increase());

```

### API Documentation

The latest API documentation is available [here](https://pub.dev/documentation/bdk_flutter/latest/bdk_flutter/bdk_flutter-library.html)

### Example Projects

- **\*BDK Flutter Demo App:** The [BDK Flutter Demo App](https://github.com/LtbLightning/bdk-flutter-quickstart)
  is a simple bitcoin app built in flutter to serve as a reference app to demonstrate `bdk-flutter` api usage.

### References:

- Setting up a local Esplora instance for testing:
  https://bitcoin.stackexchange.com/questions/116937/how-do-i-setup-an-esplora-instance-for-local-testing/116938#116938


Thanks for taking a look!
