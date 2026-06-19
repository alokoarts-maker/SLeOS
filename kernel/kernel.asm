[bits 16]
[org 0x0000]

kernel_start:

    mov ax,0x1000
    mov ds,ax

    mov si,welcome
    call print

shell:
    mov si,prompt
    call print

wait_key:
    mov ah,0
    int 16h

    mov ah,0x0E
    int 10h

    cmp al,'h'
    je help

    cmp al,'p'
    je process

    cmp al,'m'
    je memory

    cmp al,'f'
    je files

    cmp al,'c'
    je fcfs

    cmp al,'r'
    je roundrobin

    cmp al,'x'
    je allocate

    cmp al,'z'
    je release

    cmp al,13
    je newline

    jmp wait_key

help:
    mov si,helpmsg
    call print
    jmp newline

process:
    mov si,processmsg
    call print
    jmp newline

memory:
    mov si,memorymsg
    call print
    jmp newline

files:
    mov si,filesmsg
    call print
    jmp newline

fcfs:
    mov si,fcfsmsg
    call print
    jmp newline

roundrobin:
    mov si,rrmsg
    call print
    jmp newline

allocate:
    mov si,allocmsg
    call print
    jmp newline

release:
    mov si,freemsg
    call print
    jmp newline

newline:
    mov al,13
    mov ah,0x0E
    int 10h

    mov al,10
    int 10h

    jmp shell

print:
    mov ah,0x0E

next:
    lodsb
    or al,al
    jz done

    int 10h
    jmp next

done:
    ret

welcome db "SLeOS Kernel Started",13,10,0
prompt db "SLeOS> ",0

helpmsg db 13,10
         db "h-help",13,10
         db "p-process",13,10
         db "m-memory",13,10
         db "f-files",13,10
         db "c-FCFS",13,10
         db "r-RoundRobin",13,10
         db "x-Allocate",13,10
         db "z-Free",13,10,0

processmsg db 13,10
           db "Process Manager",13,10,0

memorymsg db 13,10
          db "Memory:768KB Free",13,10,0

filesmsg db 13,10
         db "notes.txt",13,10
         db "users.txt",13,10
         db "system.cfg",13,10,0

fcfsmsg db 13,10
         db "FCFS Scheduler",13,10
         db "P1 Running",13,10
         db "P2 Waiting",13,10
         db "P3 Waiting",13,10,0

rrmsg db 13,10
      db "Round Robin",13,10
      db "P1 Running",13,10
      db "P2 Running",13,10
      db "P3 Running",13,10,0

allocmsg db 13,10
          db "Memory Allocated:256KB",13,10,0

freemsg db 13,10
         db "Memory Released",13,10,0