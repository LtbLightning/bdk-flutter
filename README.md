## Bdk-Flutter
A Flutter implementation of the  [Bitcoin Development Kit](https://bitcoindevkit.org/)


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

All methods work in iOS: ✅

All methods work in Android: ✅

**All methods return the response as follows:**


The following methods can be used with this module. All methods can be called by the BdkWallet object.



| Method                                         | Request Parameters                                                                         |
| ---------------------------------              | ------------------------------------------------------------------------------------------ |
| [generateMnemonic()](#generateMnemonic)        | - wordCount, entropy                                                                       |
| [createDescriptors()](#createDescriptors)      | - xprv, type, mnemonic, network, password, publicKeys, threshold , derivationPath    |
| [createWallet()](#createWallet)                | - mnemonic, password, descriptor, changeDescriptor, network, blockchainConfig              |     
| [createExtendedKey()](#createExtendedKey)      | - network, mnemonic, password                                                              |
| [createXprv()](#createXprv)                    | - network, mnemonic, password                                                              |
| [createXpub()](#createXpub)                    | - network, mnemonic, password                                                              |                                                                                                                                
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
Generates a random mnemonic seed phrase.<br />
Reference: https://github.com/bitcoin/bips/blob/master/bip-0039.mediawiki#generating-the-mnemonic <br />
This will generate a mnemonic sentence from the English word list.

The required `entropy` can be specified as the entropy parameter and
can be in multiples of `64` from `128 to 256`, `128` is used as default.

A `wordCount` or length can be specified instead as the length
parameter and can be in multiples of `6` from `12 to 24`.

```dart

final response = await generateMnemonic()
final  response = await generateMnemonic(entropy: Entropy.Entropy128)

```
Returned response example:
```dart

"daring erase travel point pull loud peanut apart attack lobster cross surprise actress dolphin gift journey mystery save"

```
---

### createDescriptors()

Create a `WalletDescriptor` object containing a descriptor and a change descriptor, using `xprv`  or `mnemonic`.

`xprv` or `xpub` will be used if passed otherwise `mnemonic`, `network` and `password` will be used depending on the availability.

`type` is an enum and can be one of `P2PK, P2PKH, P2WPKH, P2SHP2WPKH, P2SHP2WSHP2PKH, MULTI`. `P2WPKH` is used as default.

If `type` is `MULTI` then need to specify the signature `threshold` and `publicKeys` array.
`derivationPath` is optional, `m/84'/1'/0'` is used by default


```dart

final  response = await createDescriptor(   
                         network: Network.TESTNET, 
					     mnemonic: 'puppy interest whip tonight dad never sudden response push zone pig patch', 
					     password: '', 
					     type: Descriptor.P2WPKH,
					     derivationPath: "m/84'/1'/0'",
				         );

```
Returned response example:
```dart

{

descriptor: "wpkh([d91e6add/84'/1'/0']tprv8g2W7sNhrubz3auYxkXBA2fSS7kPwjf7GKESKWG8TDSCro7Q4EaCbNxTgKuiJU9yfg1JMp7hNCJBnt1gvqcEAkUn4XnJfdeQHdXgJMDc2uH/0/*)"
changeDescriptor: "wpkh([d91e6add/84'/1'/0']tprv8g2W7sNhrubz3auYxkXBA2fSS7kPwjf7GKESKWG8TDSCro7Q4EaCbNxTgKuiJU9yfg1JMp7hNCJBnt1gvqcEAkUn4XnJfdeQHdXgJMDc2uH/1/*)"

 }

```
---


### createWallet()

Creates a new wallet. A wallet can be created using a `mnemonic` or `wallet output descriptor`.

#### Creating a wallet using `mnemonic`

To create a wallet with a `mnemonic`, menmonic argument has to be specified and `descriptor` and `changeDescriptor` should not be specified.
All other parameters are optional and will take `default` values if not specified.
A known `mnemonic` can be used when restoring a wallet, or a new `mnemonic` can be created using `generateMnemonic` method.


```dart
                                                
final aliceWallet  =  await BdkFlutter().createWallet( mnemonic:"puppy interest whip tonight dad never sudden response push zone pig patch",
                                                       password: "password",
                                                       network: Network.TESTNET,
                                                       blockchainConfig: BlockchainConfig.electrum
						        (
						         config: ElectrumConfig(
                                                                   stopGap: 10,
								   timeout: 5,
								   retry: 5,
                                                                   url: "ssl://electrum.blockstream.info:60002")
						         )
                                                    
                                                      );
						 
final aliceWallet  =  await BdkFlutter().createWallet( mnemonic:"puppy interest whip tonight dad never sudden response push zone pig patch" );						 
						    
```

#### Creating a wallet using `descriptor`.

A `descriptor` has to be specified and mnemonic should not be specified. All other arguments are optional and will take `default` values when not specified.
A known `descriptor` and `changeDescriptor` can be used. `createDescritpors` method can be used to create a `descriptor` and `changeDescriptor`


```dart

final daveWallet  =  await BdkFlutter().createWallet( 
							descriptor: "wpkh([d91e6add/84'/1'/0']tprv8g2W7sNhrubz3auYxkXBA2fSS7kPwjf7GKESKWG8TDSCro7Q4EaCbNxTgKuiJU9yfg1JMp7hNCJBnt1gvqcEAkUn4XnJfdeQHdXgJMDc2uH/0/*)"
							changeDescriptor: "wpkh([d91e6add/84'/1'/0']tprv8g2W7sNhrubz3auYxkXBA2fSS7kPwjf7GKESKWG8TDSCro7Q4EaCbNxTgKuiJU9yfg1JMp7hNCJBnt1gvqcEAkUn4XnJfdeQHdXgJMDc2uH/1/*)"
							network: Network.TESTNET,
						        blockchainConfig: BlockchainConfig.electrum
						         (
								config: ElectrumConfig(
									   stopGap: 10,
									   retry: 5,
									   url: "ssl://electrum.blockstream.info:60002")
						          )
                                                    
                                                      );						 


final aliceWallet  =  await BdkFlutter().createWallet( descriptor: "wpkh([d91e6add/84'/1'/0']tprv8g2W7sNhrubz3auYxkXBA2fSS7kPwjf7GKESKWG8TDSCro7Q4EaCbNxTgKuiJU9yfg1JMp7hNCJBnt1gvqcEAkUn4XnJfdeQHdXgJMDc2uH/0/*)" );
						 
```						 
                                                
Returns a `BdkWallet` Object:


---


### createExtendedKey()
This method will create an `ExtendedKeyInfo` object using the specified `mnemonic` seed phrase and password. 
`ExtendedKeyInfo` creates a key object which encapsulates the mnemonic and adds a `private key` using the mnemonic and password.

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
	    xpub: "tpubDGdv2vah1pfxrqrHLgD7nYSE2RdbR9ExMQahBWcgsDt7PFdcXtV97jWc8tkXrFHDbKeyoKjPQaJ9UxA5xLEWvU1zv1h7JxdvsTMNpdBjsb9/*"
	    xprv: "tprv8jwstWYSsSzHyNpVT2YXP8n7TQ7fFp43n6yutzaPSx5iYmNquVfYwEtjxm2Wynm3NWjTfutiDr1AXXPFVwSyrZE7ixgycbpbqAkQ1GzcVx9/*"
 }
 
```
---


### createXprv()
Creates the `private key` using `mnemonic` phrase and password.

```dart

final response = await createXprv(  network: Network.TESTNET, 
                                     mnemonic: 'daring erase travel point pull loud peanut apart attack lobster cross surprise', 
				     password: '' 
				  );

```
Returned response example:
```dart

"tprv8jwstWYSsSzHyNpVT2YXP8n7TQ7fFp43n6yutzaPSx5iYmNquVfYwEtjxm2Wynm3NWjTfutiDr1AXXPFVwSyrZE7ixgycbpbqAkQ1GzcVx9/*"

```
---


### createXpub()
Create the `public key` using a `mnemonic` phrase and password.

```dart

final  response = await createXpub(  network: Network.TESTNET, 
                                     mnemonic: 'daring erase travel point pull loud peanut apart attack lobster cross surprise', 
				     password: '' 
				  );

```
Returned response example:
```dart

"tpubDGdv2vah1pfxrqrHLgD7nYSE2RdbR9ExMQahBWcgsDt7PFdcXtV97jWc8tkXrFHDbKeyoKjPQaJ9UxA5xLEWvU1zv1h7JxdvsTMNpdBjsb9/*"

```
---


### getNewAddress()
Creates a new `address` for the wallet.

```dart

final response = await aliceWallet.getNewAddress();

```
Returned response example:
```dart

"tb1q5knz6ynpzlsnq3ezj97lh99sh3pac6easfml8h"

```
---


### getLastUnusedAddress()
Returns the `last unused address` of the wallet.

```dart

final response = await aliceWallet.getLastUnusedAddress();

```

Returned response example:
```dart

"tb1qrd4qlk3aw9mhn4wn949lfnxw23fgz0sz0kwqrn"

```
---


### getBalance()
Returns the `Balance object` consisting of `spendable`, `total`, `confirmed`, `untrustedPending`, `trustedPending`, and `immature` balances of your wallet.

```dart

final response = await aliceWallet.getBalance();
final total    = response.total;

```
Returned response example:
```dart

 0 // balance in sats
 
```
---


### getTransactions()
Returns a list of all the `transactions` made.

```dart

final response = await aliceWallet.getTransactions();

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
---


### getPendingTransactions()
Returns the list of `unconfirmed` transactions.

```dart

final response = await aliceWallet.getPendingTransactions();

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
---


### getConfirmedTransactions()
Returns the list of `confirmed` transactions.

```dart

final response = await aliceWallet.getConfirmedTransactions();

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
---


### syncWallet()
`Syncs` the wallet.

```dart

final response = await BdkWallet()aliceWallet.syncWallet();
```
---


### createTx()
Creates a `bitcoin transaction`. This can transaction can later be signed and broadcast. The transaction created is a `Partially Signed Bitcoin Transaction(psbt)`.<br />
Required params: address, amount, feeRate

```dart

final psbt =  await aliceWallet.createTx(   recipient: 'tb1qhmk3ftsyctxf2st2fwnprwc0gl708f685t0j3t', 
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
Signs a bitcoin transaction with the associated private key as per the descriptor used to create the wallet. The method accepts an unsigned `Partially Signed Bitcoin Transaction(psbt)` and returns a signed `psbt`.<br />
Required params: psbt (Partially Signed Bitcoin Transaction)

```dart

final psbt = 'cHNidP8BAHQBAAAAAWxkL9CW6cpdkjO2eie+MXCxnvjL/Kemjmi2bnna1e+wAQAAAAD/////AlACAAAAAAAAFgAUmz1p6HT0uW0bDRhmY1sL92YbdtawBAAAAAAAABl2qRQ0Sg9IyhUOwrkDgXZgubaLE6ZwJoisAAAAAAABAOEBAAAAAAEBTevYyZI0SDB417CFQMW87Z8YkrBtdkrHIqfn5GAxH98BAAAAAP////8CsAQAAAAAAAAZdqkUNEoPSMoVDsK5A4F2YLm2ixOmcCaIrJAHAAAAAAAAFgAUMrIFB4W5c6b7/yiu+ph/N1JI5iwCRzBEAiBx5CL5kk4rvqInQ76atWwb+lUh/WcMPLZPLZirBLjgCQIgWLy2yuubrGDdMpg1/PUangucUxlVY3mzYSsBBPW6pigBIQLntzCxsOIpzhQe7I5rV+gEW0iJXUrnryU8gAa8sOOjtwAAAAABAR+QBwAAAAAAABYAFDKyBQeFuXOm+/8orvqYfzdSSOYsIgYCfoT0VFzm9d47mVZJ5kJn0/PSMZ6WedD5r9Q9TseuyvgY2R5q3VQAAIABAACAAAAAgAEAAAASAAAAACICA3+RBKNCI5Ev2vzb2+iGZ2+ODuqxgIxi5xRTEtobkC8tGNkeat1UAACAAQAAgAAAAIABAAAAGAAAAAAA'; // psbt id from createPartiallySignedTransaction()

final response = await aliceWallet.signTx(psbt:psbt);

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

final response = await aliceWallet.broadcastTx(sbt:sbt);

```
Returned response example:
```dart
  
  "9b5ecd0ee3846a891201f3c59a484fe73501d845c20b05d63c45ec92bc2c16b3", // transaction id
 
```
---


### quickSend()
Creates a `Partially Signed Bitcoin Transaction`, `Signs` the transaction, and `Broadcasts` to the given address.<br />
.<br />
Required params: address, amount, feeRate

```dart

final response = await aliceWallet.quickSend( recipient: 'tb1qhmk3ftsyctxf2st2fwnprwc0gl708f685t0j3t',
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
