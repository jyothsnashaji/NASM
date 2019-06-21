section .text
global _start:
_start:

;reading and printing a string

;reading string

mov eax,string
mov byte[len],0
read:
pusha
mov eax,3
mov ebx,0
mov ecx,d
mov edx,1
int 80h
popa

cmp byte[d],10
je end_read

mov dl,byte[d]
mov byte[eax],dl
inc eax
inc byte[len]
jmp read

end_read:
mov byte[eax],0

mov eax,string
call print
jmp exit





;printing string

print:
cmp byte[len],0
je end_print

mov dl,byte[eax]
mov byte[d],dl

pusha
mov eax,4
mov ebx,1
mov ecx,d
mov edx,1
int 80h
popa

inc eax
dec byte[len]
jmp print

end_print:
ret


exit:
mov eax,1
mov ebx,0
int 80h

section .bss
d:resw 1
string:resw 50
len:resw 1

section .data
tab:db " "
newline:db 0Ah

