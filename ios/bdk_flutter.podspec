Pod::Spec.new do |s|
      s.name             = 'bdk_flutter'
      s.version          = "0.31.3"
      s.summary          = 'A Flutter library for the Bitcoin Development Kit (https://bitcoindevkit.org/)'
      s.description      = <<-DESC
A new Flutter plugin project.
                       DESC
      s.homepage         = 'https://github.com/LtbLightning/bdk-flutter'
      s.license          = { :file => '../LICENSE' }
      s.author           = { 'Bitcoin Zavior' => 'BitcoinZavior@GMail.Com' }
      s.source           = { :path => '.' }
      s.source_files = 'Classes/**/*'
      s.dependency 'Flutter'
      s.platform = :ios, '12.0'
      s.script_phase = {
        :name => 'Build Rust library',
        # First argument is relative path to the `rust` folder, second is name of rust library
        :script => 'sh "$PODS_TARGET_SRCROOT/../cargokit/build_pod.sh" ../rust bdk_flutter',
        :execution_position => :before_compile,
        :input_files => ['${BUILT_PRODUCTS_DIR}/cargokit_phony'],
        # Let XCode know that the static library referenced in -force_load below is
        # created by this build step.
        :output_files => ["${BUILT_PRODUCTS_DIR}/libbdk_flutter.a"],
      }
      s.pod_target_xcconfig = {
        'DEFINES_MODULE' => 'YES',
        # Flutter.framework does not contain a i386 slice.
        'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386',
        'OTHER_LDFLAGS' => '-force_load ${BUILT_PRODUCTS_DIR}/libbdk_flutter.a',
      }
end
