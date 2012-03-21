section .bss

  digit1: resb 1
  digit2: resb 1
  digit3: resb 1
  digit4: resb 1
  temp: resb 1
  n: resb 1
  num1: resb 1
  num2: resb 1
  factorial: resw 1
   j: resb 1	

section .data

msg1: db "Enter the number : "
size1: equ $-msg1

msg3: db "FACTORIAL  : "
msgl3: equ $-msg3

newline: db 10
sizen: equ $-newline


section .text
  global _start

_start:
  


;Printing the message to enter the number
  mov eax, 4
  mov ebx, 1
  mov ecx, msg1
  mov edx, size1
  int 80h
  
  ;Reading the number
  mov eax, 3
  mov ebx, 0
  mov ecx, digit1
  mov edx, 1
  int 80h

  mov eax, 3
  mov ebx, 0
  mov ecx, digit2
  mov edx, 1
  int 80h

  mov eax, 3
  mov ebx, 0
  mov ecx, temp
  mov edx, 1
  int 80h

  sub byte[digit1], 30h
  sub byte[digit2], 30h  

  movzx ax, byte[digit1]
  mov bl, 10
  mul bl
  
  movzx bx, byte[digit2]
  add al,bl
  mov byte[n], al

;main program...
mov byte[j], 1
mov word[factorial], 1

jmp fact

print:

mov eax,4
mov ebx,1
mov ecx,newline
mov edx,sizen
int 80h


;printing..
mov eax,4
mov ebx,1
mov ecx,msg3
mov edx,msgl3
int 80h

 
  movzx eax, word[factorial]
  mov bl, 100
  div bl

;al will contain first two digits  
  mov byte[num1], al

;al will contain first two digits
  mov byte[num2], ah

;Splitting again
  movzx ax, byte[num1]
  mov bl, 10
  div bl
  mov byte[digit1], al
  mov byte[digit2], ah

;Splitting again
  movzx ax, byte[num2]
  mov bl, 10
  div bl
  mov byte[digit3], al
  mov byte[digit4], ah



  add byte[digit1], 30h
  add byte[digit2], 30h
  add byte[digit3], 30h
  add byte[digit4], 30h

  ;Printing the no digit by digit......

  mov eax, 4
  mov ebx, 1
  mov ecx, digit1
  mov edx, 1
  int 80h


  mov eax, 4
  mov ebx, 1
  mov ecx, digit2
  mov edx, 1
  int 80h

  mov eax, 4
  mov ebx, 1
  mov ecx, digit3
  mov edx, 1
  int 80h


  mov eax, 4
  mov ebx, 1
  mov ecx, digit4
  mov edx, 1
  int 80h
  




mov eax, 1
mov ebx, 0
int 80h

fact:
	movzx bx,byte[j]
	cmp bl,byte[n]
	ja wat
	movzx eax, word[factorial]
	movzx bx, byte[j]
	mul bx
	mov word[factorial], ax
	inc byte[j]
	jmp fact 
wat:
jmp print


