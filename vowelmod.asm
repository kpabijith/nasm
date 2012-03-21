section .data

msg: db "enter the string"
size: equ $-msg
msgs: db " small count:  "
sizes: equ $-msgs
msgc: db " capital count:  "
sizec: equ $-msgc
msg1: db "ERROR"
size1: equ $-msg1
newline: db 10
sizen: equ $-newline

section .bss

string: resw 50
temp : resb 1
length: resb 1
i: resb 1
counts: resb 1
countc: resb 1


section .text

global _start

_start:

mov eax,4
mov ebx,1
mov ecx,msg
mov edx,size
int 80h

mov ebx,string
mov byte[length],0

accepting_string:

push ebx


mov eax,3
mov ebx,0
mov ecx,temp
mov edx,1
int 80h

pop ebx

mov al,byte[temp]
mov byte[ebx],al

inc byte[length]
inc ebx

cmp byte[temp],10
jne accepting_string

dec ebx
dec byte[length]
mov byte[ebx],0


mov byte[counts],0
mov byte[countc],0


mov byte[i],0



vowel_check:

mov eax,string
movzx ecx,byte[i]
add eax,ecx

cmp byte[eax],97
jl capital_check

cmp byte[eax],123
jl small_count
jmp error

capital_check:
cmp byte[eax],65
jl error

cmp byte[eax],92
jl capital_count

jmp error



continue:
inc byte[i]
mov al,byte[length]
cmp byte[i],al
jl vowel_check

add byte[counts],30h
add byte[countc],30h


call print

jmp exit

small_count:
add byte[counts],1
jmp continue

capital_count:
add byte[countc],1
jmp continue

error:
mov eax,4
mov ebx,1
mov ecx,msg1
mov edx,size1
int 80h
jmp exit

print:
mov eax,4
mov ebx,1
mov ecx,msgs
mov edx,sizes
int 80h

mov eax,4
mov ebx,1
mov ecx,counts
mov edx,1
int 80h

mov eax,4
mov ebx,1
mov ecx,newline
mov edx,sizen
int 80h

mov eax,4
mov ebx,1
mov ecx,msgc
mov edx,sizec
int 80h

mov eax,4
mov ebx,1
mov ecx,countc
mov edx,1
int 80h

mov eax,4
mov ebx,1
mov ecx,newline
mov edx,sizen
int 80h


ret


exit: 

mov eax,1
mov ebx,0
int 80h


