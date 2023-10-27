import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:http/http.dart' as http;

import '../generated/bindings.dart';

DynamicLibrary _open() {
  if (Platform.environment['FLUTTER_TEST'] == 'true') {
    try {
      DynamicLibrary.open(_getTestPlatformFileName(Directory.current));
    } catch (e) {
      throw Exception("Unable to open the dylib! Try calling setTestEnv().");
    }
  }
  if (Platform.isIOS || Platform.isMacOS) {
    return DynamicLibrary.executable();
  } else if (Platform.isAndroid) {
    return DynamicLibrary.open("librust_bdk_ffi.so");
  } else {
    return DynamicLibrary.executable();
  }
}

final bdkFfi = RustBdkFfiImpl(_open());

Future<void> setDirEnv({required String dir}) async {
  final buildDir = '$dir/build';
  if (!(await Directory('$buildDir/$_ktestBdkBinDir').exists())) {
    final response = await http.get(Uri.parse(
        'https://github.com/LtbLightning/bdk-flutter/releases/bin/bdk_bin_0.29.3.zip'));
    if (response.statusCode == 200) {
      final bytes = response.bodyBytes;
      final archive = ZipDecoder().decodeBytes(Uint8List.fromList(bytes));
      for (final file in archive) {
        final filename = '$buildDir/unit_test_assets/${file.name}';
        if (file.isFile) {
          final fileContent = await File(filename).create(recursive: true);
          await fileContent.writeAsBytes(file.content);
        } else {
          await Directory(filename).create(recursive: true);
        }
      }
    } else {
      print('Status code: ${response.statusCode}');
    }
  }
}

String _getTestPlatformFileName(Directory dir) {
  final build_dir = "${dir.path}/build";
  final path = '$build_dir/$_ktestBdkBinDir';
  if (Platform.isMacOS) {
    return "$path/$_kMacOSTestDylib";
  } else if (Platform.isWindows) {
    return "$path/$_kWindowsTestLib";
  } else if (Platform.isLinux) {
    return "$path/$_kLinuxTestLib";
  } else {
    throw Exception("not support platform:${Platform.operatingSystem}");
  }
}

const String _ktestBdkBinDir = 'unit_test_assets/bdk_bin_0.29.3';
const String _kMacOSTestDylib = 'macos/librust_bdk_ffi.dylib';
const String _kWindowsTestLib = 'windows/librust_bdk_ffi.dll';
const String _kLinuxTestLib = 'linux/librust_bdk_ffi.so';
