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
  bdk_flutter: ^0.29.0
```

### Examples

### Create a Wallet & sync the balance of a descriptor

```dart
import 'package:bdk_flutter/bdk_flutter.dart';

// ....

final mnemonic = await Mnemonic.create(WordCount.Words12);
final descriptorSecretKey = await DescriptorSecretKey.create( network: Network.Testnet,
                                                              mnemonic: mnemonic );
final externalDescriptor = await Descriptor.newBip44( descriptorSecretKey: descriptorSecretKey,
                                                      network: Network.Testnet,
                                                      keychain: KeyChainKind.External );
final internalDescriptor = await Descriptor.newBip44( descriptorSecretKey: descriptorSecretKey,
                                                      network: Network.Testnet,
                                                      keychain: KeyChainKind.Internal );
final blockchain = await Blockchain.create( config: BlockchainConfig.electrum(
                                                                        config: ElectrumConfig(
                                                                            stopGap: 10,
                                                                            timeout: 5,
                                                                            retry: 5,
                                                                            url: "ssl://electrum.blockstream.info:60002" )));
final wallet = await Wallet.create( descriptor: externalDescriptor,
                                    changeDescriptor: internalDescriptor,
                                    network: Network.TESTNET,
                                    databaseConfig: const DatabaseConfig.memory() );
final _ = await wallet.sync( blockchain );
```

### Create a `public` wallet descriptor

```dart
import 'package:bdk_flutter/bdk_flutter.dart';

// ....

final mnemonic = await Mnemonic.create(WordCount.Words12);
final descriptorSecretKey = await DescriptorSecretKey.create( network: Network.Testnet,
                                                              mnemonic: mnemonic );
final externalDescriptor = await Descriptor.newBip44( descriptorSecretKey: descriptorSecretKey,
                                                      network: Network.Testnet,
                                                      keychain: KeyChainKind.External );
final externalPublicDescriptorStr = await externalDescriptor.asString();
final externalPublicDescriptor = await Descriptor.( descriptor: externalPublicDescriptorStr,
                                                    network: Network.Testnet);
```

### Get the transaction details

```dart
import 'package:bdk_flutter/bdk_flutter.dart';

final bdkWallet = .....

// ....

final txBuilder  = TxBuilder();
final address = await Address.create(address: "mv4rnyY3Su5gjcDNzbMLKBQkBicCtHUtFB");

final script = await address.scriptPubKey();
final feeRate = await estimateFeeRate(25);

final txBuilderResult = await txBuilder.feeRate( feeRate.asSatPerVb() )
                                       .addRecipient( script, 2000 )
                                       .finish( bdkWallet );
                           
final serializedPsbt = await txBuilderResult.psbt.jsonSerialize();
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


final mnemonic = await Mnemonic.create(WordCount.Words12);
final descriptorSecretKey = await DescriptorSecretKey.create(
        network: Network.Testnet, mnemonic: mnemonic);

// create external descriptor
final derivationPath = await DerivationPath.create(path: "m/44h/1h/0h/0");
final descriptorPrivateKey =
        await descriptorSecretKey.derive(derivationPath);
final Descriptor descriptorPrivate = await Descriptor.create(
      descriptor: "pkh(${descriptorPrivateKey.toString()})",
      network: Network.Testnet,
    );

// create internal descriptor
final derivationPathInt =
        await DerivationPath.create(path: "m/44h/1h/0h/1");
final descriptorPrivateKeyInt =
        await descriptorSecretKey.derive(derivationPathInt);
final Descriptor descriptorPrivateInt = await Descriptor.create(
      descriptor: "pkh(${descriptorPrivateKeyInt.toString()})",
      network: Network.Testnet,
    );

final bdkWallet = await Wallet.create(
      descriptor: descriptorPrivate,
      changeDescriptor: descriptorPrivateInt,
      network: Network.Testnet,
      databaseConfig: const DatabaseConfig.memory(),
    );

final address =
        await bdkWallet.getAddress(addressIndex: const AddressIndex());
final internalAddress =
        await bdkWallet.getInternalAddress(addressIndex: const AddressIndex());
    
```

### API Documentation

The latest API documentation is available [here](https://pub.dev/documentation/bdk_flutter/latest/bdk_flutter/bdk_flutter-library.html)

### Example Projects
**BDK Flutter Demo App:** The [BDK Flutter QuickStart](https://github.com/LtbLightning/bdk-flutter-quickstart) is a simple bitcoin app built in flutter to serve as a reference app to demonstrate `bdk-flutter` api usage.

### How to build

_Note that Flutter version `3.0` or later is required to build the plugin._

1. Install `Rust` and `Cargo`
   The easiest way to get Cargo is to install the current stable release of Rust by using [rustup](https://doc.rust-lang.org/cargo/getting-started/installation.html). Installing Rust using rustup will also install cargo.

2. Clone this repository
    ```shell
    git clone https://github.com/LtbLightning/bdk-flutter.git
    ```

3. Activate dart `ffigen`

   ```shell
   dart pub global activate ffigen
   ```

4. Android Setup

- The [Android NDK](https://developer.android.com/ndk), or Native Development Kit, enables code written in other languages to be run on the JVM via the Java Native Interface, or JNI for short.
  After following the instructions above, the NDK should be installed in your $ANDROID_SDK_HOME/ndk folder, where ANDROID_SDK_HOME usually is:
  <br/> Windows: %APPDATA%\Local\Android\sdk
  <br/> MacOS: ~/Library/Android/sdk

  An [issue](https://github.com/rust-lang/rust/pull/85806) regarding building Rust's core library against the latest NDK means that as of writing only NDK versions 22 and older can be used.

  You can alternatively use the latest version of the Android NDK which is greater than 22. However, this requires a hack to prevent the [`unable to find library -lgcc error`](https://github.com/rust-lang/rust/pull/85806#issuecomment-1096266946).

5. Build flutter bindings
   Navigate to `rust` directory, and run the following commands
   ```shell
   cargo build
   make all
   ```

### _Generating Docs Manually (Optional)_

Please use the [Dart documentation generator](https://pub.dev/packages/dartdoc) to generate the API documentation.


### References:
- Setting up a local Esplora instance for testing:
https://bitcoin.stackexchange.com/questions/116937/how-do-i-setup-an-esplora-instance-for-local-testing/116938#116938

_Note: Caution this is Beta at this stage
Please consider reviewing, experimenting, and contributing ⚡️_

Thanks for taking a look!
