## Bdk-Flutter
A Flutter version of the Bitcoin Development Kit (https://bitcoindevkit.org/)


## Table of Contents

- [Requirements](#requirements)
- [Installation](#installation)
- [Building Binary Files](#building-binary-files)
- [Usage](#usage)
- [Library API](#library-api)


## Requirements

### Flutter

* Flutter version :  3.0 or higher
* Dart version    :  2.17.1 or higher

### Android

* Android minSdkVersion.     : API 23 or higher.
* Android Target SDK version : API 29.
* Android Gradle Plugin      : 3.0.0 or greater.


### iOS

* iOS Base SDK      : 12 or greater.
* Deployment target : iOS 12.0 or greater.
* Cocoapods         : 1.11.3 or greater


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

### Configuring iOS

Please navigate to the iOS folder in your project run the following command:
```
pod install
```

## Sample applications
* **Bdk Wallet Demo App:** The [Bdk Wallet Demo App](https://github.com/LtbLightning/bdk-flutter-demo-app)
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
| [createDerivedKey()](#createDerivedKey)        | - network, mnemonic, password , path                                                       |
| [createXprv()](#createXprv)                    | - network, mnemonic, password                                                              |
| [createXpub()](#createXpub)                    | - network, mnemonic, password                                                              |
| [createDescriptor()](#createDescriptor)        | - xprv, type, mnemonic, network, password, publicKeys, threshold , descriptorPath, changeDescriptorPath|
| [createWallet()](#createWallet)                | - mnemonic, password, descriptor, changeDescriptor, network, blockChainConfigUrl, socks5OrProxy, retry, timeOut|                                                                                                                                                 
| [getNewAddress()](#getNewAddress)              | -                                                                                          | 
| [getLastUnusedAddress()](#getLastUnusedAddress)| -                                                                                          |       
| [getBalance()](#getbalance)                    | -                                                                                          |
| [getTransactions()](#getTransactions)          | -                                                                                          | 
| [getPendingTransactions()](#getPendingTransactions)| -                                                                                      |
| [getConfirmedTransactions()](#getConfirmedTransactions)| -                                                                                  |
| [syncWallet()](#syncWallet)                    | -                                                                                          | 
| [createTransaction()](#createTransaction)      | - address (recipient wallet address), amount*(sats) , feeRate                              |
| [signTransaction()](#signTransaction)          | - psbt                                                                                     |
| [broadcastTransaction()](#broadcastTransaction)| - psbt                                                                                     |  
| [quickSend()](#quickSend)                      | - address (recipient wallet address), amount*(sats) , feeRate                              |

---

### generateMnemonic()
Generate a random mnemonic seed phrase.<br />
Reference: https://github.com/bitcoin/bips/blob/master/bip-0039.mediawiki#generating-the-mnemonic <br />
This will generate a mnemonic sentence from the English word list. The required entropy can be specified as the entropy parameter and 
can be in multiples of 32 from 128 to 256, 128 is used as default. A word count or length can be specified instead as the length 
parameter and can be in multiples of 3 from 12 to 24. 12 is used as default.

```dart

final response = await generateMnemonic()
final  response = await generateMnemonic(entropy: Entropy.Entropy128)

```
Returned response example:
```dart

"daring erase travel point pull loud peanut apart attack lobster cross surprise actress dolphin gift journey mystery save"

```
---


### createExtendedKey()
This method will create an ExtendedKeyInfo object using the specified mnemonic seed phrase and password 
ExtendedKeyInfo creates a key object which encapsulates the mnemonic and adds a private key using the mnemonic and password.

The extended key info object is required to be passed as an argument in some bdk methods.

```dart

final  response = await createExtendedKey(  network : Network.TESTNET
                                            mnemonic: 'daring erase travel point pull loud peanut apart attack lobster cross surprise',
                                            password: ''
                                         );
					   
```
Returned response example:
```dart

 {
	    xpub: "tpubDGdv2vah1pfxrqrHLgD7nYSE2RdbR9ExMQahBWcgsDt7PFdcXtV97jWc8tkXrFHDbKeyoKjPQaJ9UxA5xLEWvU1zv1h7JxdvsTMNpdBjsb9"
	    xprv: "tprv8jwstWYSsSzHyNpVT2YXP8n7TQ7fFp43n6yutzaPSx5iYmNquVfYwEtjxm2Wynm3NWjTfutiDr1AXXPFVwSyrZE7ixgycbpbqAkQ1GzcVx9"
 }
 
```
---


### createDerivedKey()
This method will create a DerivedKeyInfo object using the specified mnemonic seed phrase, path and password 
ExtendedKeyInfo creates a key object which encapsulates the mnemonic and adds a derived private key.

The extended key info object is required to be passed as an argument in some bdk methods.

```dart

final  response = await createDerivedKey(  network : Network.TESTNET
                                           mnemonic: 'daring erase travel point pull loud peanut apart attack lobster cross surprise',
                                           password: ''
					   path    : 'm/84/0/0/0/0'
                                        );
					   
```
Returned response example:
```dart

 {
	    xpub: "[2a04f15e/84/0/0/0/0]tpubDGdv2vah1pfxrqrHLgD7nYSE2RdbR9ExMQahBWcgsDt7PFdcXtV97jWc8tkXrFHDbKeyoKjPQaJ9UxA5xLEWvU1zv1h7JxdvsTMNpdBjsb9/*"
	    xprv: "[2a04f15e/84/0/0/0/0]tprv8jwstWYSsSzHyNpVT2YXP8n7TQ7fFp43n6yutzaPSx5iYmNquVfYwEtjxm2Wynm3NWjTfutiDr1AXXPFVwSyrZE7ixgycbpbqAkQ1GzcVx9/*"
 }
 
```
---


### createXprv()
Creates the private key using mnemonic phrase and password.

```dart

final  response = await createXprv(  network: Network.TESTNET, 
                                     mnemonic: 'daring erase travel point pull loud peanut apart attack lobster cross surprise', 
				     password: '' 
				  );

```
Returned response example:
```dart

"tprv8jwstWYSsSzHyNpVT2YXP8n7TQ7fFp43n6yutzaPSx5iYmNquVfYwEtjxm2Wynm3NWjTfutiDr1AXXPFVwSyrZE7ixgycbpbqAkQ1GzcVx9"

```
---


### createXpub()
Creates the public key using mnemonic phrase and password.

```dart

final  response = await createXpub(  network: Network.TESTNET, 
                                     mnemonic: 'daring erase travel point pull loud peanut apart attack lobster cross surprise', 
				     password: '' 
				  );

```
Returned response example:
```dart

"tpubDGdv2vah1pfxrqrHLgD7nYSE2RdbR9ExMQahBWcgsDt7PFdcXtV97jWc8tkXrFHDbKeyoKjPQaJ9UxA5xLEWvU1zv1h7JxdvsTMNpdBjsb9"

```
---


### createDescriptor()
Create a PathDescriptor object containing descriptor and changedescriptor using xprv or mnemonic.
xprv will be used if passed otherwise mnemonic, network and password will be used.
type is an enum and can be one of P2PK, P2PKH, P2WPKH, P2SHP2WPKH, P2SHP2WSHP2PKH, MULTI. P2WPKH is used as default.

If type is MULTI then need to specify the signature threshold and publicKeys array.

Returns P2WPKH Descriptor

```dart

final  response = createDescriptor(  xprv: xprv,descriptor: Descriptor.P2WPKH );

final  response = createDescriptor(  network: Network.TESTNET, 
                                     mnemonic: 'daring erase travel point pull loud peanut apart attack lobster cross surprise', 
				     password: '', 
				     type: Descriptor.P2WPKH,
				     descriptorPath: 'm/84/0/0/0/0',
				     changeDescriptorPath: 'm/84/0/0/0/1'
				  );

```
Returned response example:
```dart

{

descriptor: "wpkh([d91e6add/84/0/0/0/0]tprv8kcSk9AwERYyNvjdgRLBtu1bRYStYKZ2b1Xv1EFw7FohmrzGc9m1Mg412zxp63sEKrce1ow9JdhMmUZy882a7E6T6mgKFGZiG7GoPbwBJyG/*)"
changeDescriptor: "wpkh([d91e6add/84/0/0/0/1]tprv8kcSk9AwERYyQJ4grLguvkbfjmq18AFsuBcpkMexTG2sPJUD2QcDf3HZoGSL7nAvx9tMoYYYgA9peafo6iexR1KFVnTvSRC86XToM5CSQUr/*)"

 }

```
---


### createWallet()

Create a new wallet.

User can specify their custom mnemonic (OR can generate from generateMnemonic() method), password, network, blockChainConfigUrl, blockChainSocket5,  blockChain, walletDescriptor and pass to createWallet.
If any of the values are not specified, the default values will be used instead of it, except for the case of password and mnemonic, in which case will be generated automatically and an empty password will be applied to createWallet.
In the case of a multi-sig wallet, you can generate a custom descriptor using createDescriptor() and pass Descriptor.MULTI type.

```dart

final response  =  await BdkWallet().createWallet(  descriptor: descriptor,
                                                    changeDescriptor: changeDescriptor,
                                                    network: Network.TESTNET,
                                                    blockChainConfigUrl: "ssl://electrum.blockstream.info:60002" ,
                                                    blockchain: Blockchain.ELECTRUM
                                                 );
                                                
final response  =  await BdkWallet().createWallet(  mnemonic: mnemonic,
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

final response = await BdkWallet().getNewAddress();

```
Returned response example:
```dart

"tb1qew48u6cfxladqpumcpzl0svdqyvc9h4rqd3dtw"

```
---


### getLastUnusedAddress()
Returns the last unused address of the wallet.

```dart

final response = await BdkWallet().getLastUnusedAddress();

```

Returned response example:
```dart

"tb1qew48u6cfxladqpumcpzl0svdqyvc9h4rqd3dtw"

```
---


### getBalance()
Returns the Balance object consisting of spendable, total, confirmed, untrustedPending, trustedPending, immature balance amounts of the wallet.

```dart

final response = await BdkWallet().getBalance();
final total    = response.total;

```
Returned response example:
```dart

 "8369", // balance in sats
 
```
---


### getTransactions()
Returns a list of all the transactions made.

```dart

final response = await BdkWallet().getTransactions();

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

final response = await BdkWallet().getPendingTransactions();

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

final response = await BdkWallet().getConfirmedTransactions();

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

final response = await BdkWallet().syncWallet();
```
---


### createTransaction()
Create a Partially Signed Bitcoin Transaction.<br />
Required params: address, amount, feeRate

```dart

final psbt =  await BdkWallet().createTransaction(  recipient: 'tb1qhmk3ftsyctxf2st2fwnprwc0gl708f685t0j3t', 
						    amount: 2000, 
						    feeRate: 1
						 );

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

final psbt = 'cHNidP8BAHQBAAAAAWxkL9CW6cpdkjO2eie+MXCxnvjL/Kemjmi2bnna1e+wAQAAAAD/////AlACAAAAAAAAFgAUmz1p6HT0uW0bDRhmY1sL92YbdtawBAAAAAAAABl2qRQ0Sg9IyhUOwrkDgXZgubaLE6ZwJoisAAAAAAABAOEBAAAAAAEBTevYyZI0SDB417CFQMW87Z8YkrBtdkrHIqfn5GAxH98BAAAAAP////8CsAQAAAAAAAAZdqkUNEoPSMoVDsK5A4F2YLm2ixOmcCaIrJAHAAAAAAAAFgAUMrIFB4W5c6b7/yiu+ph/N1JI5iwCRzBEAiBx5CL5kk4rvqInQ76atWwb+lUh/WcMPLZPLZirBLjgCQIgWLy2yuubrGDdMpg1/PUangucUxlVY3mzYSsBBPW6pigBIQLntzCxsOIpzhQe7I5rV+gEW0iJXUrnryU8gAa8sOOjtwAAAAABAR+QBwAAAAAAABYAFDKyBQeFuXOm+/8orvqYfzdSSOYsIgYCfoT0VFzm9d47mVZJ5kJn0/PSMZ6WedD5r9Q9TseuyvgY2R5q3VQAAIABAACAAAAAgAEAAAASAAAAACICA3+RBKNCI5Ev2vzb2+iGZ2+ODuqxgIxi5xRTEtobkC8tGNkeat1UAACAAQAAgAAAAIABAAAAGAAAAAAA'; // psbt from createPartiallySignedTransaction()

final response = await BdkWallet().signTransaction(psbt:psbt);

```
---


### broadcastTransaction()
Send bitcoin (*sats) to a given address.<br />
Required params: psbt (Partially Signed Transaction - Signed)

```dart

final psbt = 'cHNidP8BAHQBAAAAAWxkL9CW6cpdkjO2eie+MXCxnvjL/Kemjmi2bnna1e+wAQAAAAD/////AlACAAAAAAAAFgAUmz1p6HT0uW0bDRhmY1sL92YbdtawBAAAAAAAABl2qRQ0Sg9IyhUOwrkDgXZgubaLE6ZwJoisAAAAAAABAOEBAAAAAAEBTevYyZI0SDB417CFQMW87Z8YkrBtdkrHIqfn5GAxH98BAAAAAP////8CsAQAAAAAAAAZdqkUNEoPSMoVDsK5A4F2YLm2ixOmcCaIrJAHAAAAAAAAFgAUMrIFB4W5c6b7/yiu+ph/N1JI5iwCRzBEAiBx5CL5kk4rvqInQ76atWwb+lUh/WcMPLZPLZirBLjgCQIgWLy2yuubrGDdMpg1/PUangucUxlVY3mzYSsBBPW6pigBIQLntzCxsOIpzhQe7I5rV+gEW0iJXUrnryU8gAa8sOOjtwAAAAABAR+QBwAAAAAAABYAFDKyBQeFuXOm+/8orvqYfzdSSOYsIgYCfoT0VFzm9d47mVZJ5kJn0/PSMZ6WedD5r9Q9TseuyvgY2R5q3VQAAIABAACAAAAAgAEAAAASAAAAACICA3+RBKNCI5Ev2vzb2+iGZ2+ODuqxgIxi5xRTEtobkC8tGNkeat1UAACAAQAAgAAAAIABAAAAGAAAAAAA'; // psbt id from createPartiallySignedTransaction()

final response = await BdkWallet().broadcastTransaction(psbt:psbt);

```
Returned response example:
```dart

 "9b5ecd0ee3846a891201f3c59a484fe73501d845c20b05d63c45ec92bc2c16b3", // transaction id
 
```
---


### quickSend()
Create a Partially Signed Bitcoin Transaction, Sign the transaction and Broadcast  to the given address.<br />
.<br />
Required params: address, amount, feeRate

```dart

final response = await BdkWallet().quickSend(  recipient: 'tb1qhmk3ftsyctxf2st2fwnprwc0gl708f685t0j3t', 
					       amount: 2000, 
					       feeRate: 1
					    );

```
Returned response example:
```dart

 "9b5ecd0ee3846a891201f3c59a484fe73501d845c20b05d63c45ec92bc2c16b3", // transaction id
 
```
---


_Note: Caution this is pre-Alpha at this stage
Please consider reviewing, experimenting, and contributing ⚡️_

Thanks for taking a look!
