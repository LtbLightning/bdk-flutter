#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint bdk_flutter.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'bdk_flutter'
  s.version          = '0.29.0'
  s.summary          = 'A Flutter library for the Bitcoin Development Kit (https://bitcoindevkit.org/)'
  s.description      = <<-DESC
A new Flutter project.
                       DESC
  s.homepage         = 'https://github.com/LtbLightning/bdk-flutter'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Bitcoin Zavior' => 'BitcoinZavior@GMail.Com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '12.0'
  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
  s.user_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
  s.swift_version = '5.0'
  s.public_header_files = 'Classes**/*.h'
  s.source_files = 'Classes/**/*'
  s.static_framework = true
  s.vendored_libraries = "librust_bdk_ffi.a"
end
