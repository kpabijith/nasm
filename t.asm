section .data
    m1    db    "enter the string:"
    m1l   equ   $ - m1
    m2    db    "the reversed string is "
    m2l   equ   $ - m2

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

    mov    esi,    a
    mov    edi,    a

    mov    al,    byte [esi]
    mov    byte [temp],    al
    mov    al,    byte [edi]
    mov    byte [l1],    al

    mov    eax,    4
    mov    ebx,    1
    mov    ecx,    temp
    mov    edx,    1
    int    80h

    mov    eax,    4
    mov    ebx,    1
    mov    ecx,    l1
    mov    edx,    1
    int    80h

    mov    eax,    1
    mov    ebx,    0
    int    80h
