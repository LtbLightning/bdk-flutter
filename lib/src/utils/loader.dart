import 'dart:convert' as convert;
import 'dart:ffi';
import 'dart:io';

import 'package:archive/archive.dart';
import 'package:flutter/services.dart' show Uint8List, rootBundle;
import 'package:http/http.dart' as http;

import '../generated/bindings.dart';

DynamicLibrary _open() {
  if (Platform.environment['FLUTTER_TEST'] == 'true') {
    try {
      DynamicLibrary.open(getTestBinaryUrl(Directory.current));
    } catch (e) {
      throw Exception(
          "Unable to open the dylib! Try calling setCurrentDirectory()");
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

String getTestBinaryUrl(Directory dir) {
  final assetsDir =
      '${dir.path}/build/${AppConfig.unitTestDir}/${AppConfig.testBinDir}';
  if (Platform.isMacOS) {
    return "$assetsDir/${AppConfig.macosTestBinUrl}";
  } else {
    throw Exception("not support platform:${Platform.operatingSystem}");
  }
}

final bdkFfi = RustBdkFfiImpl(_open());

class AppConfig {
  static Map<String, dynamic>? _config;
  static Future<void> _loadJsonAsset() async {
    final String jsonString =
        await rootBundle.loadString("packages/bdk_flutter/assets/config.json");
    _config = convert.jsonDecode(jsonString);
  }

  static Future<void> setBuildDirectory(String dir) async {
    await _loadJsonAsset();
    final assetsDir = '$dir/$unitTestDir';

    if (!(await Directory('$assetsDir/$testBinDir').exists())) {
      try {
        final response = await http.get(Uri.parse(remoteUrl));
        if (response.statusCode == 200) {
          final bytes = response.bodyBytes;
          final archive = ZipDecoder().decodeBytes(Uint8List.fromList(bytes));
          for (final file in archive) {
            final filename = '$assetsDir/${file.name}';
            if (file.isFile) {
              final fileContent = await File(filename).create(recursive: true);
              await fileContent.writeAsBytes(file.content);
            } else {
              await Directory(filename).create(recursive: true);
            }
          }
        } else {
          print('Download failed: status code ${response.statusCode}!');
        }
      } catch (e) {
        print(e.toString());
      }
    }
  }

  static String get remoteUrl => _config!['remote_url'];
  static String get testBinDir => _config!['test_bin_dir'];
  static String get unitTestDir => _config!['unit_test_dir'];
  static String get macosTestBinUrl => _config!['macos_test_bin_dir'];
}
