section .text
global _start:
_start:

;dictionary order

cld
mov edi,string
mov byte[n],0
call read


cld
mov esi,string
mov edi,small
mov byte[num],0
mov byte[j],0


find:

lodsb
cmp ax,'*'
je n1

cmp ax,32
je checksmall

stosb
inc byte[num]

n1:
inc word[j]
;inc esi
;inc edi
mov ax,word[ns]
;mov bx,word[n]
;mul bx
cmp word[j],64

jb find

jmp exit


checksmall:
pusha
pushf
mov esi,small
movzx ecx,byte[num]
call print
call printl
popf
popa

pusha
mov edi,temp
mov bx,word[num]
mov word[k],bx
mov byte[m],0
extractword:
lodsb

cmp ax,'*'
je n3
cmp ax,32
je checksmaller

stosb
inc byte[m]

n3:
inc byte[k]
;inc esi
;inc edi
mov dl,byte[n]
cmp byte[k],dl

jb extractword
dec byte[m]
jmp checksmaller

n2:
cld
mov esi,small
movzx ecx,byte[num]
call print
call printl

pusha
pushf
mov esi,string
movzx ecx,byte[n]
call print
call printl
popf
popa

cld
mov esi,string
mov edi,temp
movzx ecx,byte[n]
mov byte[i],0
mov dl,byte[num]
mov byte[m],dl
call del




popa

mov edi,small
mov esi,string
mov word[num],0
jmp n1

n5:
movzx ecx,byte[num]
jmp smaller

checksmaller:

pusha
pushf
mov esi,small
movzx ecx,byte[num]
call print

popf
popa


pusha
pushf
mov esi,temp
movzx ecx,byte[m]
call print
call printl
popf
popa

pusha

mov esi,small
mov edi,temp
mov dl,byte[m]
cmp dl,byte[num]
ja n5
movzx ecx,byte[m]
smaller:
cmpsb
ja n4

jne q
loop smaller
q:
popa
mov edi,temp
mov byte[m],0
mov dl,byte[n]
cmp byte[k],dl
jb n3
jmp n2


n4:
cld
mov esi,temp
mov edi,small
movzx ecx,byte[m]

moving:
movsb
loop moving

mov dl,byte[m]
mov byte[num],dl
popa
mov edi,temp
mov byte[m],0
mov dl,byte[n]
cmp byte[k],dl
jb n3
jmp n2





exit:
mov eax,1
mov ebx,0
int 80h

del:

lodsb
cmp ax,'*'
je l1
cmp ax,32
je check

stosb
inc byte[i]
l1:
loop del

;dec byte[i]
jmp check

l3:

ret


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
push ecx
movzx ecx,byte[m]
inc ecx
change:
mov ax,'*'
stosb
loop change




pop ecx

jmp l3





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
k:resw 1
ns:resw 1
num:resw 1
nod:resw 1

section .data
newl:db 0Ah
zero:db "0"
