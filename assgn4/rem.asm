section .text
global _start:
_start:

;removing A and I from string
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
mov dl,byte[len]

mov eax,string
mov ebx,string2
rem:
mov cl,byte[eax]
cmp cl,'A'
je check
cmp cl,'I'
je check
mov byte[ebx],cl
check:
inc eax
inc ebx
dec byte[len]
cmp byte[len],0
jne rem

mov eax,string2
mov byte[len],dl


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



exit:
mov eax,1
mov ebx,0
int 80h

check1:
dec dl
jmp check

section .bss
d:resw 1
string:resw 50
len:resw 1
string2:resw 50


section .data
tab:db " "
newline:db 0Ah
msg: db "Enter string: "
len1:equ $-msg
