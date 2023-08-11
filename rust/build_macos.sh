cargo lipo --release --targets aarch64-apple-darwin

if [ -e "../macos/librust_bdk_ffi.dylib" ]; then rm ../macos/librust_bdk_ffi.dylib
        fi

cp target/aarch64-apple-darwin/release/librust_bdk_ffi.dylib ../macos