## Bdk-Flutter
A Flutter library of the Bitcoin Development Kit (https://bitcoindevkit.org/)


## Table of Contents

- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)
- [Library API](#library-api)


## Requirements

### Flutter

* Flutter version :  3.0 or higher
* Dart version    :  2.17.1 or higher

### Android

* Android minSdkVersion.     : API 23 or higher.
* Android Target SDK version : API 29.


### iOS

* iOS Base SDK      : 12 or greater.
* Deployment target : iOS 12.0 or greater.


## Installation

To use this plugin, add bdk-flutter as a dependency in your pubspec.yaml file.

### Configuring iOS

Please navigate to the iOS folder in your project run the following command:
```
pod install
```

## Sample applications
* **BDK Flutter Demo App:** The [BDK Flutter Demo App](https://github.com/LtbLightning/bdk-flutter-app)
  is a simple bitcoin app built in flutter to serve as a reference app to demonstrate bdk-flutter api usage.


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
| [createXpub()](#createXpub)                    | - network, mnemonic, password                                                              |
| [createDescriptors()](#createDescriptors)        | - xprv, type, mnemonic, network, password, publicKeys, threshold , descriptorPath, changeDescriptorPath|
| [createWallet()](#createWallet)                | - mnemonic, password, descriptor, changeDescriptor, network, blockchainConfig|                                                                                                                                                 
| [getNewAddress()](#getNewAddress)              | -                                                                                          | 
| [getLastUnusedAddress()](#getLastUnusedAddress)| -                                                                                          |       
| [getBalance()](#getbalance)                    | -                                                                                          |
| [getTransactions()](#getTransactions)          | -                                                                                          | 
| [getPendingTransactions()](#getPendingTransactions)| -                                                                                      |
| [getConfirmedTransactions()](#getConfirmedTransactions)| -                                                                                  |
| [syncWallet()](#syncWallet)                    | -                                                                                          | 
| [createTx()](#createTx)                        | - address (recipient wallet address), amount*(sats) , feeRate                              |
| [signTx()](#signTx)                            | - psbt                                                                                     |
| [broadcastTx()](#broadcastTx)                  | - sbt                                                                                      |  
| [quickSend()](#quickSend)                      | - address (recipient wallet address), amount*(sats) , feeRate                              |

---

### generateMnemonic()
Generate a random mnemonic seed phrase.<br />
Reference: https://github.com/bitcoin/bips/blob/master/bip-0039.mediawiki#generating-the-mnemonic <br />
This will generate a mnemonic sentence from the English word list. The required entropy can be specified as the entropy parameter and 
can be in multiples of 64 from 128 to 256, 128 is used as default. A word count or length can be specified instead as the length 
parameter and can be in multiples of 6 from 12 to 24. 12 is used as default.

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
This method will create an ExtendedKeyInfo object using the specified mnemonic seed phrase and password. 
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


### createDescriptors()
Create a WalletDescriptor object containing descriptor and changedescriptor using xprv or mnemonic.
Xprv will be used if passed otherwise mnemonic, network and password will be used.
Type is an enum and can be one of P2PK, P2PKH, P2WPKH, P2SHP2WPKH, P2SHP2WSHP2PKH, MULTI. P2WPKH is used as default.

If type is MULTI then need to specify the signature threshold and publicKeys array.

```dart

final  response = createDescriptor(  network: Network.TESTNET, 
                                     mnemonic: 'puppy interest whip tonight dad never sudden response push zone pig patch', 
				     password: '', 
				     type: Descriptor.P2WPKH,
				     descriptorPath: "m/84'/0'/0'",
                                     changeDescriptorPath: "m/84'/0'/1'",
				  );

```
Returned response example:
```dart

{

descriptor: "wpkh([d91e6add/84'/0'/0']tprv8gnnA5Zcbjai6d1mWvQatrK8c9eHfUAKSgJLoHfiryJb6gNBnQeAT7UuKKFmaBJUrc7pzyszqujrwxijJbDPBPi5edtPsm3jZ3pnNUzHbpm/*)"
changeDescriptor: "wpkh([d91e6add/84'/0'/1']tprv8gnnA5Zcbjai9Wfiec82h4oP8R92SNuNFFD5g8Kqu8hMd3kb8h93wGynk4vgCH3tfoGkDvCroMtqaiMGnqHudQoEYd89297VuybvNWfgPuL/*)"

 }

```
---


### createWallet()

Create a new wallet.

User can specify their custom mnemonic (OR can generate from generateMnemonic() method), password, network, blockchainConfig, walletDescriptor and pass to createWallet.
If any of the values are not specified, the default values will be used instead of it, except for the case of password and mnemonic, in which case will be generated automatically and an empty password will be applied to createWallet.
In the case of a multi-sig wallet, you can generate a custom descriptor using createDescriptor() and pass Descriptor.MULTI type.

```dart

final response  =  await BdkFlutter().createWallet(  descriptor: descriptor,
                                                    changeDescriptor: changeDescriptor,
                                                    network: Network.TESTNET,
						    blockchainConfig: BlockchainConfig.electrum
						    (
						        config: ElectrumConfig(
                                                                   stopGap: 10,
                                                                   retry: 5,
                                                                   url: "ssl://electrum.blockstream.info:60002")
						     )
                                                    
                                                 );
                                                
final response  =  await BdkFlutter().createWallet(  mnemonic: mnemonic,
                                                    password: password,
                                                    network: Network.TESTNET,
                                                    blockchainConfig: BlockchainConfig.electrum
						    (
						        config: ElectrumConfig(
                                                                   stopGap: 10,
                                                                   retry: 5,
                                                                   url: "ssl://electrum.blockstream.info:60002")
						     )
                                                    
                                                 );
						    
```
Returned response example:
```dart

{

address: "tb1ql5pqtl36xu6z4czdvsd9lr5fa6fyld49dff4gw"
balance: 100000

}

```

---


### getNewAddress()
Create a new address for the wallet.

```dart

final response = await BdkFlutter().getNewAddress();

```
Returned response example:
```dart

"tb1qew48u6cfxladqpumcpzl0svdqyvc9h4rqd3dtw"

```
---


### getLastUnusedAddress()
Returns the last unused address of the wallet.

```dart

final response = await BdkFlutter().getLastUnusedAddress();

```

Returned response example:
```dart

"tb1qew48u6cfxladqpumcpzl0svdqyvc9h4rqd3dtw"

```
---


### getBalance()
Returns the Balance object consisting of spendable, totoal, confirmed, untrustedPending, trustedPending, immature balances of your wallet.

```dart

final response = await BdkFlutter().getBalance();
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

final response = await BdkFlutter().getTransactions();

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

final response = await BdkFlutter().getPendingTransactions();

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

final response = await BdkFlutter().getConfirmedTransactions();

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


### createTx()
Creates bitcoin transaction. This can transaction can later be signed and broadcast. The transaction created is a Partially Signed Bitcoin Transaction(psbt).<br />
Required params: address, amount, feeRate

```dart

final psbt =  await BdkFlutter().createTx(   recipient: 'tb1qhmk3ftsyctxf2st2fwnprwc0gl708f685t0j3t', 
					     amount: 2000, 
				             feeRate: 1
			                 );

```
Returned response example:
```dart
 'cHNidP8BAHQBAAAAAWxkL9CW6cpdkjO2eie+MXCxnvjL/Kemjmi2bnna1e+wAQAAAAD/////AlACAAAAAAAAFgAUmz1p6HT0uW0bDRhmY1sL92YbdtawBAAAAAAAABl2qRQ0Sg9IyhUOwrkDgXZgubaLE6ZwJoisAAAAAAABAOEBAAAAAAEBTevYyZI0SDB417CFQMW87Z8YkrBtdkrHIqfn5GAxH98BAAAAAP////8CsAQAAAAAAAAZdqkUNEoPSMoVDsK5A4F2YLm2ixOmcCaIrJAHAAAAAAAAFgAUMrIFB4W5c6b7/yiu+ph/N1JI5iwCRzBEAiBx5CL5kk4rvqInQ76atWwb+lUh/WcMPLZPLZirBLjgCQIgWLy2yuubrGDdMpg1/PUangucUxlVY3mzYSsBBPW6pigBIQLntzCxsOIpzhQe7I5rV+gEW0iJXUrnryU8gAa8sOOjtwAAAAABAR+QBwAAAAAAABYAFDKyBQeFuXOm+/8orvqYfzdSSOYsIgYCfoT0VFzm9d47mVZJ5kJn0/PSMZ6WedD5r9Q9TseuyvgY2R5q3VQAAIABAACAAAAAgAEAAAASAAAAACICA3+RBKNCI5Ev2vzb2+iGZ2+ODuqxgIxi5xRTEtobkC8tGNkeat1UAACAAQAAgAAAAIABAAAAGAAAAAAA', // psbt id
 
```
---


### signTx()
Signs a bitcoin transaction with the associated private key as per the descriptor used to create the wallet. The method accepts an unsigned Partially Signed Bitcoin Transaction(psbt) and returns a signed psbt.<br />
Required params: psbt (Partially Signed Bitcoin Transaction)

```dart

final psbt = 'cHNidP8BAHQBAAAAAWxkL9CW6cpdkjO2eie+MXCxnvjL/Kemjmi2bnna1e+wAQAAAAD/////AlACAAAAAAAAFgAUmz1p6HT0uW0bDRhmY1sL92YbdtawBAAAAAAAABl2qRQ0Sg9IyhUOwrkDgXZgubaLE6ZwJoisAAAAAAABAOEBAAAAAAEBTevYyZI0SDB417CFQMW87Z8YkrBtdkrHIqfn5GAxH98BAAAAAP////8CsAQAAAAAAAAZdqkUNEoPSMoVDsK5A4F2YLm2ixOmcCaIrJAHAAAAAAAAFgAUMrIFB4W5c6b7/yiu+ph/N1JI5iwCRzBEAiBx5CL5kk4rvqInQ76atWwb+lUh/WcMPLZPLZirBLjgCQIgWLy2yuubrGDdMpg1/PUangucUxlVY3mzYSsBBPW6pigBIQLntzCxsOIpzhQe7I5rV+gEW0iJXUrnryU8gAa8sOOjtwAAAAABAR+QBwAAAAAAABYAFDKyBQeFuXOm+/8orvqYfzdSSOYsIgYCfoT0VFzm9d47mVZJ5kJn0/PSMZ6WedD5r9Q9TseuyvgY2R5q3VQAAIABAACAAAAAgAEAAAASAAAAACICA3+RBKNCI5Ev2vzb2+iGZ2+ODuqxgIxi5xRTEtobkC8tGNkeat1UAACAAQAAgAAAAIABAAAAGAAAAAAA'; // psbt id from createPartiallySignedTransaction()

final response = await BdkFlutter().signTx(psbt:psbt);

```
Returned response example:
```dart

"cHNidP8BAHQBAAAAAWO9QVybfmhTpK6qzTVcf9yeiui/a0iNmTgljuw29UeQAQAAAAD+////AsUwEwAAAAAAFgAUbNeMOfAF9QTOiFfrlhV8bQnXWVnoAwAAAAAAABl2qRQ0Sg9IyhUOwrkDgXZgubaLE6ZwJois4NYjAAABAOEBAAAAAAEBHIAjDPiXGopfbzyQGDCQ/UjKxT2rhurl5iYZWIrY0ycAAAAAAP7///8C6AMAAAAAAAAZdqkUNEoPSMoVDsK5A4F2YLm2ixOmcCaIrD01EwAAAAAAFgAUHjTI1PY9tTZPado27T8PTGITvIUCRzBEAiA/C1zSpBrEZkgHwt1sfcadj13OUruw6eofeOVk2aHhUAIgLf/sYhD3kv8+nZrM5atuyYwKXCMDuNBPldaO2FQpxBUBIQPCWh5gAGcSYqmTy9aVpFb96u5Sgp+hjs/JDg+6SgKqVeDWIwABAR89NRMAAAAAABYAFB40yNT2PbU2T2naNu0/D0xiE7yFIgYChXdsXDGO5LXjWfyh3rRkTZzfPDbWmBBZHSKDesNSrggU2R5q3VQAAIAAAACAAQAAgD0AAAABBwABCGsCRzBEAiAo6eGvjAWQdyefCuSphc8FJewM9BZzgOhXJW9Uf+hQfAIgVvNJ6D7YC+MSqS01aMiTZ+0T2NJlXZLJFCBl585wescBIQKFd2xcMY7kteNZ/KHetGRNnN88NtaYEFkdIoN6w1KuCAAiAgKX6sfAUUzaIV9h3amzY+Wnxalxmi9T6lZZ76CBlWjB5RTZHmrdVAAAgAAAAIABAACAPgAAAAAA" //  sbt ( Signed Bitcoin Transaction)
  
```
---


### broadcastTx()
Broadcasts a signed bitcoin transaction to the bitcoin network. The transaction is sent to the bitcoin node associated with the blockchain config that was used to create the wallet. The method accepts a signed bitcoin transaction. The psbt returned by signTx can be passed to broadcastTx().<br />
Required params: sbt ( Signed Bitcoin Transaction)

```dart

final sbt = 'cHNidP8BAHQBAAAAAWO9QVybfmhTpK6qzTVcf9yeiui/a0iNmTgljuw29UeQAQAAAAD+////AsUwEwAAAAAAFgAUbNeMOfAF9QTOiFfrlhV8bQnXWVnoAwAAAAAAABl2qRQ0Sg9IyhUOwrkDgXZgubaLE6ZwJois4NYjAAABAOEBAAAAAAEBHIAjDPiXGopfbzyQGDCQ/UjKxT2rhurl5iYZWIrY0ycAAAAAAP7///8C6AMAAAAAAAAZdqkUNEoPSMoVDsK5A4F2YLm2ixOmcCaIrD01EwAAAAAAFgAUHjTI1PY9tTZPado27T8PTGITvIUCRzBEAiA/C1zSpBrEZkgHwt1sfcadj13OUruw6eofeOVk2aHhUAIgLf/sYhD3kv8+nZrM5atuyYwKXCMDuNBPldaO2FQpxBUBIQPCWh5gAGcSYqmTy9aVpFb96u5Sgp+hjs/JDg+6SgKqVeDWIwABAR89NRMAAAAAABYAFB40yNT2PbU2T2naNu0/D0xiE7yFIgYChXdsXDGO5LXjWfyh3rRkTZzfPDbWmBBZHSKDesNSrggU2R5q3VQAAIAAAACAAQAAgD0AAAABBwABCGsCRzBEAiAo6eGvjAWQdyefCuSphc8FJewM9BZzgOhXJW9Uf+hQfAIgVvNJ6D7YC+MSqS01aMiTZ+0T2NJlXZLJFCBl585wescBIQKFd2xcMY7kteNZ/KHetGRNnN88NtaYEFkdIoN6w1KuCAAiAgKX6sfAUUzaIV9h3amzY+Wnxalxmi9T6lZZ76CBlWjB5RTZHmrdVAAAgAAAAIABAACAPgAAAAAA'; // psbt id from createPartiallySignedTransaction()

final response = await BdkFlutter().broadcastTx(sbt:sbt);

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

final response = await BdkFlutter().quickSend( recipient: 'tb1qhmk3ftsyctxf2st2fwnprwc0gl708f685t0j3t', 
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
