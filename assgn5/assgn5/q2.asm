section .text
global _start:
_start:

;finding palindrome substring

mov eax,4
mov ebx,1
mov ecx,msg1
mov edx,len1
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

cld
mov esi,string
mov edi,str2
movzx ecx,byte[n]
mov byte[j],cl
mov byte[i],0

main:

sub:

mov dl,byte[j]
dec dl
cmp dl,byte[i]
jna maincheck


pusha
movzx ecx,byte[j]
move:
movsb
loop move
popa




jmp check

skip:
cld
mov edi,str2
mov esi,string
movzx ebx,byte[i]
add esi,ebx
dec byte[j]
jmp sub

maincheck:
inc byte[i]
mov dl,byte[n]
mov byte[j],dl
mov esi,string
movzx ebx,byte[i]
add esi,ebx
loop main

mov eax,4
mov ebx,1
mov ecx,no
mov edx,len
int 80h



jmp exit

check:

pusha
pushf
mov bl,byte[j]
sub bl,byte[i]
mov byte[m],bl

cld
mov ebx,str2
mov esi,str2
movzx ecx,byte[m]
add ebx,ecx
dec ebx

checkp:
lodsb
cmp al,byte[ebx]
jne skip
dec ebx
loop checkp


pusha
mov eax,4
mov ebx,1
mov ecx,yes
mov edx,len2
int 80h
popa





cld
mov esi,str2
movzx ecx,byte[m]
call prints
call printl
popf
popa

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

end_print:
ret

printl:
pusha
mov eax,4
mov ebx,1
mov ecx,newl
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
str2:resw 50
d:resb 1
n:resb 1
m:resw 1
i:resw 1
j:resw 1

section .text
newl:db 0Ah
no:db "No palindrome substring",0Ah
len:equ $-no
yes:db "Yes",0Ah
len2:equ $-yes
msg1:db "Enter string: "
len1:equ $-msg1
