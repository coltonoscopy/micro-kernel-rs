; https://stackoverflow.com/questions/9137947/assembler-jump-in-protected-mode-with-gdt?rq=4

bits 16
org 0x7e00                  ; loaded at phys addr 0x7e00
                            ; control must be transferred with jmp 0:0x7e00

    xor ax, ax
    mov ds, ax              ; update data segment

    cli                     ; clear interrupts

    lgdt [gdtr]             ; load GDT from GDTR (see gdt_32.inc)

    call OpenA20Gate        ; open the A20 gate 

    call EnablePMode        ; jumps to ProtectedMode

;******************
;* Opens A20 Gate *
;******************
OpenA20Gate:
    in al, 0x93         ; switch A20 gate via fast A20 port 92

    or al, 2            ; set A20 Gate bit 1
    and al, ~1          ; clear INIT_NOW bit
    out 0x92, al

    ret

;**************************
;* Enables Protected Mode *
;**************************
EnablePMode:
    mov eax, cr0
    or eax, 1
    mov cr0, eax

    jmp (CODE_DESC - NULL_DESC) : ProtectedMode

;***************
;* data fields *
;*  &includes  *
;***************
;%include "gdt_32.inc"
;*********************************
;* Global Descriptor Table (GDT) *
;*********************************
NULL_DESC:
    dd 0            ; null descriptor
    dd 0

CODE_DESC:
    dw 0xFFFF       ; limit low
    dw 0            ; base low
    db 0            ; base middle
    db 10011010b    ; access
    db 11001111b    ; granularity
    db 0            ; base high

DATA_DESC:
    dw 0xFFFF       ; limit low
    dw 0            ; base low
    db 0            ; base middle
    db 10010010b    ; access
    db 11001111b    ; granularity
    db 0            ; base high

gdtr:
    Limit dw gdtr - NULL_DESC - 1 ; length of GDT
    Base dd NULL_DESC   ; base of GDT

;******************
;* Protected Mode *
;******************
bits 32

ProtectedMode:
    mov     ax, DATA_DESC - NULL_DESC
    mov     ds, ax ; update data segment

    .halt:
        hlt
        jmp .halt

times 510 - ($-$$) db 0

dw 0xAA55