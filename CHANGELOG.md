## [0.3.2]

### Fixed
- iOS build issue when using flovors 
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
   - newBip44 constructor returns a Descriptor with structure pkh(key/44'/{0,1}'/0'/{0,1}/*)
   - newBip44Public constructor returns a Descriptor with structure pkh(key/{0,1}/*)
   - newBip49 constructor returns a Descriptor with structure sh(wpkh(key/49'/{0,1}'/0'/{0,1}/*))
   - newBip49Public constructor returns a Descriptor with structure sh(wpkh(key/{0,1}/*))
   - newBip84 constructor returns a Descriptor with structure wpkh(key/84'/{0,1}'/0'/{0,1}/*)
   - newBip84Public constructor returns a Descriptor with structure wpkh(key/{0,1}/*)
   - asString returns the public version of the output descriptor in String format
   - asPrivateString returns the private version of the output descriptor if available, otherwise, return the public version

### Fixed

- Dependencies Upgraded

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
