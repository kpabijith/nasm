section .data
    m1    db    "enter the no. of elements:"
    m1l   equ   $ - m1
    m2    db    "enter the element:"
    m2l   equ   $ - m2
    m3    db    "sum  is:"
    m3l   equ   $ - m3

section .bss
    n    resb    2
    e    resb    2
    sum  resb    2

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

    mov    ebx,    29h
    push   bx

    for1:
        mov    eax,    0
        mov    ax,    word [n]
        cmp    eax,    0
        je     exit1
        mov    eax,    4
        mov    ebx,    1
        mov    ecx,    m2
        mov    edx,    m2l
        int    80h

        mov    eax,    3
        mov    ebx,    0
        mov    ecx,    e
        mov    edx,    3
        int    80h

        mov    ebx,    10
        mov    ecx,    0
        mov    cx,    word [e]
        sub    cl,     48
        sub    ch,     48
        mov    eax,    0
        mov    al,     cl
        mul    bx
        shr    ecx,    8
        add    eax,    ecx
        mov    ebx,    eax
        push   bx
        mov    eax,    0
        mov    ax,    word [n]
        dec    eax
        mov    word [n], ax
        jmp    for1
    exit1:

    mov    ebx,    0
    mov    word [sum],bx

    for2:
        mov    ebx,    0
        pop    bx
        cmp    ebx,     29h
        je     exit2
        mov    eax,    0
        mov    ax,    word [sum]
        add    eax,    ebx
        mov    word [sum], ax
        jmp    for2
    exit2:

    mov    eax,    0
    mov    ax,    word [sum]
    mov    ebx,    29h
    push   bx

    for3:
        mov    edx,    0
        mov    ebx,    10
        div    bx
        cmp    ax,     0
        je     exitt
        add    dx,     48
        mov    ebx,    edx
        push   bx
        jmp    for3
    exitt:
        cmp    dx,     0
        je     exit3
        mov    ebx,    0
        mov    ebx,    edx
        add    ebx,    48
        push    bx
    exit3:

    mov    eax,    4
    mov    ebx,    1
    mov    ecx,    m3
    mov    edx,    m3l
    int    80h

    for4:
       mov    ebx,   0
       pop    bx
       cmp    bx,    29h
       je     exit4
       
       mov    word [n],bx

       mov    eax,    4
       mov    ebx,    1
       mov    ecx,    n
       mov    edx,    2
       int    80h
       jmp    for4
    exit4:

    mov    eax,    1
    mov    ebx,    0
    int    80h
