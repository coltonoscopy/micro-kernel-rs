global start
extern kernel_main

section .text
bits 64

start:
  call kernel_main
  hlt