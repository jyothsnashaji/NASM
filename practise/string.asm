section .text
global _start:
_start:

;number of substrings with same first and last characters

cld
mov edi,string
mov byte[n],0
read:


mov eax,3
mov ebx,0
mov ecx,d
mov edx,1
int 80h

cmp byte[d],10
je end_read


inc byte[n]
movzx ax,byte[d]
stosb

jmp read

end_read:

cld
mov esi,string
movzx ecx,byte[n]

mov word[num],0
mov byte[i],0

main:
mov dl,byte[n]
mov byte[j],dl


sub:


mov dl,byte[i]
inc dl
cmp byte[j],dl
jna maincheck




pusha
pushf
cld
mov bl,byte[j]
sub bl,byte[i]
mov byte[m],bl
mov edi,str
movzx ecx,byte[m]


move:
movsb

loop move

popf
popa
dec byte[j]
jmp check

maincheck:
inc byte[i]
inc esi
loop main


call print_num


exit:
mov eax,1
mov ebx,0
int 80h


check:
pusha
pushf
cld
mov esi,str
movzx ecx,byte[m]
call print
call printl

mov esi,str
mov edi,str
movzx edx,byte[m]
add edi,edx
dec edi
cmpsb
jne skip
inc word[num]

skip:
popf
popa

jmp sub

print:
pusha
pushf
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
popf
popa
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

print_num:
pusha
cmp word[num],0
je print0
mov byte[nod],0

extract_num:
cmp word[num],0
je printnum

mov dx,0
inc byte[nod]
mov ax,word[num]
mov bx,10
div bx
push dx
mov word[num],ax

jmp extract_num

printnum:
cmp byte[nod],0
je end_print
dec byte[nod]
pop dx
mov word[d],dx
add word[d],30h
pusha
mov eax,4
mov ebx,1
mov ecx,d
mov edx,1
int 80h
popa

jmp printnum

end_print:
popa
ret

print0:
mov eax,4
mov ebx,1
mov ecx,zero
mov edx,1
int 80h
jmp end_print

section .bss
d:resw 1
n:resw 1
string:resw 100
str:resw 100
m:resw 1
i:resw 1
j:resw 1
num:resw 1
nod:resw 1

section .data
newl:db 0Ah
zero:db "0"
