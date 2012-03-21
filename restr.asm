section .data
    m1    db    "enter the string:"
    m1l   equ   $ - m1
    m2    db    "the reversed string is "
    m2l   equ   $ - m2
    m3    db    "hello",10
    m3l   equ   $ - m3

section .bss
    a     resb    50
    temp  resb    1
    len   resb    1
    fnt   resb    1
    l1    resb    1

section .text
    global _start

_start:
    mov    eax,    4
    mov    ebx,    1
    mov    ecx,    m1
    mov    edx,    m1l
    int    80h

    mov    esi,    a
    mov    byte [len],    0

    estr:
        mov    eax,    3
        mov    ebx,    0
        mov    ecx,    temp
        mov    edx,    1
        int    80h

        mov    al,     byte [temp]
        cmp    al,     10
        je     exit1
        mov    byte [esi],    al
        inc    esi
        inc    byte [len]
        jmp    estr
    exit1:

    mov    al,     byte [len]
    mov    byte [l1],    al
    mov    eax,    a
    mov    ebx,    a
    mov    byte [fnt],    0
    dec    byte [len]

    revrs:
        mov    cl,    byte [fnt]
        mov    ch,    byte [len]
        cmp    ch,    cl
        jl     exit2
        mov    eax,    a
        mov    ebx,    a
        movzx  ecx,    byte [fnt]
        add    eax,    ecx
        movzx  ecx,    byte [len]
        add    ebx,    ecx
        mov  cl,     byte [ebx]
        mov  dl,     byte [eax]
        mov  byte [ebx],  dl
        mov  byte [eax],  cl
        inc    byte [fnt]
        dec    byte [len]
        jmp    revrs
    exit2:

    mov    esi,    a
    movzx  eax,     byte [l1]
    push   eax

    mov    eax,    4
    mov    ebx,    1
    mov    ecx,    m2
    mov    edx,    m2l
    int    80h

    ostr:
        movzx  eax,    byte [l1]
        cmp    eax,     0
        je     exit3
        dec    byte [l1]
        mov    al,    byte [esi]
        mov    byte [temp],    al

        mov    eax,    4
        mov    ebx,    1
        mov    ecx,    temp
        mov    edx,    1
        int    80h

        inc    esi
        jmp    ostr
    exit3:

    mov    eax,    1
    mov    ebx,    0
    int    80h
