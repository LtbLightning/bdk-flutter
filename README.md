## Bdk-Flutter
A Flutter version of the Bitcoin Development Kit (https://bitcoindevkit.org/)


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

## Sample applications
* **Bdk Wallet Demo App:** The [Bdk Wallet Demo App](https://github.com/LtbLightniing/bdk-flutter-demo-app)
  is a simple testnet Bitcoin wallet built as a reference app for the bdk-flutter on Flutter. 


## Usage

```dart
import 'package:bdk_flutter/bdk_flutter.dart';
```

## Library API

All methods work in iOS: ✅

All methods work in Android: ✅

**All methods return the response as follows:**


The following methods can be used with this module. All methods can be called by the BdkWallet object.



| Method                                         | Request Parameters                                                                         |
| ---------------------------------              | ------------------------------------------------------------------------------------------ |
| [generateMnemonic()](#generateMnemonic)        | - wordCount, entropy                                                                       |
| [createExtendedKey()](#createExtendedKey)      | - network, mnemonic, password                                                              |
| [createXprv()](#createXprv)                    | - network, mnemonic, password                                                              |
| [createDescriptor()](#createDescriptor)        | - xprv, type, mnemonic, network, password, publicKeys, threshold                           |
| [createChangeDescriptor()](#createChangeDescriptor)| -    descriptor                                                                        |
| [createWallet()](#createWallet)                | - mnemonic, password, descriptor, changeDescriptor, network, blockChainConfigUrl, socks5OrProxy, retry, timeOut |                                                                                                                                                     
| [getNewAddress()](#getNewAddress)              | -                                                                                          | 
| [getLastUnusedAddress()](#getLastUnusedAddress)| -                                                                                          |       
| [getBalance()](#getbalance)                    | -                                                                                          |
| [getTransactions()](#getTransactions)          | -                                                                                          | 
| [getPendingTransactions()](#getPendingTransactions)| -                                                                                      |
| [getConfirmedTransactions()](#getConfirmedTransactions)| -                                                                                  |
| [syncWallet()](#syncWallet)                    | -                                                                                          | 
| [createPartiallySignedTransaction()](#createPartiallySignedTransaction)| - address (recipient wallet address), amount*(sats) , feeRate      |
| [signTransaction()](#signTransaction)          | - psbt                                                                                     |
| [broadcastTransaction()](#broadcastTransaction)| - psbt                                                                                     |
| [signAndBroadcast()](#signAndBroadcast)        | - psbt                                                                                     |         

---

### generateMnemonic()
Generate a random mnemonic seed phrase.<br />
Reference: https://github.com/bitcoin/bips/blob/master/bip-0039.mediawiki#generating-the-mnemonic <br />
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
Returned response example:
```dart

"tprv8ZgxMBicQKsPd3G66kPkZEuJZgUK9QXJRYCwnCtYLJjEZmw8xFjCxGoyx533AL83XFcSQeuVmVeJbZai5RTBxDp71Abd2FPSyQumRL79BKw"

```
---


### createDescriptor()
Create a variety of descriptors using xprv or mnemonic.
xprv will be used if passed otherwise mnemonic, network and password will be used.
type is an enum and can be one of P2PK, P2PKH, P2WPKH, P2SHP2WPKH, P2SHP2WSHP2PKH, MULTI. P2WPKH is used as default.

If type is MULTI then need to specify the signature threshold and publicKeys array.

Returns P2WPKH Descriptor

```dart

const response = createDescriptor( xprv: xprv, descriptor: Descriptor.P2WPKH);

```
Returned response example:
```dart

"wpkh([c258d2e4/84h/1h/0h]tpubDDYkZojQFQjht8Tm4jsS3iuEmKjTiEGjG6KnuFNKKJb5A6ZUCUZKdvLdSDWofKi4ToRCwb9poe1XdqfUnP4jaJjCB2Zwv11ZLgSbnZSNecE/84'/1'/0'/0/*)",

```
---


### createChangeDescriptor()
Returns the changeDescriptor from the descriptor provided.

```dart

const response = createChangeDescriptor(descriptor:
"wpkh([c258d2e4/84h/1h/0h]tpubDDYkZojQFQjht8Tm4jsS3iuEmKjTiEGjG6KnuFNKKJb5A6ZUCUZKdvLdSDWofKi4ToRCwb9poe1XdqfUnP4jaJjCB2Zwv11ZLgSbnZSNecE/84'/1'/0'/0/*)";

```
Returned response example:
```dart

"wpkh([c258d2e4/84h/1h/0h]tpubDDYkZojQFQjht8Tm4jsS3iuEmKjTiEGjG6KnuFNKKJb5A6ZUCUZKdvLdSDWofKi4ToRCwb9poe1XdqfUnP4jaJjCB2Zwv11ZLgSbnZSNecE/84'/1'/0'/1/*)",

```
---


### createWallet()

Create a new wallet.

User can specify their custom mnemonic (OR can generate from generateMnemonic() method), password, network, blockChainConfigUrl, blockChainSocket5,  blockChain, walletDescriptor and pass to createWallet.
If any of the values are not specified, the default values will be used instead of it, except for the case of password and mnemonic, in which case will be generated automatically and an empty password will be applied to createWallet.
In the case of a multi-sig wallet, you can generate a custom descriptor using createDescriptor() and pass Descriptor.P2SH2of2Multisig or Descriptor.P2SH3of4Multisig type.

```dart

const response  =  await BdkWallet().createWallet(
                                                    descriptor:descriptor,
                                                    changeDescriptor:changeDescriptor,
                                                    network: Network.TESTNET,
                                                    blockChainConfigUrl: "ssl://electrum.blockstream.info:60002" ,
                                                    blockchain: Blockchain.ELECTRUM
                                                    );
                                                
const response  =  await BdkWallet().createWallet(
                                                    mnemonic: mnemonic,
                                                    password: password,
                                                    network: Network.TESTNET,
                                                    blockChainConfigUrl: "ssl://electrum.blockstream.info:60002" ,
                                                    blockchain: Blockchain.ELECTRUM
                                                    );
						    
```

---


### getNewAddress()
Create a new address for the wallet.

```dart

const response = await BdkWallet().getNewAddress();

```
Returned response example:
```dart

"tb1qew48u6cfxladqpumcpzl0svdqyvc9h4rqd3dtw"

```
---


### getLastUnusedAddress()
Returns the last unused address of the wallet.

```dart

const response = await BdkWallet().getLastUnusedAddress();

```

Returned response example:
```dart

"tb1qew48u6cfxladqpumcpzl0svdqyvc9h4rqd3dtw"

```
---


### getBalance()
Get the balance of your wallet.

```dart

const response = await BdkWallet().getBalance();

```
Returned response example:
```dart

 "8369", // balance in sats
 
```
---


### getTransactions()
Returns a list of all the transactions made.

```dart

const response = await BdkWallet().getTransactions();

```
Returned response example:
```dart

[
	{
	    "received": "tb1qxg8g8cdzgs09cttu3y7lc33udqc4wsesunjnhe",
	    "sent": "0" // in sats
	    "fees": "0" // in sats
	    "txid": "tb1qxg8g8cdzgs09cttu3y7lc33udqc4wsesunjnhe",
	}
]

```
---


### getPendingTransactions()
Returns the list of unconfirmed transactions.

```dart

const response = await BdkWallet().getPendingTransactions();

```
Returned response example:
```dart

[
	{
	    "received": "tb1qxg8g8cdzgs09cttu3y7lc33udqc4wsesunjnhe",
	    "sent": "0" // in sats
	    "fees": "0" // in sats
	    "txid": "tb1qxg8g8cdzgs09cttu3y7lc33udqc4wsesunjnhe",
	}
]

```
---


### getConfirmedTransactions()
Returns the list of confirmed transactions.

```dart

const response = await BdkWallet().getConfirmedTransactions();

```
Returned response example:
```dart

[
	{
	    "received": "tb1qxg8g8cdzgs09cttu3y7lc33udqc4wsesunjnhe",
	    "sent": "0" // in sats
	    "fees": "0" // in sats
	    "txid": "tb1qxg8g8cdzgs09cttu3y7lc33udqc4wsesunjnhe",
	}
]

```
---


### syncWallet()
Syncs the wallet.

```dart

const response = await BdkWallet().syncWallet();
```
---


### createPartiallySignedTransaction()
Create a Partially Signed Bitcoin Transaction.<br />
Required params: address, amount, feeRate

```dart

final psbt =  await BdkWallet().createPartiallySignedTransaction(recipient: 'tb1qhmk3ftsyctxf2st2fwnprwc0gl708f685t0j3t', amount: 2000, feeRate: 1);

```
Returned response example:
```dart
 'cHNidP8BAHQBAAAAAWxkL9CW6cpdkjO2eie+MXCxnvjL/Kemjmi2bnna1e+wAQAAAAD/////AlACAAAAAAAAFgAUmz1p6HT0uW0bDRhmY1sL92YbdtawBAAAAAAAABl2qRQ0Sg9IyhUOwrkDgXZgubaLE6ZwJoisAAAAAAABAOEBAAAAAAEBTevYyZI0SDB417CFQMW87Z8YkrBtdkrHIqfn5GAxH98BAAAAAP////8CsAQAAAAAAAAZdqkUNEoPSMoVDsK5A4F2YLm2ixOmcCaIrJAHAAAAAAAAFgAUMrIFB4W5c6b7/yiu+ph/N1JI5iwCRzBEAiBx5CL5kk4rvqInQ76atWwb+lUh/WcMPLZPLZirBLjgCQIgWLy2yuubrGDdMpg1/PUangucUxlVY3mzYSsBBPW6pigBIQLntzCxsOIpzhQe7I5rV+gEW0iJXUrnryU8gAa8sOOjtwAAAAABAR+QBwAAAAAAABYAFDKyBQeFuXOm+/8orvqYfzdSSOYsIgYCfoT0VFzm9d47mVZJ5kJn0/PSMZ6WedD5r9Q9TseuyvgY2R5q3VQAAIABAACAAAAAgAEAAAASAAAAACICA3+RBKNCI5Ev2vzb2+iGZ2+ODuqxgIxi5xRTEtobkC8tGNkeat1UAACAAQAAgAAAAIABAAAAGAAAAAAA', // psbt id
 
```
---


### signTransaction()
Sign the Partially Signed Transaction.<br />
Required params: psbt (Partially Signed Transaction - Unsigned)

```dart

var  psbt = 'cHNidP8BAHQBAAAAAWxkL9CW6cpdkjO2eie+MXCxnvjL/Kemjmi2bnna1e+wAQAAAAD/////AlACAAAAAAAAFgAUmz1p6HT0uW0bDRhmY1sL92YbdtawBAAAAAAAABl2qRQ0Sg9IyhUOwrkDgXZgubaLE6ZwJoisAAAAAAABAOEBAAAAAAEBTevYyZI0SDB417CFQMW87Z8YkrBtdkrHIqfn5GAxH98BAAAAAP////8CsAQAAAAAAAAZdqkUNEoPSMoVDsK5A4F2YLm2ixOmcCaIrJAHAAAAAAAAFgAUMrIFB4W5c6b7/yiu+ph/N1JI5iwCRzBEAiBx5CL5kk4rvqInQ76atWwb+lUh/WcMPLZPLZirBLjgCQIgWLy2yuubrGDdMpg1/PUangucUxlVY3mzYSsBBPW6pigBIQLntzCxsOIpzhQe7I5rV+gEW0iJXUrnryU8gAa8sOOjtwAAAAABAR+QBwAAAAAAABYAFDKyBQeFuXOm+/8orvqYfzdSSOYsIgYCfoT0VFzm9d47mVZJ5kJn0/PSMZ6WedD5r9Q9TseuyvgY2R5q3VQAAIABAACAAAAAgAEAAAASAAAAACICA3+RBKNCI5Ev2vzb2+iGZ2+ODuqxgIxi5xRTEtobkC8tGNkeat1UAACAAQAAgAAAAIABAAAAGAAAAAAA'; // psbt from createPartiallySignedTransaction()

const response = await BdkWallet().signTransaction(psbt:psbt);

```
---


### broadcastTransaction()
Send bitcoin (*sats) to a given address.<br />
Required params: psbt (Partially Signed Transaction - Signed)

```dart

var psbt = 'cHNidP8BAHQBAAAAAWxkL9CW6cpdkjO2eie+MXCxnvjL/Kemjmi2bnna1e+wAQAAAAD/////AlACAAAAAAAAFgAUmz1p6HT0uW0bDRhmY1sL92YbdtawBAAAAAAAABl2qRQ0Sg9IyhUOwrkDgXZgubaLE6ZwJoisAAAAAAABAOEBAAAAAAEBTevYyZI0SDB417CFQMW87Z8YkrBtdkrHIqfn5GAxH98BAAAAAP////8CsAQAAAAAAAAZdqkUNEoPSMoVDsK5A4F2YLm2ixOmcCaIrJAHAAAAAAAAFgAUMrIFB4W5c6b7/yiu+ph/N1JI5iwCRzBEAiBx5CL5kk4rvqInQ76atWwb+lUh/WcMPLZPLZirBLjgCQIgWLy2yuubrGDdMpg1/PUangucUxlVY3mzYSsBBPW6pigBIQLntzCxsOIpzhQe7I5rV+gEW0iJXUrnryU8gAa8sOOjtwAAAAABAR+QBwAAAAAAABYAFDKyBQeFuXOm+/8orvqYfzdSSOYsIgYCfoT0VFzm9d47mVZJ5kJn0/PSMZ6WedD5r9Q9TseuyvgY2R5q3VQAAIABAACAAAAAgAEAAAASAAAAACICA3+RBKNCI5Ev2vzb2+iGZ2+ODuqxgIxi5xRTEtobkC8tGNkeat1UAACAAQAAgAAAAIABAAAAGAAAAAAA'; // psbt id from createPartiallySignedTransaction()

const response = await BdkWallet().broadcastTransaction(psbt:psbt);

```
Returned response example:
```dart

 "9b5ecd0ee3846a891201f3c59a484fe73501d845c20b05d63c45ec92bc2c16b3", // transaction id
 
```
---


### signAndBroadcast()
Sign and broadcast  to the given address.<br />
Required params: psbt (Partially Signed Transaction - Unsigned)

```dart

var psbt = 'cHNidP8BAHQBAAAAAWxkL9CW6cpdkjO2eie+MXCxnvjL/Kemjmi2bnna1e+wAQAAAAD/////AlACAAAAAAAAFgAUmz1p6HT0uW0bDRhmY1sL92YbdtawBAAAAAAAABl2qRQ0Sg9IyhUOwrkDgXZgubaLE6ZwJoisAAAAAAABAOEBAAAAAAEBTevYyZI0SDB417CFQMW87Z8YkrBtdkrHIqfn5GAxH98BAAAAAP////8CsAQAAAAAAAAZdqkUNEoPSMoVDsK5A4F2YLm2ixOmcCaIrJAHAAAAAAAAFgAUMrIFB4W5c6b7/yiu+ph/N1JI5iwCRzBEAiBx5CL5kk4rvqInQ76atWwb+lUh/WcMPLZPLZirBLjgCQIgWLy2yuubrGDdMpg1/PUangucUxlVY3mzYSsBBPW6pigBIQLntzCxsOIpzhQe7I5rV+gEW0iJXUrnryU8gAa8sOOjtwAAAAABAR+QBwAAAAAAABYAFDKyBQeFuXOm+/8orvqYfzdSSOYsIgYCfoT0VFzm9d47mVZJ5kJn0/PSMZ6WedD5r9Q9TseuyvgY2R5q3VQAAIABAACAAAAAgAEAAAASAAAAACICA3+RBKNCI5Ev2vzb2+iGZ2+ODuqxgIxi5xRTEtobkC8tGNkeat1UAACAAQAAgAAAAIABAAAAGAAAAAAA'; // psbt id from createPartiallySignedTransaction()

const response = await BdkWallet().signAndBroadcast(psbt:psbt);

```
Returned response example:
```dart

 "9b5ecd0ee3846a891201f3c59a484fe73501d845c20b05d63c45ec92bc2c16b3", // transaction id
 
```
---


_Note: Caution this is pre-Alpha at this stage
Please consider reviewing, experimenting, and contributing ⚡️_

Thanks for taking a look!
