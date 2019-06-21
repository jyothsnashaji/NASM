section .text
 
global _start
_start:
 
mov dword[a],12345678
mov cl,byte[a]
 
cmp cl,5678
je little
 
 
cmp cl,1234
jne ext
 
mov ecx,big
mov edx,lbig
mov eax,4
mov ebx,1
int 80h
 
jmp ext
 
 
 
little:
 
mov ecx,lit
mov edx,llit
mov eax,4
mov ebx,1
int 80h
 
ext:
 
 
mov eax,1
mov ebx,0
int 80h
 
 
 
section .data
a dd 30h
big db "BIG ENDIAN "
lbig equ $-big
lit db "LITTLE ENDIAN"
llit equ $-lit
