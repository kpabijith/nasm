section .data
    m1    db    "enter th no.:"
    m1l   equ   $ - m1
    m2    db    "the factorial is "
    m2l   equ   $ - m2

section .bss
    n    resb    2
    f    resb    4

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
    mov    cx,    word [n]
    sub    cl,     48
    sub    ch,     48
    mov    eax,    0
    mov    al,     cl
    mov    ebx,    10
    mul    bl
    shr    ecx,    8
    add    eax,    ecx
    mov    word [n],   ax

    mov    eax,    1
    mov    dword [f],    eax

    for1:
        mov    eax,    0
        mov    ax,    word [n]
        cmp    ax,     1
        je     exit1
        mov    ebx,    0
        mov    ebx,    dword [f]
        mul    ebx
        push   eax
        mov    ebx,    10
        mov    eax,    edx
        mul    ebx
        mov    edx,    0
        pop    edx
        add    eax,    edx
        mov    dword [f],    eax
        mov    eax,    0
        mov    ax,    word [n]
        dec    eax
        mov    word [n], ax
        jmp    for1
    exit1:
    
    mov    eax,    0
    mov    eax,    dword [f]
    mov    ebx,    29h
    push   ebx

    for3:
        mov    edx,    0
        mov    ebx,    10
        div    ebx
        cmp    eax,     0
        je     exitt
        add    edx,     48
        mov    ebx,    edx
        push   ebx
        jmp    for3
    exitt:
        cmp    edx,     0
        je     exit3
        mov    ebx,    0
        mov    ebx,    edx
        add    ebx,    48
        push    ebx
    exit3:

    mov    eax,    4
    mov    ebx,    1
    mov    ecx,    m2
    mov    edx,    m2l
    int    80h

    for4:
       mov    ebx,   0
       pop    ebx
       cmp    ebx,    29h
       je     exit4
       
       mov    word [f],bx

       mov    eax,    4
       mov    ebx,    1
       mov    ecx,    f
       mov    edx,    2
       int    80h
       jmp    for4
    exit4:

    mov     eax,    1
    mov     ebx,    0
    int     80h
