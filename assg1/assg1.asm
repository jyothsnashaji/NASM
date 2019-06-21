section .text
global _start:
_start:

mov word[t1],0
mov word[t2],1
add word[t1],30h
add word[t2],30h
mov eax,4
mov ebx,1
mov ecx,t1
mov edx,2
int 80h

mov eax,4
mov ebx,1
mov ecx,tab
mov edx,1
int 80h

mov eax,4
mov ebx,1
mov ecx,t2
mov edx,2
int 80h
mov eax,4
mov ebx,1
mov ecx,tab
mov edx,1
int 80h

sub word[t1],30h
sub word[t2],30h
mov byte[temp],2

l:

mov ax,word[t1]
add ax,word[t2]
mov bx,word[t2]
mov word[t1],bx
mov word[t2],ax
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
cmp byte[temp],5
jbe l

mov eax,1
mov ebx,0
int 80h

section .data
tab: db 9

section .bss
t1:resw 1
t2:resw 1
digit01:resb 1
digit02:resb 1
temp:resb 1

