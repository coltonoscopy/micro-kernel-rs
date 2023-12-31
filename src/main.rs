#![no_std]
#![no_main]

use core::panic::PanicInfo;

#[no_mangle]
pub extern "C" fn kernel_main() -> ! {
  loop {}
}

#[panic_handler]
fn panic(_info: &PanicInfo) -> ! {
  loop {}
}

#[cfg(test)]
mod tests {
  #[test]
  fn trivial_assertion() {
    assert_eq!(1, 1);
  }
}
