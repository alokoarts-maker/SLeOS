[org 0x7C00]
[bits 16]

start:

    mov si,msg
    call print

    ; load kernel into 1000:0000
    mov ax,0x1000
    mov es,ax
    xor bx,bx

    mov ah,0x02
    mov al,1
    mov ch,0
    mov cl,2
    mov dh,0
    int 0x13

    jmp 0x1000:0x0000

print:
    mov ah,0x0E

next:
    lodsb
    or al,al
    jz done

    int 0x10
    jmp next

done:
    ret

msg db "Loading SLeOS...",13,10,0

times 510-($-$$) db 0
dw 0xAA55