### Bdk Flutter

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
  bdk_flutter: ^0.27.3
```

### Examples

### Create a Wallet & sync the balance of a predefined descriptor

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

### Create an `internal` and `extarnal` wallet descriptors from derivation path.

And get internal and external addresses.

```dart
import 'package:bdk_flutter/bdk_flutter.dart';

// ....

final mnemonic = await Mnemonic.create(WordCount.Words12);
final descriptorSecretKey = await DescriptorSecretKey.create( network: Network.Testnet,
                                                              mnemonic: mnemonic );
// create external descriptor
final derivationPath = await DerivationPath.create(path: "m/44h/1h/0h/0");
final descriptorPrivateKey = await descriptorSecretKey.derive(derivationPath);
final Descriptor descriptorPrivate = await Descriptor.create(
descriptor: "pkh(${descriptorPrivateKey.toString()})",
network: Network.Testnet,
);

// create internal descriptor
final derivationPathInt = await DerivationPath.create(path: "m/44h/1h/0h/1");
final descriptorPrivateKeyInt = await descriptorSecretKey.derive(derivationPathInt);
final Descriptor descriptorPrivateInt = await Descriptor.create(
descriptor: "pkh(${descriptorPrivateKeyInt.toString()})",
network: Network.Testnet,
);

final bdkWallet = await Wallet.create(
descriptor: aliceDescriptor!,
changeDescriptor: aliceDescriptorChange!,
network: Network.Testnet,
databaseConfig: const DatabaseConfig.memory(),
);

final address = await bdkWallet.getAddress(addressIndex: const AddressIndex());
final internalAddress = await bdkWallet.getInternalAddress(addressIndex: const AddressIndex());
```

### API Documentation

The latest API documentation is available [here](https://pub.dev/documentation/bdk_flutter/latest/bdk_flutter/bdk_flutter-library.html)

### Example Projects
**BDK Flutter Demo App:** The [BDK Flutter Demo App](https://github.com/LtbLightning/bdk-flutter-app) is a simple bitcoin app built in flutter to serve as a reference app to demonstrate `bdk-flutter` api usage.

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

_Note: Caution this is pre-Alpha at this stage
Please consider reviewing, experimenting, and contributing ⚡️_

Thanks for taking a look!
