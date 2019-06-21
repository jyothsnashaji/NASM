section .text
global _start:
_start:



mov eax,3
mov ebx,0
mov ecx,digit1
mov edx,1
int 80h

sub word[digit1],30h
mov byte[temp],1
mov ecx,10

cal:
mov ax,word[digit1]
mov bl,byte[temp]
mul bl
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

mov eax,4
mov ebx,1
mov ecx,tab
mov edx,1
int 80h

add byte[temp],1
cmp byte[temp],10
 jna cal



mov eax,1
mov edx,0
int 80h

section .data
tab: db 9
section .bss
digit1: resw 1
digit01:resb 1
digit02:resb 1
temp:resb 1
