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

To use this plugin, add `bdk_flutter` as a dependency in your pubspec.yaml file.

## Sample applications

* **BDK Flutter Demo App:** The [BDK Flutter Demo App](https://github.com/LtbLightning/bdk-flutter-app)
  is a simple testnet Bitcoin wallet built as a reference app for the bdk-flutter on Flutter.

## Usage

```dart

import 'package:bdk_flutter/bdk_flutter.dart';

```

## API Documentation

The Latest API documentation is available [here](https://pub.dev/documentation/bdk_flutter/latest/bdk_flutter/bdk_flutter-library.html)


## Building from Rust Code

bdk_flutter uses bdk at its core, which is written in rust. To build, from the rust code or if you wish to make changes to the rust code and build, please consider the following.


### Cloning

Install [Rust](https://doc.rust-lang.org/cargo/getting-started/installation.html)

And then clone the repository:

```bash

git clone https://github.com/LtbLightning/bdk-flutter.git

```
### Environment Setup

In order to build and generate bindings from scratch for android, you will need install Andorid NDK. Click here to know more about [Android NDK](https://developer.android.com/ndk)

#### Android 

Once NDK installed, specify your NDK path location ANDROID_NDK_HOME in `rust/makefile`

Replace line ANDROID_NDK_HOME=(path to NDK) in rust/makefile.

### Generating Rust-to-Flutter-bindings

Wrapper codes for [bdk](https://crates.io/crates/bdk) is in `rust/src/r_api.rs file`, please include your public functions in r_api.rs, if you want to build new functions, so that the code generator can generate the binaries, and the bindings code properly.
 
Once you are ready, please navigate to the `rust` directory, and run  the following commands

```rust

cargo build

make all

```
#### Updating Binary Files 

After building the code run the following bash command to replace the binaries with the new ones

```bash

sh zip.sh

```
Once the script finishes running, you should see the new binaries in the ./ios and android/src/main/jniLibs folders. 

## Generating Docs Manually

The API documentation is automatically generated and available on pub.dev when package is published. To generate manually please use the [Dart documentation generator](https://pub.dev/packages/dartdoc) to generate the API documentation manually. 


Thanks for checking out the bdk_flutter code! We're excited to hear and learn from you. Your experiences will benefit others who read and use these guides.

_Note: Caution this is pre-Alpha at this stage
Please consider reviewing, experimenting, and contributing ⚡️_

Thanks for taking a look!
