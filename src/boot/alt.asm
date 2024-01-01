; https://en.wikibooks.org/wiki/X86_Assembly/Bootloaders

         org 7C00h
 
         jmp short Start ;Jump over the data (the 'short' keyword makes the jmp instruction smaller)
 
 Msg:    db "Hello World! "
 EndMsg:
 
 Start:  mov bx, 000Fh   ;Page 0, colour attribute 15 (white) for the int 10 calls below
         mov cx, 1       ;We will want to write 1 character
         xor dx, dx      ;Start at top left corner
         mov ds, dx      ;Ensure ds = 0 (to let us load the message)
         cld             ;Ensure direction flag is cleared (for LODSB)
 
 Print:  mov si, Msg     ;Loads the address of the first byte of the message, 7C02h in this case
 
                         ;PC BIOS Interrupt 10 Subfunction 2 - Set cursor position
                         ;AH = 2
 Char:   mov ah, 2       ;BH = page, DH = row, DL = column
         int 10h
         lodsb           ;Load a byte of the message into AL.
                         ;Remember that DS is 0 and SI holds the
                         ;offset of one of the bytes of the message.
 
                         ;PC BIOS Interrupt 10 Subfunction 9 - Write character and colour
                         ;AH = 9
         mov ah, 9       ;BH = page, AL = character, BL = attribute, CX = character count
         int 10h
 
         inc dl          ;Advance cursor
 
         cmp dl, 80      ;Wrap around edge of screen if necessary
         jne Skip
         xor dl, dl
         inc dh
 
         cmp dh, 25      ;Wrap around bottom of screen if necessary
         jne Skip
         xor dh, dh
 
 Skip:   cmp si, EndMsg  ;If we're not at end of message,
         jne Char        ;continue loading characters
         jmp Print       ;otherwise restart from the beginning of the message
 
 
 times 0200h - 2 - ($ - $$)  db 0    ;Zerofill up to 510 bytes
 
         dw 0AA55h       ;Boot Sector signature