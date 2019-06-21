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


;matrice B


mov eax,4
mov ebx,1
mov ecx,msg1
mov edx,len1
int 80h

;read p
call read_num
mov dx,word[num]
mov word[p],dx


mov al,byte[p]
cmp al,byte[n]
jne exitmsg



mov eax,4
mov ebx,1
mov ecx,msg2
mov edx,len2
int 80h


;read q
call read_num
mov dx,word[num]
mov word[q],dx

mov eax,4
mov ebx,1
mov ecx,msg3
mov edx,len3
int 80h


;read elements
mov eax,0
mov ebx,b
mov word[i],0
mov word[j],0

iloop2:
mov word[j],0

jloop2:
call read_num
mov dx,word[num]
mov word[ebx+eax*2],dx

inc eax
inc word[j]
mov dx,word[j]
cmp dx,word[q]
jb jloop2


inc word[i]
mov dx,word[i]
cmp dx,word[p]
jb iloop2


;multiplication

mov eax,a
mov ebx,b
mov ecx,0
mov byte[i],0
mov byte[j],0
mov byte[k],0

loopi:

mov word[j],0
pusha
mov eax,4
mov ebx,1
mov ecx,newline
mov edx,1
int 80h
popa

loopj:
mov word[k],0
mov word[sum],0

loopk:
push eax
mov ax,word[i]
mov dx,word[n]
mul dx
add ax,word[k]
movzx edx,ax
pop eax

mov cx,word[eax+2*edx]


push eax
mov ax,word[k]
mov dx,word[q]
mul dx
add ax,word[j]
movzx edx,ax


mov ax,word[ebx+2*edx]
mul cx
add ax,word[sum]
mov word[sum],ax
pop eax

inc word[k]
mov dx,word[k]
cmp dx,word[p]
jb loopk

mov dx,word[sum]
mov word[num],dx
call print_num
pusha
mov eax,4
mov ebx,1
mov ecx,tab
mov edx,1
int 80h
popa
inc word[j]
mov dx,word[j]
cmp dx,word[q]
jb loopj

inc word[i]
mov dx,word[i]
cmp dx,word[m]
jb loopi

jmp exit



















;print a
printa:
pusha
mov eax,0
mov ebx,a
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
cmp dx,word[q]
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

exitmsg:
mov eax,4
mov ebx,1
mov ecx,emsg
mov edx,len4
int 80h

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
emsg: db "Not Possible"
len4:equ $-emsg


section .bss
i:resw 1
j:resw 1
k:resw 1
n:resw 1
m:resw 1
p:resw 1
q:resw 1
sum:resw 1
a:resw 200
b:resw 200
num:resw 1
d:resb 1
nod:resb 1
t1:resb 1

