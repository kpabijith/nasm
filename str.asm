section .data
    m1    db    "enter the string:"
    m1l   equ   $ - m1
    m2    db    "the string is a palindrome" , 10
    m2l   equ   $ - m2
    m3    db    "the string is not a palindrome" , 10
    m3l   equ   $ - m3
    m4    db    "hello......" , 10
    m4l   equ   $ - m4

section .bss
    a    resb    50
    len  resb    1
    fnt  resb    1
    temp resb    1

section .text
    global _start

_start:
    mov    eax,    4
    mov    ebx,    1
    mov    ecx,    m1
    mov    edx,    m1l
    int    80h

    mov    esi,    a
    mov    word [len],    0
    mov    word [fnt],    0

    estr:
        mov    eax,    3
        mov    ebx,    0
        mov    ecx,    temp
        mov    edx,    1 
        int    80h
        cmp    byte [temp],    10
        je     exit1
        movzx  eax,    byte [temp]
        mov    [esi],    eax
        inc    esi
        inc    byte [len]
        jmp    estr
    exit1:


    mov    esi,    a
    dec    byte [len]

    strcmp:
       mov    eax,   a
       mov    ebx,   a
       movzx    ecx,   byte [fnt]
       add    eax,   ecx
       movzx  edx,   byte [len]
       add    ebx,   edx
       cmp    edx,   ecx
       jl     pal
       mov    cl,    byte [eax]
       mov    ch,    byte [ebx]
       cmp    cl,    ch
       jne    ntpal
       inc    byte [fnt]
       dec    byte [len]
       jmp    strcmp
       
    pal:
        mov    eax,    4
        mov    ebx,    1
        mov    ecx,    m2
        mov    edx,    m2l
        int    80h
        jmp    exit2

    ntpal:
        mov    eax,    4
        mov    ebx,    1
        mov    ecx,    m3
        mov    edx,    m3l
        int    80h

    exit2:
        mov    eax,    1
        mov    ebx,    0
        int    80h
