write_string:
    push bx
    push cx
    push dx
    mov bl,al; the color's now in bx
    call write_string_loop
    pop dx
    pop cx
    pop bx
    ret
write_string_loop:
    lodsb
    cmp al,0
    je write_string_done
    call write_char
    jmp write_string_loop
write_char:
    ;the character is in al
    cmp al,10
    je write_newline
    cmp al,33
    jb write_invalid_char
    mov cx,ScreenAddress
    mov dx,yPos
    mul dx,80
    add dx,xPos
    add cx,dx
    mov byte[cx],al
    inc cx
    mov byte[cx],bl
    inc xPox
    ret
write_newline:
    mov xPos,0
    inc yPos
    ;TODO- write code handling screen overflow
    jmp write_string_loop
write_invalid_char:
    lea ax,invalidCharMsg
    call write_string
    ret
write_string_done:
    ret
;=====================================
;Variable declarations
ScreenAddress db 0xb8000
xPos db 0
yPos db 0
invalidCharMsg db "Error- character cannot be displayed.",0
