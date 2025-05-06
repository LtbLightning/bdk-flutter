## [0.31.3]

#### Upgrades

- Updated `Flutter` and `Rust` dependencies to the latest version.
- Upgraded `Gradle` to version 8.4.0 and `Java` to version 17.
- Upgraded `android-ndk` to `26.3.11579264`.

#### Fixed

- Removed unnecessary class exports.
- Resolved the `txBuilder.setRecipients` error.
- Resolved class incompatibility issues and renamed conflicting classes.

## [0.31.2]

Updated `flutter_rust_bridge` to `2.0.0`.

#### APIs added

- Exposed `createTestnet` & `createMutinynet` to `Blockchain`.
- Exposed `policies` in `Wallet`.
- Exposed `policyPath` in `TxBuilder`.
- Exposed `id`, `requiresPath`, `item`, `satisfaction`, `contribution` in `Policy` class.
- Overrode `toString()` for `Address`, `DerivationPath`, `Descriptor`, `DescriptorPublicKey` , `DescriptorSecretKey`, `Mnemonic`,
- `PartiallySignedTransaction`, `ScriptBuf` & `Transaction`.

#### Changed

- `partiallySignedTransaction.serialize()` serialize the data as raw binary.

#### Fixed

- Thread `frb_workerpool` panicked on Sql database access.

## [0.31.2-dev.2]

#### Fixed

- Thread `frb_workerpool` panicked on invalid `Fingerprint`.
- `SignOptions` issue to accept `witness-utxo` while signing.

#### Changed

- Removed `multiSig` variable from `SignOptions`.
- Updated example app to support `mutinynet`.
- Mapped `Hex`, `Address`, `Descriptor` & `Consensus` exceptions.

## [0.31.2-dev.1]

#### Fixed

- Invalid `Bip49Public`, `Bip84Public` & `Bip86Public`.

## [0.31.2-dev]

Updated Rust and Flutter dependencies.

#### APIs added

- Add `InvalidInputException`, `InvalidLockTimeException` & `InvalidTransactionException` .

#### Fixed

- Thread `frb_workerpool` panic on `UnknownUtxo` and `InvalidPsbtInput`.

## [0.31.1-dev]

#### Fixed

- Failed to load `.so` files in android.

## [0.31.0-dev]

Updated Rust and Flutter dependencies.

#### APIs added

- Add sealed class `Auth` in `RpcConfig`.
- Made `PartiallySignedTransaction` class mutable.

#### Changed

- Replace `AddressIndex`'s `new` with`increase`.
- Renamed `Address`'s create to `fromString`.
- `txBuilder.finish` returns a tuple.
- Added `cargokit` to handle rust binary build

#### Fixed

- Functions hang indefinitely on iOS devices.
- Thread `frb_workerpool` panicked.

## [0.30.0]

Updated Rust and Flutter dependencies.
MacOS support bug resolved

#### APIs added

- Add BIP-86 descriptor template

## [0.29.2]

Support MacOS and unit testing.
Updated flutter dependencies.

## [0.29.1]

Updated Rust and Flutter dependencies.
Exposed strongly-typed exceptions.

## [0.29.0]

Support Dart 3.
Updated Rust and Flutter dependencies.

#### APIs added

- Add `isMine` method to `Wallet`.
- Expose script.toBytes() method.

## [0.28.3]

### Fixed

- Multisig issue resolved by adding isMultiSig to signOptions.

## [0.28.2]

#### APIs added

- Expose `Wallet` class's `getDescriptorForKeyChain` and `getPsbtInput` functions.
- Expose `TxBuilder` class's `addForeignUtxo` function.
- Add `Input` class.
- Expose `Descriptor` class's `maxSatisfactionWeight` function.

## [0.28.1]

### Fixed

- Invalid UTF-8 error for txansaction.input().

## [0.28.0]

Updated Rust ( Bdk to latest version 0.28.0 ) and Flutter dependencies.

#### APIs added

- Expose `Address` class's `payload` and `network` functions
- Add `fromScript` constructor to `Address` class
- Add `SignOptions` to Wallet.sign() params.
- Add `jsonSerialize` function to `PartiallySignedTransaction`, to get the JSON serialized value of all PSBT fields.
- Expose `Transaction` class's `txid`, `weight`, `size`, `vsize`, `isCoinBase`, `isExplicitlyRbf`, `version`, `isLockTimeEnabled`, `lockTime`, `input` and `output` functions.

## [0.27.2]

### API changed

- txBuilder.finish() & bumpFeeTxBuilder.finish() returns a `TxBuilderResult` instead of a `PartiallySignedTransaction`.

## [0.27.1]

Updated Rust ( Bdk to latest version 0.27.1 ) and Flutter dependencies.

#### APIs added

- New `Transaction` class that can be created from or serialized to consensus encoded bytes.
- Add estimateFee(int Target) function for `Blockchain`
- Add getInternalAddress() function for `Wallet`
- Add AddressIndex.reset(int index) & AddressIndex.peek(int index)

#### APIs changed

- partiallySignedTransaction.extractTx() returns a `Transaction` instead of a the transaction bytes.
- blockchain.broadcast() takes a `Transaction` instead of a `PartiallySignedTransaction`

## [0.3.2]

### Fixed

- iOS build issue when using flavors
- Added toString method for all objects

## [0.3.1]

### Fixed

- Pub.dev analysis score
- Type mismatch for descriptorSecretKey

## [0.3.0]

Updated Rust ( Bdk to latest version 0.26.0 ) and Flutter dependencies.

#### APIs changed

- The descriptor and changeDescriptor arguments on the wallet constructor now take a `Descriptor` instead of a String.

#### APIs added

- Added RpcConfig, BlockchainConfig.rpc
- Added Descriptor type with the following named constructors:
- Default `create` constructor, that requires a descriptor in String format and a Network
- newBip44 constructor returns a Descriptor with structure pkh(key/44'/{0,1}'/0'/{0,1}/\*)
- newBip44Public constructor returns a Descriptor with structure pkh(key/{0,1}/\*)
- newBip49 constructor returns a Descriptor with structure sh(wpkh(key/49'/{0,1}'/0'/{0,1}/\*))
- newBip49Public constructor returns a Descriptor with structure sh(wpkh(key/{0,1}/\*))
- newBip84 constructor returns a Descriptor with structure wpkh(key/84'/{0,1}'/0'/{0,1}/\*)
- newBip84Public constructor returns a Descriptor with structure wpkh(key/{0,1}/\*)
- asString returns the public version of the output descriptor in String format
- asPrivateString returns the private version of the output descriptor if available, otherwise, return the public version

## [0.2.3]

### Fixed

- pub.dev analysis score

## [0.2.2]

### Fixed

- pub.dev analysis score

## [0.2.1]

### Fixed

- pub.dev static analysis warning
- removing internal helper functions from public api

## [0.2.0]

Updated API to match bdk-ffi

## [0.1.4]

#### Functionality Added

- Generate Mnemonic method
- Create Descriptors
- Create Extended Key
- Create XPriv
- Create XPub
- Create Wallet
- Get New Address
- Get Last Unused Address
- Get Balance
- Get Transactions
- Get Pending Transactions
- Get Confirmed Transactions
- Sync Wallet
- Create Transaction
- Sign Transaction
- Broadcast Transaction
- Quick Send
