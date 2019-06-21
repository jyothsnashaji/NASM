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


mov ebx,a
mov ecx,b
mov ax,word[m]
dec dx
mov dx,word[n]
mul dx
movzx eax,ax
mov byte[i],0
mov byte[j],0
mov byte[t1],0
mainloop:

mov ax,word[m]
dec ax
mov dx,word[n]
mul dx
add ax,word[i]
movzx eax,ax
mov byte[j],0

subloop:
mov dx,word[ebx+2*eax]
mov word[num],dx
call print_num
pusha
mov eax,4
mov ebx,1
mov ecx,tab
mov edx,1
int 80h
popa
push eax
movzx eax,byte[t1]
mov word[ecx+2*eax],dx
pop eax

inc byte[j]
inc byte[t1]
movzx edx,word[n]
sub eax,edx
inc ecx
mov dl,byte[j]
cmp dl,byte[m]
jb subloop

pusha
mov eax,4
mov ebx,1
mov ecx,newline
mov edx,1
int 80h
popa


inc byte[i]
mov dl,byte[i]
cmp dl,byte[n]
jb mainloop


;call printa
jmp exit























;print a
printa:
pusha
mov eax,0
mov ebx,b
mov word[i],0
mov word[j],0

iploop:
mov word[j],0

jploop:
mov dx,word[ebx+2*eax]
mov word[num],dx
call print_num

pusha
mov eax,4
mov ebx,1
mov ecx,tab
mov edx,1
int 80h

popa
inc eax
inc word[j]
mov dx,word[j]
cmp dx,word[m]
jb jploop

pusha
mov eax,4
mov ebx,1
mov ecx,newline
mov edx,1
int 80h
popa

inc word[i]
mov dx,word[i]
cmp dx,word[n]
jb iploop
popa
ret

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
msg3: db "Enter elements: ",0Ah
len3:equ $-msg3

section .bss
i:resw 1
j:resw 1
n:resw 1
m:resw 1
a:resw 200
b:resw 200
num:resw 1
d:resb 1
nod:resb 1
t1:resb 1
t2:resb 1
