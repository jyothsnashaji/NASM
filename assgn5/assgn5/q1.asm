section .text
global _start:
_start:

;counting number of distinct lowercase between uppercase
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

mov byte[up],0
mov byte[lw],0
mov byte[large],0

cld
mov esi,string
mov edi,string
movzx ecx,byte[n]



count:
lodsb

cmp al,65
jb skip
cmp al,90
jna upper
cmp al,97
jb skip
cmp al,122
jna lower
jmp skip

skip:
loop count

mov eax,4
mov ebx,1
mov ecx,msg2
mov edx,len2
int 80h

mov dx,word[large]
mov word[num],dx
call print_num
jmp exit





upper:

cmp byte[up],0
jne largest
inc byte[up]
jmp skip

largest:
mov bl,byte[lw]
mov dl,byte[large]
mov byte[lw],0
cmp bl,dl
jb skip
mov byte[large],bl
jmp skip

lower:

pusha
pushf
cmp byte[up],0
je skip

cld
mov esi,string2
mov edi,string2
movzx ecx,byte[lw]
inc ecx
search:
scasb
je found
loop search


inc byte[lw]
stosb


found:
popf
popa
jmp skip



prints:
pusha
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
popa
ret

print_num:
pusha
cmp word[num],0
je print0
mov byte[nod],0

extract_d:
cmp word[num],0
je print
inc byte[nod]
mov ax,word[num]
mov bx,10
mov dx,0
div bx
push dx
mov word[num],ax
jmp extract_d

print:
cmp byte[nod],0
je end_print
dec byte[nod]
pop dx
add dx,30h
mov word[d],dx

mov eax,4
mov ebx,1
mov ecx,d
mov edx,1
int 80h

jmp print

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


exit:
mov eax,1
mov ebx,0
int 80h


section .bss
string:resw 50
d:resb 1
n:resb 1
up:resw 1
lw:resw 1
num:resw 1
nod:resw 1
large:resw 1
string2:resw 50



section .data
tab:db " "
newline:db 0Ah
zero:db "0"
msg:db "Enter String: "
len:equ $-msg
msg2:db "Maximum distinct lowercase: "
len2:equ $-msg2
