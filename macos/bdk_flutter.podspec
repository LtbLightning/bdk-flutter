
read_key_value_pairs = lambda do |file_path|
  pairs = {}
  File.foreach(file_path) do |line|
    key, value = line.chomp.split('=')
    pairs[key] = value
  end
  pairs
end
podspec_dir = File.dirname(__FILE__)
assets_dir = File.join(podspec_dir, '..', 'assets')
config_file_path = File.join(assets_dir, 'release.config.txt')
config = read_key_value_pairs.call(config_file_path)

tag_version = "#{config['TAG_VERSION']}"
framework = 'rust_bdk_ffi.xcframework'
lib_name = "bdk.#{tag_version}"
url = "#{config['REPOSITORY_URL']}#{tag_version}/#{lib_name}.zip"
frameworks_dir = "macos"


`
cd ../
if [ ! -d #{lib_name} ]; then
    curl -L #{url} -o #{lib_name}.zip
    unzip #{lib_name}.zip
    rm -rf __MACOSX
    rm #{lib_name}.zip
fi

if [ ! -d #{frameworks_dir}/#{framework} ]; then
        cp -R #{lib_name}/#{framework} #{frameworks_dir}
fi
`

Pod::Spec.new do |s|
s.name             = 'bdk_flutter'
s.version          = "#{config['TAG_VERSION']}"
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