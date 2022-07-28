## Bdk-Flutter

A Flutter  version of the Bitcon Development Kit (https://bitcoindevkit.org/)
The Bdk-Flutter is a flutter version of wrapper for the native Android and iOS Bitcon Development Kit SDK
## Table of Contents

- [Requirements](#requirements)
- [Installation](#installation)
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


## Sample application
* **BDK Flutter Demo App:** The [BDK Wallet Demo App](https://github.com/LtbLightning/bdk-flutter-app.git) 
is a simple testnet Bitcoin wallet built as a reference app for bdk-flutter.


## Usage

```dart
import 'package:bdk_flutter/bdk_flutter.dart';
```

## Library API

All methods work in iOS: ✅

All methods work in Android: ✅

**All methods return response as follows:**


Following methods can be used with this module. All methods can be called by BdkWallet object.



| Method                                         | Request Parameters                                                                         |
| ---------------------------------              | ------------------------------------------------------------------------------------------ |
| [generateMnemonic()](#generateMnemonic)        | - wordCount, entropy                                                                       |
| [createExtendedKey()](#createExtendedKey)      | - network, mnemonic, password                                                              |
| [createXprv()](#createXprv)                    | - network, mnemonic, password                                                              |
| [createWallet()](#createwallet)                | - mnemonic, password, useDescriptor, descriptor, changeDescriptor, network, blockChainConfigUrl,                                                            socks5OrProxy, retry, timeOut                                                            |                                                                                                                                                        
| [getNewAddress()](#getnewaddress)              | -                                                                                          | 
| [getLastUnusedAddress()](#getLastUnusedAddress)| -                                                                                          |       
| [getBalance()](#getbalance)                    | -                                                                                          |    
| [getPendingTransactions()](#getbalance)        | -                                                                                          |
| [getPendingTransactions()](#getbalance)        | -                                                                                          |
| [sync()](#sync)                                | -                                                                                          |
| [broadcastTx()](#broadcastTx)                  | address (recipient wallet address), amount*(sats)                                          |
| [createP2SHP2WPKHDescriptor()](#createP2SHP2WPKHDescriptor)| mnemonic, password                                                             |
| [createP2PKHDescriptor()](#createP2PKHDescriptor)| mnemonic, password                                                                     |
| [createP2SH2of2MultisigDescriptor()](#createP2SH2of2MultisigDescriptor)| mnemonic, password, recipientPublicKey                             |

---

### generateMnemonic()

Generate random mnemonic seed phrase. Reference: https://github.com/bitcoin/bips/blob/master/bip-0039.mediawiki#generating-the-mnemonic 
This will generate a mnemonic sentence from the english word list. The required entropy can be specified as the entropy parameter and 
can be in multiples of 32 from 128 to 256, 128 is used as default. A word count or length for can be specified instead as the length 
parameter and can be in multiples of 3 from 12 to 24. 12 is used as default.

```dart
const response = await BdkWallet.generateMnemonic()
// daring erase travel point pull loud peanut apart attack lobster cross surprise actress dolphin gift journey mystery save
const response = await BdkWallet.generateMnemonic(WordCount.Words12,Entropy.Entropy128)
// daring erase travel point pull loud peanut apart attack lobster cross surprise actress dolphin gift journey mystery save
```
---

### createExtendedKey()

This method will create a extendedKeyInfo object using the specified mnemonic seed phrase and password 
ExtendedKeyInfo creates a key object which encapsulates the mnemonic and adds a private key using the mnemonic and password.

The extended key info object is required to be passed as an argument in some bdk methods.

```dart
const response = await BdkWallet.generateExtendedKey(network: Network.TESTNET
                                                     mnemonic: 'daring erase travel point pull loud peanut apart attack lobster cross surprise',
                                                     password: ''
                                                    );
// {
// 		fingerprint: 'ZgUK9QXJRYCwnCtYL',
//		mnemonic: 'daring erase travel point pull loud peanut apart attack lobster cross surprise',
//		xpriv: 'tprv8ZgxMBicQKsPd3G66kPkZEuJZgUK9QXJRYCwnCtYLJjEZmw8xFjCxGoyx533AL83XFcSQeuVmVeJbZai5RTBxDp71Abd2FPSyQumRL79BKw'
// }
```
---

### createXprv()
Create descriptor using mnemonic phrase and password.

```dart

const response = await BdkWallet.createXprv({ network: Network.TESTNET, mnemonic: '', password: '' });
// tprv8ZgxMBicQKsPd3G66kPkZEuJZgUK9QXJRYCwnCtYLJjEZmw8xFjCxGoyx533AL83XFcSQeuVmVeJbZai5RTBxDp71Abd2FPSyQumRL79BKw
```
---

### createWallet()

Create new wallet.

User can specify their custom  mnemonic (OR can generate from genSeed() method), password, network, blockChainConfigUrl, blockChainSocket5,  blockChain, walletDescriptor and pass to createWallet.
If any of the values are not specefied, the default values will be used instead of it, except for the case of password and mnemonic, in which case will be generate automatically and empty password will be applied to createWallet.
In case of a multi-sig wallet, you can generate a custom descriptor using createP2SH2of2MultisigDescriptor() or createP2SH3of4MultisigDescriptor() and use it as descriptor for your wallet
Return the new address after successful of createWallet.

```dart
const response = await BdkWallet.createWallet(mnemonic, password, useDescriptor, descriptor, changeDescriptor, network, blockChainConfigUrl, socks5OrProxy, retry, timeOut );
```

---

### getNewAddress()

Create new address for wallet.

```dart
const response = await BdkWallet.getNewAddress();
// tb1qew48u6cfxladqpumcpzl0svdqyvc9h4rqd3dtw
```
---

### getLastUnusedAddress()

Returns the last unused address of the wallet.

```dart
const response = await BdkWallet.getLastUnusedAddress();
// tb1qew48u6cfxladqpumcpzl0svdqyvc9h4rqd3dtw
```
---

### getBalance()

Get balace of wallet.

```dart
const response = await BdkRn.getBalance();
```

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
    "confirmation_time": 0
}
```
---

### sync()

Sync the wallet.


```dart

const response = await BdkWallet.sync;
```

```dart
{

}
```

---

### broadcastTx()

Used to send sats to given address.

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

### createP2SHP2WPKHDescriptor()

mnemonic is required param. password is optional but must applied if passed

Returns P2SHP2WPKH Descriptor

```dart
const response = await BdkWallet.createP2SHP2WPKHDescriptor((mnemonic, password);
```

Returned response example:

```dart
 "sh(wpkh([c258d2e4/84h/1h/0h]tpubDDYkZojQFQjht8Tm4jsS3iuEmKjTiEGjG6KnuFNKKJb5A6ZUCUZKdvLdSDWofKi4ToRCwb9poe1XdqfUnP4jaJjCB2Zwv11ZLgSbnZSNecE/0/*))",
```

---


### createP2PKHDescriptor()

mnemonic is required param. password is optional but must applied if passed

Returns P2PKH Descriptor

```dart
const response = await BdkWallet.createP2PKHDescriptor(mnemonic, password);
```

Returned response example:

```dart
 "pkh([c258d2e4/84h/1h/0h]tpubDDYkZojQFQjht8Tm4jsS3iuEmKjTiEGjG6KnuFNKKJb5A6ZUCUZKdvLdSDWofKi4ToRCwb9poe1XdqfUnP4jaJjCB2Zwv11ZLgSbnZSNecE/0/*)",
```

---

### createP2SH2of2MultisigDescriptor()

mnemonic, passowrd and recipientPublicKey is required param.

Returns P2SH2of2Multisig Descriptor for multi-sig transaction


```dart
const response = await BdkWallet.createP2PKHDescriptor(mnemonic, password);
```

Returned response example:

```dart
 "pkh([c258d2e4/84h/1h/0h]tpubDDYkZojQFQjht8Tm4jsS3iuEmKjTiEGjG6KnuFNKKJb5A6ZUCUZKdvLdSDWofKi4ToRCwb9poe1XdqfUnP4jaJjCB2Zwv11ZLgSbnZSNecE/0/*)",
```

---

_Note: Caution this is pre-Alpha at this stage
Please consider reviewing, experimenting and contributing ⚡️_

Thanks for taking a look!
