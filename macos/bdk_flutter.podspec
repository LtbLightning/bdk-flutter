release_tag = '0.29.3'
framework = 'rust_bdk_ffi.xcframework'
binary = "bdk_flutter_#{release_tag}"
url = "https://github.com/LtbLightning/test-pub/releases/download/#{release_tag}/#{binary}.zip"
frameworks_dir = "frameworks/#{release_tag}"

`
cd ../
if [ ! -d #{binary} ]; then
    curl -L #{url} -o #{binary}.zip
    unzip #{binary}.zip
    rm -rf __MACOSX
    rm #{binary}.zip
fi

if [ ! -d #{frameworks_dir} ]; then
        mkdir -p #{frameworks_dir}
        mv #{binary}/#{framework} #{frameworks_dir}
fi
`

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
s.source_files     = 'Classes/**/*'
s.platform = :osx, '10.11'
s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }
s.swift_version = '5.0'
s.ios.deployment_target = '11.0'
s.osx.deployment_target = '10.13'
s.vendored_frameworks = "rust_bdk_ffi.xcframework"
end