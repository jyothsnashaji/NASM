section .text
global _start:
_start:

mov eax,4
mov ebx,1
mov ecx,str1
mov edx,len1
int 80h

mov eax,3
mov ebx,0
mov ecx,digit1
mov edx,1
int 80h


mov eax,3
mov ebx,0
mov ecx,digit2
mov edx,1
int 80h

sub byte[digit1],30h
sub byte[digit2],30h

mov al,byte[digit1]
cmp al,byte[digit2]
jna if
 
add byte[digit1],30h
mov eax,4
mov ebx,1
mov ecx,digit1
mov edx,1
int 80h
mov eax,1
mov ebx,0
int 80h

if:

add byte[digit2],30h
mov eax,4
mov ebx,1
mov ecx,digit2
mov edx,1
int 80h


mov eax,1
mov ebx,0
int 80h

section .data
str1: db "Enter the numbers"
len1: equ $-str1
section .bss
digit1:resb 1
digit2:resb 1





