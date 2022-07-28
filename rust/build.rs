use lib_flutter_rust_bridge_codegen::{
    config_parse, frb_codegen, get_symbols_if_no_duplicates, RawOpts,
};
use std::env;

/// Path of input Rust code
const RUST_INPUT: &str = "src/api.rs";
/// Path of output generated Dart code
const DART_OUTPUT: &str = "../lib/src/generated/bindings.dart";

fn main() {
    // Tell Cargo that if the input Rust code changes, to rerun this build script.
    println!("cargo:rerun-if-changed={}", RUST_INPUT);
    env::set_var("RUST_BACKTRACE", "full");
    // Options for frb_codegen
    let raw_opts = RawOpts {
        // Path of input Rust code
        rust_input: vec![RUST_INPUT.to_string()],
        // Path of output generated Dart code
        dart_output: vec![DART_OUTPUT.to_string()],
        // for other options use defaults
        dart_decl_output: None,
        c_output: None,
        rust_crate_dir: None,
        rust_output: None,
        class_name: None,
        dart_format_line_length: None,
        skip_add_mod_to_lib: false,
        llvm_path: None,
        llvm_compiler_opts: None,
        dart_root: None,
        no_build_runner: true,
        verbose: true,
    };
    // get opts from raw opts
    let configs = config_parse(raw_opts);

    // generation of rust api for ffi
    let all_symbols = get_symbols_if_no_duplicates(&configs).unwrap();
    for config in configs.iter() {
        frb_codegen(config, &all_symbols).unwrap();
    }
}
