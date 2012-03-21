section .data
    m1    db    "enter no. of elements:"
    m1l   equ   $ - m1
    m2    db    "enter elemenet:"
    m2l   equ   $ - m2l

section .bss
    array    resb    50
    n        resb    2
    ;temp     resb    2
    nt       resb    2
    nt1      resb    2
    nt2      resb    2

section .text
    global _start

_start:
    mov    eax,    4
    mov    ebx,    1
    mov    ecx,    m1
    mov    edx,    m1l
    int    80h

    mov    eax,    3
    mov    ebx,    0
    mov    ecx,    n
    mov    edx,    3
    int    80h

    mov    ecx,    0
    mov    ecx,    word [n]
    call   convrt
    mov    word [n], ax
    mov    word [nt], ax
    mov    word [nt1], ax
    mov    word [nt2], ax

    mov    esi,    array

    for1:
        mov    eax,    0
        mov    ax,     word [n]
        cmp    ax,     0
        jmp    exit1
        mov    eax,    4
        mov    ebx,    1
        mov    ecx,    m2
        mov    edx,    m2l
        int    80h

        mov    eax,    3
        mov    ebx,    0
        mov    ecx,    t
        mov    edx,    3
        int    80h

        mov    ecx,    0
        mov    ecx,    word [t]
        call   convrt
        mov    [esi],  eax
        inc    esi
        mov    eax,    0
        mov    ax,     word [n]
        dec    eax
        mov    word [n], ax
        jmp    for1
    exit1:

    mov     esi,    array

    for3:
        mov    eax,    0
        mov    ax,     word [nt1]
        cmp    ax,     1
        jmp    exit3

    for2:
        mov    eax,    0
        mov    ax,     word [nt]
        cmp    ax,     1
        je     exit2:
        mov    eax,    [esi]
        inc    esi
        mov    ebx,    [esi]
        cmp    eax,    ebx
        mov    eax,    0
        mov    ax,     word [nt]
        dec    eax
        mov    word [nt], ax
        jg     swap
    swap:
        mov    esi,    eax
        dec    esi
        mov    esi,    ebx
        inc    esi
        jmp    for2
    exit2:

        mov    eax,    0
        mov    ax,     word [nt1]
        dec    eax
        mov    word [nt1], ax
        jmp    for3
    exit3:

    mov    esi,    array

    for4:
        ;mov    eax,    0
        ;mov    ax,     word [nt2]
        cmp    [esi],     word [nt2]
        jl     exit4
        mov    eax,    [esi]
        mov    word [n],    ax
        mov    eax,    4
        mov    ebx,    1
        mov    ecx,    n
        mov    edx,    1
        int    80h
        inc    esi
        jmp    for4
    exit4:

    convrt:
        sub    cl,     48
        sub    ch,     48
        mov    eax,    0
        movzx  al,     cl
        mov    ebx,    10
        mul    bx
        shr    ecx,    8
        add    eax,    ecx
        ret
