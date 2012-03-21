section .data
   ms db "hello world!!!!"
   ml equ $ - ms

section .text
   global _start

_start:
   mov eax, 4
   mov ebx, 1
   mov ecx, ms
   mov edx, ml
   int 80h

   mov eax, 1
   mov ebx, 0
   int 80h
