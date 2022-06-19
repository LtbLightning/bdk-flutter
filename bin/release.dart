#! /usr/bin/env dcli

import 'dart:io';

import 'package:dcli/dcli.dart';
import 'package:yaml/yaml.dart';

void main() {
  // Display output to console
  print('''# ------------------------------
# 🚀 Release new version
# ------------------------------''');

  // Ask for user input
  final newVersion = ask(
    'Enter new version number:',
    validator: Ask.regExp(
      r'^\d+\.\d+\.\d+$',
      error: 'You must pass a valid semver version in the form X.Y.Z',
    ),
  );

  try {
    // Read a file
    final pubspec = File('./pubspec.yaml').readAsStringSync();

    // Parse yaml content to retrieve current version number
    final currentVersion = loadYaml(pubspec)['version'];

    print('# Updating from version $currentVersion to version $newVersion...');

    // Write to a file
    'pubspec.yaml'.write(pubspec.replaceFirst(
      'version: $currentVersion',
      'version: $newVersion',
    ));

    print('# ✅ Pubspec updated to version $newVersion');
  } catch (e) {
    // Print or treat error as needed
    printerr('# ❌ Failed to update pubspec to version $newVersion\nError: $e');
  }
}
