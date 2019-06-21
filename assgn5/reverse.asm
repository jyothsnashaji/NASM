section .text
global _start:
_start:

;reversing words in a string
mov eax,4
mov ebx,1
mov ecx,msg
mov edx,len
int 80h

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

std
mov esi,string
mov ebx,str2
movzx ecx,byte[n]
add esi,ecx
dec esi

mov byte[m],0

rev:

lodsb
cmp al,32
je printword
cmp al,9
je printword

mov byte[ebx],al
inc ebx
inc byte[m]
l:
loop rev

std
mov esi,str2
movzx ecx,byte[m]
add esi,ecx
dec esi
call prints
call printtab

jmp exit

printword:
pusha
pushf

std
mov esi,str2
movzx ecx,byte[m]
add esi,ecx
dec esi
call prints
call printtab

mov byte[m],0
popf
popa
mov ebx,str2
jmp l


jmp exit



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

endprint:
ret

printtab:
pusha
mov eax,4
mov ebx,1
mov ecx,tab
mov edx,1
int 80h
popa
ret

exit:
mov eax,1
mov ebx,0
int 80h


section .bss
string:resw 50
d:resb 1
n:resb 1
str2:resw 50
m:resw 1

section .text
tab:db " "
msg:db "Enter string: "
len:equ $-msg
