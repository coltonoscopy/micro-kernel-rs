BITS 16
[org 0x7c00]
extern kernel_main
global _start

section .text
align 4

_start:

  ; set up the stack
  xor ax, ax         ; clear ax
  mov ds, ax         ; set data segment to 0
  mov ss, ax         ; set stack segment to 0
  mov sp, 0x7c00     ; set stack pointer to just below boot sector
  cli                ; disable interrupts

  ; set up a basic GDT
  lgdt [gdt_descriptor]

  in al, 0x92        ; read the current value of the keyboard controller

  ; enable A20
  or al, 2           ; set the A20 bit
  and al, ~1         ; clear the CPU reset bit
  out 0x92, al       ; write the new value back to the keyboard controller

  ; switch to protected mode
  mov eax, cr0
  or eax, 1           ; set protected mode bit
  mov cr0, eax

  jmp code_segment:init_pm ; far jump to the code segment, reloads CS register

[bits 32]
init_pm:
  ; now in 32-bit protected mode
  mov esp, 0x90000     ; set stack pointer to 0x90000

  mov ax, data_segment ; update segment registers
  mov ds, ax
  mov es, ax
  mov fs, ax
  mov gs, ax
  mov ss, ax

  ; Write "Hello, world!" to the screen
  mov edi, 0xb8000
  mov esi, hello_world
  call print_string

  .halt:
    hlt
    jmp .halt

print_string:
  .next_char:
    lodsb
    or al, al
    jz .done
    mov ah, 0x0f
    stosw
    jmp .next_char
  .done:
    ret

; Global Descriptor Table
gdt_start:
  dd 0x0            ; null descriptor
  dd 0x0
  ; code segment descriptor
code_desc:
  dw 0xffff         ; limit low
  dw 0x0            ; base low
  db 0x0            ; base middle
  db 10011010b      ; access
  db 11001111b      ; granularity
  db 0x0            ; base high
  ; data segment descriptor
data_desc:
  dw 0xffff         ; limit low (Same as code segment)
  dw 0x0            ; base low
  db 0x0            ; base middle
  db 10010010b      ; access
  db 11001111b      ; granularity
  db 0x0            ; base high
gdt_end:
gdt_descriptor:
  dw gdt_end - gdt_start - 1    ; size (minus 1)
  dd gdt_start                  ; address

code_segment equ code_desc - gdt_start
data_segment equ data_desc - gdt_start

hello_world db "Hello, world!", 0

; fill up to 510 bytes with 0s
times 510 - ($-$$) db 0

; boot signature
dw 0xaa55