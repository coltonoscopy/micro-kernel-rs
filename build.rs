use std::process::Command;
use std::env;
use std::path::Path;

fn main() {
  println!("cargo:rerun-if-changed=src/boot.asm");

  let out_dir = env::var("OUT_DIR").unwrap();

  let status = Command::new("nasm")
    .args(&["-f", "elf32", "-o"])
    .arg(&format!("{}/boot.o", out_dir))
    .arg("src/boot.asm")
    .status()
    .expect("failed to execute nasm");

  assert!(status.success());
}