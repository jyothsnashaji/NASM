section .text
global _start:
_start:

;deleting word in a string

cld
mov edi,string
mov byte[n],0
call read
mov dx,word[n]
push dx

cld 
mov edi,small
mov byte[n],0
call read
mov dx,word[n]
mov word[m],dx
pop dx
mov word[n],dx

cld
mov esi,string
mov edi,temp
movzx ecx,byte[n]
mov byte[i],0
del:

lodsb
cmp ax,32
je check

stosb
inc byte[i]
l1:
loop del
jmp check

l3:
cld
mov esi,string
movzx ecx,byte[n]
call print

jmp exit

l2:
popa
mov byte[i],0
mov edi,temp
cmp ecx,0
je l3
jmp l1

check:



pusha
mov dl,byte[m]
cmp dl,byte[i]
jne l2
cld
mov esi,small
mov edi,temp
movzx ecx,byte[m]
compare:
cmpsb
jne l2
loop compare
popa
cld
mov edi,esi
movzx edx,byte[m]
sub edi,edx
dec edi

change:
movsb
loop change

mov dl,byte[m]
sub byte[n],dl

jmp l3

 





exit:
mov eax,1
mov ebx,0
int 80h






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
ret

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
small:resw 100
temp:resw 100
m:resw 1
i:resw 1
j:resw 1
num:resw 1
nod:resw 1

section .data
newl:db 0Ah
zero:db "0"
