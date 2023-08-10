cargo lipo --release --targets aarch64-apple-darwin

rm ../macos/librust_bdk_ffi.dylib

cp target/aarch64-apple-darwin/release/librust_bdk_ffi.dylib ../macos