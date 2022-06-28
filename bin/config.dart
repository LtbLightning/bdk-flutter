// #! /usr/bin/env dcli
//
// import 'dart:io';
// import 'package:dcli/dcli.dart';
// import 'package:archive/archive_io.dart';
//
// var fileUrl = 'https://github.com/bitcoindevkit/bdk-swift/releases/download/0.3.0/bdkFFI.xcframework.zip';
//
//
// void main() {
//   // Display output to console
//   print('''# ------------------------------
//   # 🚀 Installing Binaries
// # ------------------------------''');
//
//   // Ask for user input
//   final newVersion = ask(
//     'Enter enter your :',
//     validator: Ask.regExp(
//       r'^\d+\.\d+\.\d+$',
//       error: 'You must pass a valid semver version in the form X.Y.Z',
//     ),
//   );
//   install();
// }
//
// void install() {
//   if (!exists(join(assetDirectoryPath, 'bdkFFI.xcframework'))) {
//     try {
//       fetch(url: fileUrl,
//           saveToPath: binaryPath,
//           fetchProgress: (progress) {
//             print(progress);
//           });
//       extractFile(binaryPath);
//
//     } on FetchException catch (e) {
//       print('Exception Thrown: ${e.errorCode} ${e.message}');
//     }
//   } {
//     print("already downloaded");
//   }
// }
// extractFile(String path){
//   try {
//     final inputStream = InputFileStream(path);
//     // Decode the zip from the InputFileStream. The archive will have the contents of the
//     // zip, without having stored the data in memory.
//     final archive = ZipDecoder().decodeBuffer(inputStream);
//     extractArchiveToDisk(archive, assetDirectoryPath);
//     final file = File(path);
//     file.delete();
//   } catch (e) {
//     print(e);
//     return 0;
//   }
// }

//
// String get binaryPath => join(assetDirectoryPath, binaryZipName);
//
// String get binaryZipName => 'bdkFFI.xcframework.zip';