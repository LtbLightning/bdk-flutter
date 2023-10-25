#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run pod lib lint bdk_flutter.podspec to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'bdk_flutter'
  s.version          = '0.29.3'
  s.summary          = 'A Flutter library for the Bitcoin Development Kit (https://bitcoindevkit.org/)'
  s.description      = <<-DESC
A new Flutter project.
                       DESC
  s.homepage         = 'https://github.com/LtbLightning/bdk-flutter'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Bitcoin Zavior' => 'BitcoinZavior@GMail.Com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'


  s.ios.dependency 'Flutter'
  s.osx.dependency 'FlutterMacOS'

  # Flutter.framework does not contain a i386 slice.
  s.ios.pod_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }

  # s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
  # s.user_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }

  s.ios.deployment_target = '11.0'
  s.osx.deployment_target = '10.11'

  s.vendored_frameworks = "rust_bdk_ffi.xcframework"
end
