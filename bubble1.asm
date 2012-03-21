section .data
	msg: db "enter n"
	size: equ $-msg
	msg1: db "enter the nos"
	size1: equ $-msg1
	newline: db 10
	sizen: equ $-newline

section .bss
	array: resb 50	
	n: resb 1
	i: resb 1
	j: resb 1
	num: resb 1
	dig1: resb 1
	dig2: resb 1
	dig3: resb 1
	dig4: resb 1
	temp: resb 1
	num1: resb 1
	num2: resb 1

section .text
	global _start
_start:

	mov eax,4
	mov ebx,1	
	mov ecx,msg
	mov edx,size
	int 80h

	call accepting
	mov byte[n],al

	
	mov eax,4
	mov ebx,1	
	mov ecx,msg1
	mov edx,size1
	int 80h

	movzx ecx,byte[n]

	mov esi,array
l1:
	push ecx	
	call accepting
	mov byte[num],al
	movzx eax,byte[num]
	mov byte[esi],al
	inc esi	
	pop ecx

	loop l1


	;movzx ecx, byte[num]

	mov ebx, array

	mov byte[i], 0

	i_loop:
	mov byte[j], 0
	j_loop:
	mov ebx, array
	movzx eax, byte[j]
	add ebx, eax
	mov eax, ebx
	add eax, 1
	mov dl, byte[ebx]
	mov dh, byte[eax]
	cmp dh, dl
	jl swap
	jmp no_swap

	swap:
	mov byte[ebx], dh
	mov byte[eax], dl

	no_swap:
	inc byte[j]
	mov al, byte[n]
	sub al, byte[i]
	sub al, 1
	cmp byte[j], al
	jl j_loop

	inc byte[i]
	mov al, byte[n]
	cmp byte[i], al
	jl i_loop

movzx ecx, byte[n]
mov esi,array
l4:
	push ecx
	movzx ax,byte[esi]
	call print
	inc esi
	pop ecx
	loop l4
	jmp exit

print:

	mov bl,10
	div bl
	mov byte[dig1],al
	mov byte[dig2],ah
	add byte[dig1],30h
	add byte[dig2],30h
	
	mov eax,4
	mov ebx,1
	mov ecx,dig1
	mov edx,1
	int 80h

	mov eax,4
	mov ebx,1
	mov ecx,dig2
	mov edx,1
	int 80h

	ret

accepting:

	mov eax,3
	mov ebx,0
	mov ecx,dig1
	mov edx,1
	int 80h

	mov eax,3
	mov ebx,0
	mov ecx,dig2
	mov edx,1
	int 80h

	mov eax,3
	mov ebx,0
	mov ecx,temp
	mov edx,1
	int 80h
	
	

	sub byte[dig1], 30h
	sub byte[dig2], 30h

	movzx ax,byte[dig1]
	mov bl,10
	mul bl

	add al,byte[dig2]
	

	ret


exit:
	mov eax,1
	mov ebx,0
	int 80h



