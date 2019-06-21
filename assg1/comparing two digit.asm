section .text
global _start:
_start:

mov eax,3
mov ebx,0
mov ecx,digit1
mov edx,1
int 80h


mov eax,3
mov ebx,0
mov ecx,digit2
mov edx,2
int 80h

sub byte[digit1],30h
sub byte[digit2],30h

mov al,byte[digit1]
mov bl,10
mul bl
movzx bx,byte[digit2]
add ax,bx
mov word[num1],ax
;reading second num

mov eax,3
mov ebx,0
mov ecx,digit3
mov edx,1
int 80h 

mov eax,3
mov ebx,0
mov ecx,digit4
mov edx,1
int 80h

sub byte[digit3],30h
sub byte[digit4],30h

mov al,byte[digit3]
mov bl,10
mul bl
movzx bx,byte[digit4]
add ax,bx
mov word[num2],ax


cmp word[num1],ax
jna if
;printing num1
mov ax,word[num1]
mov dl,10
div dl
mov byte[digit01],ah
mov byte[digit02],al
add byte[digit01],30h
add byte[digit02],30h


mov eax,4
mov ebx,1
mov ecx,digit02
mov edx,1
int 80h

mov eax,4
mov ebx,1
mov ecx,digit01
mov edx,1
int 80h

mov eax,1
mov ebx,0
int 80h
 if:
mov ax,word[num2]
mov dl,10
div dl
mov byte[digit01],ah
mov byte[digit02],al
add byte[digit01],30h
add byte[digit02],30h


mov eax,4
mov ebx,1
mov ecx,digit02
mov edx,1
int 80h

mov eax,4
mov ebx,1
mov ecx,digit01
mov edx,1
int 80h

mov eax,1
mov ebx,0
int 80h
 
 

section .bss
digit1:resb 1
digit2:resb 1
digit3:resb 1
digit4:resb 1
digit01:resb 1
digit02:resb 1
num1:resw 1
num2:resw 1




