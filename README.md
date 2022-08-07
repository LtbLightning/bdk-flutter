## Bdk-Flutter
A Flutter library of the Bitcoin Development Kit (https://bitcoindevkit.org/)


## Table of Contents

- [Requirements](#requirements)
- [Installation](#installation)
- [Building Binary Files](#building-binary-files)
- [Library API](#library-api)
- [Usage](#usage)
- [Library API](#library-api)


## Requirements

### Flutter

* Flutter version 2.0 or higher
* Dart version 2.12 or higher

### Android

* Android minSdkVersion is API 23 or higher.
* Android Target SDK version: API 29.
* Android SDK build tools: 26.0.3
* Android Gradle Plugin: 3.0.0 or greater.


### iOS

* Xcode version: 10 or greater.
* iOS Base SDK: 12 or greater.
* Deployment target: iOS 12.0 or greater.


## Installation

From Github (copy and paste the following code to pubsepc.yaml):

```bash
bdk_flutter:
    git:
      url: https://github.com/LtbLightning/bdk-flutter.git
      ref: main
```

## Building Binary Files

```
Please re-built your app in an android device or an emulator, after including the dependency in your pubspec.yaml, to build the necessary files.
```

## Sample application
* **BDK Flutter Demo App:** The [BDK Wallet Demo App](https://github.com/LtbLightning/bdk-flutter-app.git) 
is a simple testnet Bitcoin app built as a reference app for bdk-flutter.

## Usage

```dart
import 'package:bdk_flutter/bdk_flutter.dart';
```

## Library API

All methods work in iOS: ✅

All methods work in Android: ✅

**All methods return response as follows:**


The following methods can be used with this module. All methods can be called by the BdkWallet object.



| Method                                         | Request Parameters                                                                         |
| ---------------------------------              | ------------------------------------------------------------------------------------------ |
| [generateMnemonic()](#generateMnemonic)        | - wordCount, entropy                                                                       |
| [createExtendedKey()](#createExtendedKey)      | - network, mnemonic, password                                                              |
| [createXprv()](#createXprv)                    | - network, mnemonic, password                                                              |
| [createHDescriptor()](#createDescriptor)       | xprv,  keyInfo,   descriptor                                                               |
| [createWallet()](#createwallet)                | - mnemonic, password, useDescriptor, descriptor, changeDescriptor, network, blockChainConfigUrl,                                                            socks5OrProxy, retry, timeOut                                                            |                                                                                                                                                        
| [getNewAddress()](#getnewaddress)              | -                                                                                          | 
| [getLastUnusedAddress()](#getLastUnusedAddress)| -                                                                                          |       
| [getBalance()](#getbalance)                    | -                                                                                          |    
| [getPendingTransactions()](#getbalance)        | -                                                                                          |
| [getPendingTransactions()](#getbalance)        | -                                                                                          |
| [sync()](#sync)                                | -                                                                                          |
| [broadcastTx()](#broadcastTx)                  | address (recipient wallet address), amount*(sats)                                          |


---

### generateMnemonic()
Generate a random mnemonic seed phrase. Reference: https://github.com/bitcoin/bips/blob/master/bip-0039.mediawiki#generating-the-mnemonic 
This will generate a mnemonic sentence from the English word list. The required entropy can be specified as the entropy parameter and 
can be in multiples of 32 from 128 to 256, 128 is used as default. A word count or length can be specified instead as the length 
parameter and can be in multiples of 3 from 12 to 24. 12 is used as default.

```dart
const response = await generateMnemonic()

const response = await generateMnemonic(entropy: Entropy.Entropy128)

```

Returned response example:
```dart
"daring erase travel point pull loud peanut apart attack lobster cross surprise actress dolphin gift journey mystery save"
```
---


### createExtendedKey()
This method will create an extendedKeyInfo object using the specified mnemonic seed phrase and password 
ExtendedKeyInfo creates a key object which encapsulates the mnemonic and adds a private key using the mnemonic and password.

The extended key info object is required to be passed as an argument in some bdk methods.

```dart
const response = await generateExtendedKey(network: Network.TESTNET
                                           mnemonic: 'daring erase travel point pull loud peanut apart attack lobster cross surprise',
                                           password: ''
                                           );
```

Returned response example:
```dart
 {
 		fingerprint: 'ZgUK9QXJRYCwnCtYL',
		mnemonic: 'daring erase travel point pull loud peanut apart attack lobster cross surprise',
		xpriv: 'tprv8ZgxMBicQKsPd3G66kPkZEuJZgUK9QXJRYCwnCtYLJjEZmw8xFjCxGoyx533AL83XFcSQeuVmVeJbZai5RTBxDp71Abd2FPSyQumRL79BKw'
 }
```
---


### createXprv()
Create descriptor using mnemonic phrase and password.

```dart

const response = await createXprv({ network: Network.TESTNET, mnemonic: '', password: '' });

```

```
Returned response example:
```dart
"tprv8ZgxMBicQKsPd3G66kPkZEuJZgUK9QXJRYCwnCtYLJjEZmw8xFjCxGoyx533AL83XFcSQeuVmVeJbZai5RTBxDp71Abd2FPSyQumRL79BKw"
```
---


### createDescriptor()
Both xprv and extended key info are optional but need at least one of them.

Returns P2WPKH Descriptor

```dart
const response = createDescriptor( xprv: key.xprv, descriptor: Descriptor.P2WPKH);
```

Returned response example:

```dart
 "wpkh([c258d2e4/84h/1h/0h]tpubDDYkZojQFQjht8Tm4jsS3iuEmKjTiEGjG6KnuFNKKJb5A6ZUCUZKdvLdSDWofKi4ToRCwb9poe1XdqfUnP4jaJjCB2Zwv11ZLgSbnZSNecE/0/*)",
```

---


### createWallet()

Create new wallet.

User can specify their custom mnemonic (OR can generate from generateMnemonic() method), password, network, blockChainConfigUrl, blockChainSocket5,  blockChain, walletDescriptor and pass to createWallet.
If any of the values are not specified, the default values will be used instead of it, except for the case of password and mnemonic, in which case will be generated automatically and an empty password will be applied to createWallet.
In the case of a multi-sig wallet, you can generate a custom descriptor using createDescriptor() and pass Descriptor.P2SH2of2Multisig or Descriptor.P2SH3of4Multisig type.


```dart
const response  =  await BdkWallet().createWallet(
                                                    descriptor:descriptor,
                                                    changeDescriptor:changeDescriptor,
                                                    useDescriptors: true,
                                                    network: network,
                                                    blockChainConfigUrl: "ssl://electrum.blockstream.info:60002",
                                                    blockchain: Blockchain.ELECTRUM
                                                    );
                                                
const response  =  await BdkWallet().createWallet(
                                                    mnemonic: mnemonic,
                                                    password: password,
                                                    useDescriptors: false,
                                                    network: network,
                                                    blockChainConfigUrl: "ssl://electrum.blockstream.info:60002",
                                                    blockchain: Blockchain.ELECTRUM
                                                    );                                                
```

---


### getNewAddress()
Create a new address for the wallet.

```dart
const response = await BdkWallet.getNewAddress();

```
Returned response example:
```dart
"tb1qew48u6cfxladqpumcpzl0svdqyvc9h4rqd3dtw"
```
---


### getLastUnusedAddress()

Returns the last unused address of the wallet.

```dart
const response = await BdkWallet.getLastUnusedAddress();

```

Returned response example:
```dart
"tb1qew48u6cfxladqpumcpzl0svdqyvc9h4rqd3dtw"
```
---


### getBalance()

Get the balance of your wallet.

```dart
const response = await BdkWallet.getBalance();
```

Returned response example:
```dart
 "8369", // balance in sats
```

---


### getPendingTransactions()

Returns a list of transactions that are not confirmed.

```dart
const response = await BdkWallet.getPendingTransactions();
```

Returned response example:

```dart
{
    "received": "tb1qxg8g8cdzgs09cttu3y7lc33udqc4wsesunjnhe",
    "sent": "0" // in sats
    "fees": "0" // in sats
    "txid": "tb1qxg8g8cdzgs09cttu3y7lc33udqc4wsesunjnhe",
}
```
---


### confirmedTransactionsList()

Returns a list of transactions that are confirmed.

```dart
const response = await BdkWallet.confirmedTransactions();
```

Returned response example:

```dart
{
    "received": "tb1qxg8g8cdzgs09cttu3y7lc33udqc4wsesunjnhe",
    "sent": "0" // in sats
    "fees": "0" // in sats
    "txid": "tb1qxg8g8cdzgs09cttu3y7lc33udqc4wsesunjnhe",
}
```
---


### sync()

Syncs the wallet.


```dart

const response = await BdkWallet.sync;
```

```dart
{

}
```

---


### broadcastTx()

Send bitcoin (*sats) to a given address.

Required params: address, amount

```js
let address = 'tb1qhmk3ftsyctxf2st2fwnprwc0gl708f685t0j3t'; // Wallet address
let amount = '2000'; // amount in satoshis
const response = await BdkWallet.broadcastTx(address, amount);
```

```dart

 "1162badd3d98b97b1c6bb7fc160b7789163c0fcaef99ad841ad8febeb1395864", // transaction id
 
```
---


_Note: Caution this is pre-Alpha at this stage
Please consider reviewing, experimenting, and contributing ⚡️_

Thanks for taking a look!
