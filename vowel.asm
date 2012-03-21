section .data

msg: db "enter the string"
size: equ $-msg
msga: db "vowel a count:  "
sizea: equ $-msga
msge: db "vowel e count:  "
sizee: equ $-msge
msgi: db "vowel i count:  "
sizei: equ $-msgi
msgo: db "vowel o count:  "
sizeo: equ $-msgo
msgu: db "vowel u count:  "
sizeu: equ $-msgu
newline: db 10
sizen: equ $-newline

section .bss

string: resw 50
temp : resb 1
length: resb 1
i: resb 1
counta: resb 1
counte: resb 1
counti: resb 1
counto: resb 1
countu: resb 1

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


mov byte[counta],0
mov byte[counte],0
mov byte[counti],0
mov byte[counto],0
mov byte[countu],0

mov byte[i],0



vowel_check:

mov eax,string
movzx ecx,byte[i]
add eax,ecx

cmp byte[eax],97
je a_count

cmp byte[eax],101
je e_count

cmp byte[eax],105
je i_count

cmp byte[eax],111
je o_count

cmp byte[eax],117
je u_count

continue:
inc byte[i]
mov al,byte[length]
cmp byte[i],al
jl vowel_check

add byte[counta],30h
add byte[counte],30h
add byte[counti],30h
add byte[counto],30h
add byte[countu],30h

call print

jmp exit

a_count:
add byte[counta],1
jmp continue

e_count:
add byte[counte],1
jmp continue

i_count:
add byte[counti],1
jmp continue

o_count:
add byte[counto],1
jmp continue

u_count:
add byte[countu],1
jmp continue

print:
mov eax,4
mov ebx,1
mov ecx,msga
mov edx,sizea
int 80h

mov eax,4
mov ebx,1
mov ecx,counta
mov edx,1
int 80h

mov eax,4
mov ebx,1
mov ecx,newline
mov edx,sizen
int 80h

mov eax,4
mov ebx,1
mov ecx,msge
mov edx,sizee
int 80h

mov eax,4
mov ebx,1
mov ecx,counte
mov edx,1
int 80h

mov eax,4
mov ebx,1
mov ecx,newline
mov edx,sizen
int 80h

mov eax,4
mov ebx,1
mov ecx,msgi
mov edx,sizei
int 80h

mov eax,4
mov ebx,1
mov ecx,counti
mov edx,1
int 80h

mov eax,4
mov ebx,1
mov ecx,newline
mov edx,sizen
int 80h

mov eax,4
mov ebx,1
mov ecx,msgo
mov edx,sizeo
int 80h

mov eax,4
mov ebx,1
mov ecx,counto
mov edx,1
int 80h

mov eax,4
mov ebx,1
mov ecx,newline
mov edx,sizen
int 80h


mov eax,4
mov ebx,1
mov ecx,msgu
mov edx,sizeu
int 80h

mov eax,4
mov ebx,1
mov ecx,countu
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


