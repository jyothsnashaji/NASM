section .text
global _start:
_start:

;encrypting by adding one
mov eax,4
mov ebx,1
mov ecx,msg
mov edx,len1
int 80h

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
mov dl,byte[len]
en:
mov cl,byte[eax]
cmp cl,32
je check
cmp cl,'z'
je zcheck
cmp cl,'Z'
je zcheck
inc byte[eax]
check:
inc eax
dec byte[len]
cmp byte[len],0
jne en
mov eax,string
mov byte[len],dl
call print
jmp exit

zcheck:
cmp cl,'z'
je l1
mov cl,'A'
mov byte[eax],cl
jmp check
l1:
mov cl,'a'
mov byte[eax],cl
jmp check
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
msg:db "Enter string: "
len1:equ $-msg
