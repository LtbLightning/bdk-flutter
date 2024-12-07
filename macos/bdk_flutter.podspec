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
        s.source_files     = 'Classes/**/*'
        s.platform = :osx, '10.11'
        s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }
        s.swift_version = '5.0'
        s.dependency 'FlutterMacOS'
        s.osx.deployment_target = '14.0'
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
                'OTHER_LDFLAGS' => '-force_load ${BUILT_PRODUCTS_DIR}/libbdk_flutter.a',
                'DEAD_CODE_STRIPPING' => 'YES',
                'STRIP_INSTALLED_PRODUCT[config=Release][sdk=*][arch=*]' => "YES",
                'STRIP_STYLE[config=Release][sdk=*][arch=*]' => "non-global",
                'DEPLOYMENT_POSTPROCESSING[config=Release][sdk=*][arch=*]' => "YES",
              }
end
