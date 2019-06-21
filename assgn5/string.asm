section .text
global _start:
_start:

;reading and printing a string using lodsb and stosb
mov edi,string
mov byte[n],0
cld
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
mov al,byte[d]
stosb
inc byte[n]
jmp read
end_read:

cld
mov esi,string
movzx ecx,byte[n]
prints:

lodsb
mov byte[d],al
pusha
mov eax,4
mov ebx,1
mov ecx,d
mov edx,1
int 80h
popa
loop prints

end_print:
ret
exit:
mov eax,1
mov ebx,0
int 80h


section .bss
string:resw 50
d:resb 1
n:resb 1

