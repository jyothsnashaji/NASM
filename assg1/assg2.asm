section .data
global _start:
_start:

mov eax,3
mov ebx,0
mov ecx,n
mov edx,1
int 80h

sub byte[n],30h
mov word[sum],0

mov ecx,dword[n]
add:
add dword[sum],ecx
loop add
mov ax,word[sum]
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
n:resb 1
sum:resw 1
digit01: resb 1
digit02:resb 1

