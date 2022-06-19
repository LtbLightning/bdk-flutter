#! /usr/bin/env dcli

import 'dart:io';
import 'package:dcli/dcli.dart';
import 'dart:io';
import 'package:archive/archive_io.dart';

var fileUrl = 'https://github.com/bitcoindevkit/bdk-swift/releases/download/0.3.0/bdkFFI.xcframework.zip';
final appDataDir = Directory.current;
final destinationDir = Directory("${appDataDir.path}/ios/Assets");



/// installs (if necessary) and runs mailhog
void main() {

  install();
  run();

}

Future<void> run() async {
  binaryPath.run;
  await Process.run('adb' , ['shell' ,'pm', 'grant', 'com.MYSERVICE', 'android.permission.ACCESS_FINE_LOCATION']);
  print(green('Starting Bdk Config'));
  print(orange('Access bdk at: https://github.com/bitcoindevkit/bdk-swift'));

}

void install() {
  if (!exists(assetDirectoryPath)) {
    createDir(assetDirectoryPath, recursive: true);
  }

  if (!exists(binaryPath)) {
    try {
      fetch(url: fileUrl,
          saveToPath: binaryPath,
          fetchProgress: (progress) {
            print(progress);
          });
      extractFile(binaryPath);

    } on FetchException catch (e) {
      print('Exception Thrown: ${e.errorCode} ${e.message}');
    }
  }
}
 extractFile(String path){
   try {
     final inputStream = InputFileStream(path);
     // Decode the zip from the InputFileStream. The archive will have the contents of the
     // zip, without having stored the data in memory.
     final archive = ZipDecoder().decodeBuffer(inputStream);
     extractArchiveToDisk(archive, 'ios/');
     final file = File(path);
     file.delete();
   } catch (e) {
     print(e);
     return 0;
   }
 }
String get assetDirectoryPath {
  Directory current = Directory.current;
  return join(current.path, 'ios');
}

String get binaryPath => join(assetDirectoryPath, binaryZipName);

String get binaryZipName => 'bdkFFI.xcframework.zip';