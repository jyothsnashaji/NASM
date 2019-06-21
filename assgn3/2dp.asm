section .text
global _start:
_start:

mov eax,4
mov ebx,1
mov ecx,msg1
mov edx,len1
int 80h

;read m
call read_num
mov dx,word[num]
mov word[m],dx

mov eax,4
mov ebx,1
mov ecx,msg2
mov edx,len2
int 80h


;read n
call read_num
mov dx,word[num]
mov word[n],dx

mov eax,4
mov ebx,1
mov ecx,msg3
mov edx,len3
int 80h
;read elements
mov eax,0
mov ebx,a
mov word[i],0
mov word[j],0

iloop:
mov word[j],0

jloop:
call read_num
mov dx,word[num]
mov word[ebx+eax*2],dx

inc eax
inc word[j]
mov dx,word[j]
cmp dx,word[n]
jb jloop


inc word[i]
mov dx,word[i]
cmp dx,word[m]
jb iloop


;printing array
mov eax,0
mov ecx,0
mov ebx,a
mov byte[k],0
mov byte[i],0
mov byte[j],0
ltr:

mov dl,byte[i]
cmp dl,byte[n]
jnb checkend

ltrloop:

mov dx,word[ebx+eax*2]
mov word[num],dx
call print_num
pusha
mov eax,4
mov ebx,1
mov ecx,tab
mov edx,1
int 80h
popa

inc byte[i]

inc eax
jmp ltr


checkend:
inc byte[k]
mov dl,byte[k]
cmp dl,byte[m]
jnb exit
mov ecx,0
dec eax
add ecx,eax
movzx edx,word[n]
add ecx,edx
mov byte[j],0
jmp rtl

rtl:

mov dl,byte[j]
cmp dl,byte[n]
jnb checkend2

rtlloop:
mov dx,word[ebx+ecx*2]
mov word[num],dx
call print_num
pusha
mov eax,4
mov ebx,1
mov ecx,tab
mov edx,1
int 80h
popa
inc byte[j]

dec ecx
jmp rtl

checkend2:
inc byte[k]
mov dl,byte[k]
cmp dl,byte[m]
jnb exit
mov eax,0
inc ecx
add eax,ecx
movzx edx,word[n]
add eax,edx
mov byte[i],0
jmp ltr





exit:
mov eax,1
mov ebx,0
int 80h

read_num:
pusha
mov word[num],0

loop_read:
mov eax,3
mov ebx,0
mov ecx,d
mov edx,1
int 80h

cmp byte[d],10
je end_read
cmp byte[d],32
je end_read

mov ax,word[num]
mov bx,10
mul bx
mov bl, byte[d]
mov bh,0
sub bl,30h
add ax,bx
mov word[num],ax
jmp loop_read
end_read:
popa
ret

print_num:
mov byte[nod],0
pusha
extract_num:
cmp word[num],0
je print_no
inc byte[nod]

mov dx,0
mov ax,word[num]
mov bx,10
div bx
push dx
mov word[num],ax
jmp extract_num

print_no:
cmp byte[nod],0
je end_print
dec byte[nod]
pop dx
mov byte[d],dl
add byte[d],30h

mov eax,4
mov ebx,1
mov ecx,d
mov edx,1
int 80h
jmp print_no
end_print:
popa
ret




section .data
tab:db " "
newline: db 10
msg1: db "Enter m: "
len1:equ $-msg1
msg2: db "Enter n: "
len2: equ $-msg2
msg3: db "Enter elements: ", 0Ah
len3:equ $-msg3
section .bss
i:resw 1
j:resw 1
k:resw 1
n:resw 1
m:resw 1
a:resw 200
num:resw 1
d:resb 1
nod:resb 1

