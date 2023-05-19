#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint bdk_flutter.podspec` to validate before publishing.
#
#

Pod::Spec.new do |s|
  s.name             = 'bdk_flutter'
  s.version          = '0.28.2'
  s.summary          = 'A Flutter library for the Bitcoin Development Kit (https://bitcoindevkit.org/)'
  s.description      = <<-DESC
A new Flutter project.
                       DESC
  s.homepage         = 'https://github.com/LtbLightning/bdk-flutter'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }

  s.source           = { :path => '.' }
  s.source_files     = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'FlutterMacOS'
  s.platform = :osx, '10.11'
  s.osx.deployment_target = '10.14'
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }
  s.swift_version = '5.0'
  s.static_framework = false
  s.vendored_libraries = "librust_bdk_ffi.dylib"
end
