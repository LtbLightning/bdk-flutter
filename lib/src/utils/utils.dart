import 'dart:io';

import 'package:flutter/cupertino.dart';

import '../generated/frb_generated.dart';

export 'exceptions.dart';
//
// void simpleBuild(List<String> args) async {
//   final rustCrateDir = buildConfig.packageRoot.resolve('rust');
//
//   final cargoNightly = true;
//   final cargoExtraArgs =
//       Platform.environment['FRB_SIMPLE_BUILD_CARGO_EXTRA_ARGS']?.split(' ') ??
//           const <String>[];
//   final skip = Platform.environment['FRB_SIMPLE_BUILD_SKIP'] == '1';
//   final rustflags = Platform.environment['RUSTFLAGS'];
//
//   if (skip) {
//     print(
//         'frb_utils::simpleBuild SKIP BUILD since environment variable requires this');
//   } else {
//     await runCommand(
//       'cargo',
//       [
//         '+nightly',
//         'build',
//         '--release',
//         ...cargoExtraArgs,
//       ],
//       pwd: rustCrateDir.toFilePath(),
//       printCommandInStderr: true,
//       env: {
//         // Though runCommand auto pass environment variable to commands,
//         // we do this to explicitly show this important flag
//         if (rustflags != null) 'RUSTFLAGS': rustflags,
//       },
//     );
//   }
//
//   final dependencies = {
//     rustCrateDir,
//     buildConfig.packageRoot.resolve('build.rs'),
//   };
//   print('dependencies: $dependencies');
//   buildOutput.dependencies.dependencies.addAll(dependencies);
//
//   await buildOutput.writeToFile(outDir: buildConfig.outDir);
// }

class Frb {
  static Future<void> verifyInit() async {
    try {
      if (!BdkCore.instance.initialized) {
        await BdkCore.init();
      }
    } catch (e) {
      print(Directory.current);
      debugPrint(e.toString());
      throw Exception("Failed to initialize bdk-flutter");
    }
  }
}
