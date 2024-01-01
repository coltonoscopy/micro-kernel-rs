BITS 16
global _start

section .text
align 4

_start:
  cli                ; disable interrupts
  mov ax, ax         ; set up a stack
  mov ss, ax
  mov sp, 0x7c00
  hlt                ; halt the CPU

; fill up to 510 bytes with 0s
times 510 - ($-$$) db 0

; boot signature
dw 0xaa55