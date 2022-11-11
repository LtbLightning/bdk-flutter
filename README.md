## Bdk-Flutter

A Flutter implementation of the [Bitcoin Development Kit](https://bitcoindevkit.org/)

## Table of Contents

- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)
- [Library API](#library-api)

## Requirements

### Flutter

- Flutter version : 3.0 or higher
- Dart version : 2.17.1 or higher

### Android

- Android minSdkVersion. : API 23 or higher.
- Android Target SDK version : API 29.

### iOS

- iOS Base SDK : 12 or greater.
- Deployment target : iOS 12.0 or greater.

## Installation

To use this plugin, add bdk-flutter as a dependency in your pubspec.yaml file.

### Configuring iOS

Please navigate to the iOS folder in your project and run the following command:

```
pod install
```

## Sample applications

* **BDK Flutter Demo App:** The [BDK Flutter Demo App](https://github.com/LtbLightning/bdk-flutter-app)
  is a simple testnet Bitcoin wallet built as a reference app for the bdk-flutter on Flutter.

## Usage

```dart

import 'package:bdk_flutter/bdk_flutter.dart';

```

## Library API

`bdk_flutter` consists of a number of classes that provide a range of functionality essential for implementing descriptor based `Bitcoin wallet` applications in flutter. In this section, we will take a brief tour of `bdk_flutter`, summarizing the major APIs and their uses.

[Address](#Address)

[Mnemonic](#Mnemonic)

[Script](#Script)

[DerivationPath](#DerivationPath)

[DescriptorPublicKey](#DescriptorPublicKey)

[DescriptorSecretKey](#DescriptorSecretKey)

[Blockchain](#Blockchain)

[Wallet](#Wallet)

[PartiallySignedBitcoinTransaction](#PartiallySignedBitcoinTransaction)

[TxBuilder](#TxBuilder)

[BumpFeeTxBuilder](#BumpFeeTxBuilder)

---

### Address

Bitcoin address.

Support for ordinary base58 Bitcoin addresses and private keys.

| Method                          | Request Parameters |
| ------------------------------- | ------------------ |
| [create()](#create)             | - String address.  |
| [scriptPubKey()](#scriptPubKey) | -                  |

#

### create()

Create a new `Address` instance given an address.

Required Params: address( `String` )

```dart
final address = await Address().create(address: "tb1ql7w62elx9ucw4pj5lgw4l028hmuw80sndtntxt");
```

Returns an `Address` object

#

### scriptPubKey()

Returns the `Script` object form the `Address` object.

```dart

final script = await address.scriptPubKey();

```

Returns a `Script` object

---

### Mnemonic

A mnemonic code.

Supported number of words are 12, 18 and 24.

This class provides the functions needed to support menmonic.

| Method                       | Request Parameters          |
| -------------------          | --------------------------- |
| [create()](#create)          | - WordCount wordCount       |
| [fromString()](#fromString)  | - String mnemonic           |
| [fromEntropy()](#fromEntropy)| - List<int> entropy         |
| [asString()](#asString)      |                             |    
    
    
#

### create()

Create a new `Mnemonic` instance given a WordCount.

Required Params: wordCount( `WordCount` )

```dart

final mnemonic = await Mnemonic().create(WordCount.Words12);

```

Returns an `Mnemonic` object

#

### fromString()

Return a `Mnemonic` instance given a `mnemonic` `String`.

Required Params: mnemonic( `String` )

```dart

final mnemonic = await Mnemonic().fromString('puppy interest whip tonight dad never sudden response push zone pig patch');

```

Returns an `Mnemonic` object

#

### fromEntropy()

Return a `Mnemonic` instance given an `entropy` `List`.

Required Params: entropy( `List<int>` )

```dart

final mnemonic = await Mnemonic().fromEntropy([3, 67, 174, 10, 219, 101, 93, 14, 82, 162, 197, 21, 49, 127, 95, 59, 172, 95, 187, 198, 3, 193, 67, 54, 71, 40, 251, 253, 36, 159, 62, 145]);

```

Returns an `Mnemonic` object

#

### asString()

This function will return the `Mnemonic` object as a `String`.


```dart

final mnemonicStr = mnemonic.asString();

```

Returned response example:

```dart
"addict buddy live replace fiction mango enhance flavor benefit message style jar shine target blossom join drip rate sketch wave spoil exhibit where design"
```

___


### Script

Scripts define Bitcoin’s digital signature scheme: a signature is formed from a script (the second half of which is defined by a coin to be spent, and the first half provided by the spending transaction), and is valid iff the script leaves TRUE on the stack after being evaluated. Bitcoin’s script is a stack-based assembly language similar in spirit to Forth.

This class provides the functions needed to support scripts.

| Method              | Request Parameters          |
| ------------------- | --------------------------- |
| [create()](#create) | - Uint8List rawOutputScript |

#

### create()

Create a new `Script` instance given a Uint8List.

Required Params: rawOutputScript( `Uint8List` )

```dart

 final address = await Script().create([]);

```

Returns an `Script` object

#

### DerivationPath

| Method              | Request Parameters |
| ------------------- | ------------------ |
| [create()](#create) | - String path      |

#

### create()

Create a new `DerivationPath` instance given a `path`.

```dart

  final path = await DerivationPath().create(path: "m/84'/1'/0'");

```

Returns a `DerivationPath` object

---

### DescriptorPublicKey

| Method                  | Request Parameters              |
| ----------------------- | ------------------------------- |
| [derive()](#derive)     | - DerivationPath derivationPath |
| [extend()](#extend)     | - DerivationPath derivationPath |
| [asString()](#asString) | -                               |

#

### derive()

This function derives the `DescriptorPublicKey` provided `DerivationPath`.

Required Params: path( `DerivationPath` )

```dart
final derivedDescriptorPublicKey = await descriptorPublicKey.derive(path);
```

Returns a `DescriptorPublicKey` object

#

### extend()

This function extends the `DescriptorPublicKey`, provided `DerivationPath`.

Required Params: path( `DerivationPath` )

```dart
final extendedDescriptorPublicKey = await descriptorPublicKey.extend(path);
```

Returns a `DescriptorPublicKey` object

#

### asString()

This function will return the `DescriptorPublicKey` as a `String`.

```dart
final descriptorPublicKeyStr = descriptorPublicKey.asString();
```

Returned response example:

```dart

"tpubD6NzVbkrYhZ4WTWu6gfFmFmv41o9rha9UV5U9TU6vcr7ZpghKewi93LhsJ3uV2rAnD4Vd5MTMeCaTJSiVYbWgaNry1quCYx2vNaVrhEZDd3/84'/1'/0'/*"

```

---

### DescriptorSecretKey

| Method                        | Request Parameters              |
| ----------------------------- | ------------------------------- |
| [derive()](#derive)           | - DerivationPath derivationPath |
| [extend()](#extend)           | - DerivationPath derivationPath |
| [asPublic()](#asPublic)       | -                               |
| [secretBytes()](#secretBytes) | -                               |
| [asString()](#asString)       | -                               |

#

### derive()

This function derives the `DescriptorSecretKey` provided `DerivationPath`.

Required Params: path( `DerivationPath` )

```dart
final derivedDescriptorSecretKey = await descriptorSecretKey.derive(path);
```

Returns a `DescriptorSecretKey` object

#

### extend()

This function extends the `DescriptorSecretKey`, provided `DerivationPath`.

Required Params: path( `DerivationPath` )

```dart
final extendedDescriptorSecretKey = await descriptorSecretKey.extend(path);
```

Returns a `DescriptorSecretKey` object

#

### asPublic()

This function will return the public version of the `DescriptorSecretKey`.

```dart
final descriptorPublicKey = descriptorSecretKey.asPublic();
```

Returns a `DescriptorPublicKey` object

#

### secretBytes()

This function will return the secret key as a byte value.

```dart
final secretBytes = descriptorSecretKey.secretBytes();
```

Returned response example:

```dart
[3, 67, 174, 10, 219, 101, 93, 14, 82, 162, 197, 21, 49, 127, 95, 59, 172, 95, 187, 198, 3, 193, 67, 54, 71, 40, 251, 253, 36, 159, 62, 145]
```

#

### asString()

This function will return the `DescriptorSecretKey` as a `String`.

```dart
final descriptorSecretKeyStr = descriptorSecretKey.asString();
```

Returned response example:

```dart

"tprv8ZgxMBicQKsPczV7D2zfMr7oUzHDhNPEuBUgrwRoWM3ijLRvhG87xYiqh9JFLPqojuhmqwMdo1oJzbe5GUpxCbDHnqyGhQa5Jg1Wt6rc9di/84'/1'/0'/*"

```

---

### Blockchain

This class provides the implementation of a few commonly-used backends like Electrum, and Esplora along with a Blockchain class that can be implemented to build customized backends.

| Method                          | Request Parameters                       |
| ------------------------------- | ---------------------------------------- |
| [create()](#create)             | - BlockchainConfig config                |
| [getHeight()](#getHeight)       | -                                        |
| [getBlockHash()](#getBlockHash) | - int height                             |
| [broadcast()](#broadcast)       | - PartiallySignedBitcoinTransaction psbt |

#

### create()

Create a new `Blockchain` instance given a [BlockchainConfig](#BlockchainConfig) configuration

[BlockchainConfig](#BlockchainConfig) is an enum having 2 values,`BlockchainConfig.electrum` & `BlockchainConfig.esplora`

Required Params: config( `BlockchainConfig` )

```dart

final blockchain = await Blockchain().create(
        config: BlockchainConfig.electrum(
            config: ElectrumConfig(
                stopGap: 10,
                timeout: 5,
                retry: 5,
                url: "ssl://electrum.blockstream.info:60002")));

```

Returns a `Blockchain` object

#

### getHeight()

Return the current height of the `blockchain`

```dart

 final res = await blockchain.getHeight();

```

Returned response example:

```dart

2401901

```

#

### getBlockHash()

Fetch `block hash` of the initialized blockchain

The function takes blockchain `height` returned from [getHeight()](#getHeight) as its parameter.
Required Params: height( `int` )

```dart
final blockhash = await blockchain.getBlockHash(2401901);
```

Returned response example:

```dart

"000000000000027af96de90e53f21a37200d1b9777ef3c8e9b8a1efe79a9d0e5"

```

#

### broadcast()

This method will broadcast bitcoin transaction using the signed `psbt` object.

`PartiallySignedBitcoinTransaction` can be created using the `signed bitcoin transaction` returned from `sign()` method in the `Wallet` class

Required Params: `PartiallySignedBitcoinTransaction`

```dart

final sbt = "cHNidP8BAHEBAAAAARyp0TU6O43fV/uRO/km4cSiqsmE7sR+RqKE+UbgIaFkAAAAAAD+////AugDAAAAAAAAFgAU/52lZ+YvMOqGVPodX71HvvjjvhOIPwAAAAAAABYAFCadMSHX5kpd2pMQOkhfWNMPEgSvbaYkAAABAN4BAAAAAAEB9Tq4MbyE1SjHZDDWeh2KKtCGcuQMJilNh+djj6VSCMUAAAAAAP7///8CDkQAAAAAAAAWABTFgPd936kh3eFbF66+5aaJSVL7U+gDAAAAAAAAFgAU/52lZ+YvMOqGVPodX71HvvjjvhMCRzBEAiAZ8BHP5BLbs04B3NHkJEcsSmYJuOskRdXZueLmGbB5SQIgQUP1SbqnIRMY3GmQlN73Pe4bdMjjJcJmEq7lW/ami6YBIQIevFoumcPh53TVsUdyLGcCJy/XmgqKJUetxWbFRYFbnsakJAABAR8ORAAAAAAAABYAFMWA933fqSHd4VsXrr7lpolJUvtTIgYCpIXSaEEGWAx707IgIqWSEYdl8+MDRDTcjnn1xyP3HqgY2R5q3VQAAIABAACAAAAAgAEAAABcAAAAAQcAAQhrAkcwRAIgDU3jeUogxFEF4H5eIIK1GOeRi3UStkLsXywBAN6qIscCICGlRzeiWuDN7X/8xAbPq4TXadJSa7atywG6PJyOcqdSASECpIXSaEEGWAx707IgIqWSEYdl8+MDRDTcjnn1xyP3HqgAACICApl47fK3INCtOiQ+olI2NJiOJ6zdEIBpirtDk9oBrfniGNkeat1UAACAAQAAgAAAAIABAAAAXQAAAAA="

await blockchain.broadcast(PartiallySignedBitcoinTransaction(psbtBase64: sbt));

```

---

### Wallet

The Wallet class acts as a way of coherently interfacing with output descriptors and related transactions. Its main components are:

- Output descriptors from which it can derive addresses.
- A Database where it tracks transactions and utxos related to the descriptors.
- Signers that can contribute signatures to addresses instantiated from the descriptors.

| Method                                  | Request Parameters                                                                                        |
| --------------------------------------- | --------------------------------------------------------------------------------------------------------- |
| [create()](#create)                     | - String descriptor, String changeDescriptor (_optional_), Network network, DatabaseConfig databaseConfig |
| [getAddress()](#getAddress)             | - AddressIndex addressIndex                                                                               |
| [getBalance()](#getbalance)             | -                                                                                                         |
| [sync()](#sync)                         | - Blockchain blockchain                                                                                   |
| [network()](#network)                   | -                                                                                                         |
| [listUnspent()](#listUnspent)           | -                                                                                                         |
| [listTransactions()](#listTransactions) | -                                                                                                         |
| [sign()](#sign)                         | - PartiallySignedBitcoinTransaction psbt                                                                  |

#

### create()

Creates a new wallet using `wallet output descriptor`.

Required Params: descriptor( `String` ), changeDescriptor ( `String ?` _Optional_), network( `Network` ) , databaseConfig( `DatabaseConfig` )

```dart

final aliceWallet = await Wallet().create(
          descriptor:"wpkh(tprv8ZgxMBicQKsPczV7D2zfMr7oUzHDhNPEuBUgrwRoWM3ijLRvhG87xYiqh9JFLPqojuhmqwMdo1oJzbe5GUpxCbDHnqyGhQa5Jg1Wt6rc9di/84'/1'/0'/1/*)",
          network: Network.TESTNET,
          databaseConfig: const DatabaseConfig.memory());

```

Returns a `Wallet` class object

#

### getAddress()

Return an `AddressInfo` object with a `derived address` and an `addressIndex` using the `external descriptor`, requires `AddressIndex` enum as it's parameter. If none of the keys in the descriptor are derivable (i.e. does not end with /\*) then the same address will always be returned for any `AddressIndex`.

Required params: addressInde( `AddressIndex` )

```dart

final newAddress = await aliceWallet.getAddress(addressIndex:AddressIndex.New);

final lastUnUsedAddress = await aliceWallet.getAddress(addressIndex:AddressIndex.LastUnused);

```

Returned response example:

```dart

"tb1q5knz6ynpzlsnq3ezj97lh99sh3pac6easfml8h"

"tb1qtv92lppzj2qz0rxqvxhmexzm5p0ku04yh6al5m

```

#

### getBalance()

Returns the `Balance object` consisting of `spendable`, `total`, `confirmed`, `untrustedPending`, `trustedPending`, and `immature` balances of your wallet.

Note that this method only operates on the internal database, which first needs to be sync manually.

```dart

final response = await aliceWallet.getBalance();
final total    = response.total;

```

Returned response example:

```dart
 0 // balance in sats
```

#

### sync()

`Sync` the internal database with the blockchain.

Sync function takes a blockchain object as its parameter and prints the log.

Required params: blockchain ( `Blockchain` )

```dart

final response = await aliceWallet.sync(blockchain);

```

#

### network()

Get the Bitcoin network the wallet is using.

```dart

final response = await aliceWallet.network();

```

#

### listUnspent()

Return the list of unspent outputs of this wallet

Note that this method only operates on the internal database, which first needs to be sync manually.

```dart

final response = await aliceWallet.listUnspent();

```

Returned response example:

```dart

[

]

```

#

### listTransactions()

Returns a list of all the `transactions` made.

Note that this method only operates on the internal database, which first needs to be sync manually.

```dart

final response = await aliceWallet.listTransactions();

```

Returned response example:

```dart

[
        {
          txid: "e686ff52b2dd54fcb078a4c3854ddc8e2a6fbd05ab0d1d58cb2a16f215ff0f64"
          fee :  141
          received: 555
          send: 0
        }

]

```

#

### sign()

Signs a bitcoin transaction with the associated private key as per the descriptor used to create the wallet. The method accepts an unsigned `Partially

`Signed Bitcoin Transaction(psbt)`and returns a `Partially Signed Bitcoin Transaction` object.<br />

Required params: psbt ( `Partially Signed Bitcoin Transaction` )

```dart

 TxBuilder txBuilder = TxBuilder()
 final psbt = await txBuilder.addRecipient(script, 1000).feeRate(1.1).finish(aliceWallet);
 final sbt = await aliceWallet.sign(psbt);

```

Returns a `Partially Signed Bitcoin Transaction` class object

---

### PartiallySignedBitcoinTransaction

| Method                    | Request Parameters                        |
| ------------------------- | ----------------------------------------- |
| [txId()](#txId)           | -                                         |
| [extractTx()](#extractTx) | -                                         |
| [combine()](#combine)     | - PartiallySignedBitcoinTransaction other |
| [serialize()](#serialize) | -                                         |

#

### txId()

Returns the `txId` of the `psbt`.

Note that the psbt can be created from Txbuilder.

```dart

final psbt = await txBuilder.addRecipient(script, 1000).feeRate(1.1).finish(aliceWallet);
final txid = await psbt.txId();

```

Returned response example:

```dart
 "1338d123a76102e3d77958e48cc8761a9262f412656a61044d810018cd267145"
```

#

### extractTx()

Extract the transaction as List<int>.

Note that the psbt can be created from Txbuilder.

```dart

final tx = await psbt.extractTx();

```

Returned response example:

```dart
[1, 0, 0, 0, 1, 226, 91, 46, 73, 220, 142, 100, 101, 17, 105, 57, 78, 225, 206, 20, 16, 74, 53, 145, 53, 10, 234, 59, 191, 151, 185, 183, 158, 26, 97, 46, 97, 1, 0, 0, 0, 0, 254, 255, 255, 255, 2, 230, 157, 0, 0, 0, 0, 0, 0, 22, 0, 20, 137, 155, 157, 20, 91, 193, 250, 48, 125, 87, 122, 16, 97, 219, 170, 26, 60, 108, 227, 114, 232, 3, 0, 0, 0, 0, 0, 0, 22, 0, 20, 255, 157, 165, 103, 230, 47, 48, 234, 134, 84, 250, 29, 95, 189, 71, 190, 248, 227, 190, 19, 67, 167, 36, 0]
```

#

### combine()

Combine 2 psbt into one.

Required params: other ( `PartiallySignedBitcoinTransaction` )

```dart

final other = PartiallySignedBitcoinTransaction(psbtBase64: 'cHNidP8BAHQBAAAAAWO9QVybfmhTpK6qzTVcf9yeiui/a0iNmTgljuw29UeQAQAAAAD+////AsUwEwAAAAAAFgAUbNeMOfAF9QTOiFfrlhV8bQnXWVnoAwAAAAAAABl2qRQ0Sg9IyhUOwrkDgXZgubaLE6ZwJois4NYjAAABAOEBAAAAAAEBHIAjDPiXGopfbzyQGDCQ/UjKxT2rhurl5iYZWIrY0ycAAAAAAP7///8C6AMAAAAAAAAZdqkUNEoPSMoVDsK5A4F2YLm2ixOmcCaIrD01EwAAAAAAFgAUHjTI1PY9tTZPado27T8PTGITvIUCRzBEAiA/C1zSpBrEZkgHwt1sfcadj13OUruw6eofeOVk2aHhUAIgLf/sYhD3kv8+nZrM5atuyYwKXCMDuNBPldaO2FQpxBUBIQPCWh5gAGcSYqmTy9aVpFb96u5Sgp+hjs/JDg+6SgKqVeDWIwABAR89NRMAAAAAABYAFB40yNT2PbU2T2naNu0/D0xiE7yFIgYChXdsXDGO5LXjWfyh3rRkTZzfPDbWmBBZHSKDesNSrggU2R5q3VQAAIAAAACAAQAAgD0AAAABBwABCGsCRzBEAiAo6eGvjAWQdyefCuSphc8FJewM9BZzgOhXJW9Uf+hQfAIgVvNJ6D7YC+MSqS01aMiTZ+0T2NJlXZLJFCBl585wescBIQKFd2xcMY7kteNZ/KHetGRNnN88NtaYEFkdIoN6w1KuCAAiAgKX6sfAUUzaIV9h3amzY+Wnxalxmi9T6lZZ76CBlWjB5RTZHmrdVAAAgAAAAIABAACAPgAAAAAA');

final tx = await psbt.combine(other);;

```

Returns a combined `psbt` object

#

### serialize()

The method converts the unsigned /signed `Partially Signed Bitcoin Transaction(psbt)` object into a `String` <br />

```dart
final tx = await psbt.serialize();
```

Returned response example:

```dart
"cHNidP8BAHQBAAAAAWO9QVybfmhTpK6qzTVcf9yeiui/a0iNmTgljuw29UeQAQAAAAD+////AsUwEwAAAAAAFgAUbNeMOfAF9QTOiFfrlhV8bQnXWVnoAwAAAAAAABl2qRQ0Sg9IyhUOwrkDgXZgubaLE6ZwJois4NYjAAABAOEBAAAAAAEBHIAjDPiXGopfbzyQGDCQ/UjKxT2rhurl5iYZWIrY0ycAAAAAAP7///8C6AMAAAAAAAAZdqkUNEoPSMoVDsK5A4F2YLm2ixOmcCaIrD01EwAAAAAAFgAUHjTI1PY9tTZPado27T8PTGITvIUCRzBEAiA/C1zSpBrEZkgHwt1sfcadj13OUruw6eofeOVk2aHhUAIgLf/sYhD3kv8+nZrM5atuyYwKXCMDuNBPldaO2FQpxBUBIQPCWh5gAGcSYqmTy9aVpFb96u5Sgp+hjs/JDg+6SgKqVeDWIwABAR89NRMAAAAAABYAFB40yNT2PbU2T2naNu0/D0xiE7yFIgYChXdsXDGO5LXjWfyh3rRkTZzfPDbWmBBZHSKDesNSrggU2R5q3VQAAIAAAACAAQAAgD0AAAABBwABCGsCRzBEAiAo6eGvjAWQdyefCuSphc8FJewM9BZzgOhXJW9Uf+hQfAIgVvNJ6D7YC+MSqS01aMiTZ+0T2NJlXZLJFCBl585wescBIQKFd2xcMY7kteNZ/KHetGRNnN88NtaYEFkdIoN6w1KuCAAiAgKX6sfAUUzaIV9h3amzY+Wnxalxmi9T6lZZ76CBlWjB5RTZHmrdVAAAgAAAAIABAACAPgAAAAAA"
```

---

### TxBuilder

A TxBuilder is created by calling the TxBuilder class. After initializing it, you set options on it until finally calling finish to consume the builder and generate the transaction.

Each option setting method on TxBuilder takes paramters and returns `txBuilder` object so you can chain calls as in the following example:

| Method                                            | Request Parameters              |
| ------------------------------------------------- | ------------------------------- |
| [addData()](#addData)                             | - List<int> data                |
| [addRecipient()](#addRecipient)                   | - Script script, int amount     |
| [unSpendable()](#unSpendable)                     | - List<OutPoint> outpoints      |
| [addUtxo()](#addUtxo)                             | - OutPoint outpoint             |
| [addUtxos()](#addUtxos)                           | - List<OutPoint> outpoints      |
| [doNotSpendChange()](#doNotSpendChange)           |                                 |
| [drainWallet()](#drainWallet)                     | -                               |
| [drainTo()](#drainTo)                             | - String address                |
| [enableRbf()](#enableRbf)                         | -                               |
| [enableRbfWithSequence()](#enableRbfWithSequence) | - int nSequence                 |
| [feeAbsolute()](#feeAbsolute)                     | - int feeAmount                 |
| [feeRate()](#feeRate)                             | - double satPerVbyte            |
| [setRecipients()](#setRecipients)                 | - List<ScriptAmount> recipients |
| [manuallySelectedOnly()](#addUtxo)                | -                               |
| [addUnSpendable()](#addUnSpendable)               | - OutPoint unSpendable          |
| [onlySpendChange()](#onlySpendChange)             | -                               |
| [finish()](#finish)                               | - Wallet wallet)                |

#

### addData()

Add data as an output, using OP_RETURN
Required params: data( `List<int>` )

```dart
final txBuilder = TxBuilder();

final res = txBuilder.addData([]);
```

Returns a `TxBuilder` object

#

### addRecipient()

Add a `recipient` to the internal list

Required Params: script (`Script` object created from [scriptPubKey()](#scriptPubKey) ), amount ( `int` )

```dart
final res = txBuilder.addRecipient(`script`, 1000);
```

Returns a `TxBuilder` object

#

### unSpendable()

Replace the internal list of unspendable utxos with a new list

It’s important to note that the “must-be-spent” utxos added with [addUtxo()](#addUtxo) have priority over these.

Required Params: outPoint (`txid` ( The referenced transaction's txid ), `amount` ( The index of the referenced output in its transaction's vout ) )

```dart
final res = txBuilder.addUnSpendable(OutPoint(txid: txid, vout: vout));
```

Returns a `TxBuilder` object

#

### addUtxo()

Add a utxo to the internal list of utxos that must be spent

Required Params: outPoint (`txid` ( The referenced transaction's txid ), `amount` ( The index of the referenced output in its transaction's vout ) )

```dart
final uxto = txBuilder.addUtxo(OutPoint(txid: txid, vout: vout))
```

Returns a `TxBuilder` object

#

### addUtxos()

Add the list of outpoints to the internal list of UTXOs that must be spent.

If an error occurs while adding any of the UTXOs then none of them are added and the error is returned.

These have priority over the “unspendable” utxos, meaning that if a utxo is present both in the “utxos” and the “unspendable” list, it will be spent.

source

Required Params: outpoints(` List<OutPoints>` )

```dart
final uxtos = txBuilder.addUtxos( [OutPoint(txid: txid, vout: vout)] )
```

Returns a `TxBuilder` object

#

### doNotSpendChange()

This effectively adds all the change outputs to the [unSpendable()](#unSpendable) list.

```dart
final res = txBuilder.doNotSpendChange();
```

Returns a `TxBuilder` object

#

### drainWallet()

Spend all the available inputs. This respects filters like [unSpendable()](#unSpendable) and the change policy.

```dart
final res = txBuilder.drainWallet();
```

Returns a `TxBuilder` object

#

### drainTo()

Sets the address to drain excess coins to.

Usually, when there are excess coins they are sent to a change address generated by the wallet. This option replaces the usual change address with an arbitrary script_pubkey of your choosing. Just as with a change output, if the drain output is not needed (the excess coins are too small) it will not be included in the resulting transaction. The only difference is that it is valid to use drainTo without setting any ordinary recipients with addRecipient (but it is perfectly fine to add recipients as well).

If you choose not to set any recipients, you should either provide the utxos that the transaction should spend via [addUtxos()](#addUtxos), or set [drainWallet()](#drainWallet) to spend all of them.

When bumping the fees of a transaction made with this option, you probably want to use allowShrinking to allow this output to be reduced to pay for the extra fees.

Required Params: address( change address `String` )

```dart
final res = txBuilder.drainTo("tb1ql7w62elx9ucw4pj5lgw4l028hmuw80sndtntxt");
```

Returns a `TxBuilder` object

#

### enableRbf()

This method will enable signaling RBF

This will use the default nSequence value of 0xFFFFFFFD

```dart
final uxtos = txBuilder.enableRbf();
```

Returns a `TxBuilder` object

#

### enableRbfWithSequence()

This method will enable signaling RBF with a specific nSequence value

This can cause conflicts if the wallet’s descriptors contain an “older” (OP_CSV) operator and the given nsequence is lower than the CSV value.

If the nsequence is higher than 0xFFFFFFFD an error will be thrown, since it would not be a valid nSequence to signal RBF.

Required Params: nSequence( `int` ) _eg: 0xFFFFFFFD_

```dart
final res = txBuilder.enableRbfWithSequence(0xFFFFFFFD);
```

Returns a `TxBuilder` object

#

### feeAbsolute()

This method will set an absolute fee

Required Params: feeAmount( `int` )

```dart
final uxtos = txBuilder.feeAbsolute(1);
```

Returns a `TxBuilder` object

#

### feeRate()

This method will set a custom fee rate

Required Params: satPerVbyte( `double` )

```dart
final uxtos = txBuilder.satPerVbyte(1.0);
```

Returns a `TxBuilder` object

#

### setRecipients()

This method will replace the recipients already added with a new list

Required Params: recipients ( `List<ScriptAmount>` )

```dart
final address = await Address().create(address: "tb1ql7w62elx9ucw4pj5lgw4l028hmuw80sndtntxt");

final script = await address.scriptPubKey();

final uxto = txBuilder.setRecipients([ScriptAmount(script: script.toString(), amount: 1200)]);
```

Returns a `TxBuilder` object

#

### manuallySelectedOnly()

This method will let txBuilder only spend utxos added by [addUtxo()](#addUtxo).

The wallet will not add additional utxos to the transaction even if they are needed to make the transaction valid.

```dart
final res = txBuilder.manuallySelectedOnly();
```

Returns a `TxBuilder` object

#

### addUnSpendable()

This method will add a utxo to the internal list of unspendable utxos

It’s important to note that the “must-be-spent” utxos added with [addUtxo()](#addUtxo) have priority over this.

Required Params: unSpendable ( OutPoint (`txid` ( The referenced transaction's txid ), `amount` ( The index of the referenced output in its transaction's vout ) ) )

```dart
final res = txBuilder.addUnSpendable(OutPoint(txid: txid, vout: vout));
```

Returns a `TxBuilder` object

#

### onlySpendChange()

This method will effectively adds all the non-change outputs to the “unspendable” list.

```dart
final res = txBuilder.onlySpendChange();
```

Returns a `TxBuilder` object

#

### finish()

This method will finish building the transaction.

Returns the BIP174 “PSBT” and summary details about the transaction.

Required Params: wallet( _can be created from create() from `Wallet`_ )

```dart
final res = txBuilder.finish(aliceWallet);
```

Returns a `PartiallySignedBitcoinTransaction` object

---

### BumpFeeTxBuilder

| Method                                            | Request Parameters |
| ------------------------------------------------- | ------------------ |
| [allowShrinking()](#allowShrinking)               | - String address   |
| [enableRbfWithSequence()](#enableRbfWithSequence) | - int nSequence    |
| [enableRbf()](#enableRbf)                         | -                  |
| [finish()](#finish)                               | - Wallet wallet    |

#

### allowShrinking()

This method will explicitly tells the wallet that it is allowed to reduce the amount of the output matching this scriptPubkey in order to bump the transaction fee. Without specifying this the wallet will attempt to find a change output to shrink instead.

Note that the output may shrink to below the dust limit and therefore be removed. If it is preserved then it is currently not guaranteed to be in the same position as it was originally.

Returns an Err if scriptPubkey can’t be found among the recipients of the transaction we are bumping.

```dart
final uxtos = txBuilder.allowShrinking();
```

Returns a `BumpFeeTxBuilder` object

#

### enableRbf()

This method will enable signaling RBF

This will use the default nSequence value of 0xFFFFFFFD

```dart
final uxtos = txBuilder.enableRbf();
```

Returns a `BumpFeeTxBuilder` object

#

### enableRbfWithSequence()

This method will enable signaling RBF with a specific nSequence value

This can cause conflicts if the wallet’s descriptors contain an “older” (OP_CSV) operator and the given nsequence is lower than the CSV value.

If the nsequence is higher than 0xFFFFFFFD an error will be thrown, since it would not be a valid nSequence to signal RBF.

Required Params: nSequence( `int` ) _eg: 0xFFFFFFFD_

```dart
final res = txBuilder.enableRbfWithSequence(0xFFFFFFFD);
```

Returns a `BumpFeeTxBuilder` object

#

### finish()

This method will finish building the transaction.

Returns the BIP174 “PSBT” and summary details about the transaction.

Required Params: wallet( `Wallet` can be created from `create()` in `Wallet` )

```dart
final res = txBuilder.finish(aliceWallet);
```

Returns a `PartiallySignedBitcoinTransaction` object

---

_Note: Caution this is pre-Alpha at this stage
Please consider reviewing, experimenting, and contributing ⚡️_

Thanks for taking a look!
