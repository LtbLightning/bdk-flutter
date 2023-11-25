# Setup
BUILD_DIR=unittest.bdk.0.29.3
LIBNAME=librust_bdk_ffi.dylib
MAC_LIPO=macos/$LIBNAME


mkdir -p $BUILD_DIR
cd $BUILD_DIR
mkdir -p macos

# Macos unittest binary
for TARGET in \
        x86_64-apple-darwin aarch64-apple-darwin
do
    rustup target add $TARGET
    cargo build -r --target=$TARGET
done


lipo -create -output $MAC_LIPO \
        ../target/aarch64-apple-darwin/release/$LIBNAME \
        ../target/x86_64-apple-darwin/release/$LIBNAME









