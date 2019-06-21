section .text
global _start:
_start:

mov eax,3
mov ebx,0
mov ecx,digit01
mov edx,1
int 80h

mov eax,3
mov ebx,0
mov ecx,digit02
mov edx,2
int 80h

sub byte[digit01],30h
sub byte[digit02],30h
mov al,byte[digit01]
mov dl,10
mul dl
movzx bx,byte[digit02]
add ax,bx
mov word[num0],ax
;read second num
mov eax,3
mov ebx,0
mov ecx,digit11
mov edx,1
int 80h

mov eax,3
mov ebx,0
mov ecx,digit12
mov edx,2
int 80h

sub byte[digit11],30h
sub byte[digit12],30h
mov al,byte[digit11]
mov dl,10
mul dl
movzx bx,byte[digit12]
add ax,bx
mov word[num1],ax
;reading third num
mov eax,3
mov ebx,0
mov ecx,digit21
mov edx,1
int 80h

mov eax,3
mov ebx,0
mov ecx,digit22
mov edx,2
int 80h

sub byte[digit21],30h
sub byte[digit22],30h
mov al,byte[digit21]
mov dl,10
mul dl
movzx bx,byte[digit22]
add ax,bx
mov word[num2],ax

mov ax,word[num0]
mov bx,word[num1]
mov cx,word[num2]



cmp ax,bx
ja checkca
cmp bx,cx
ja pb
;printcx
mov ax,cx
jmp p

pb:
;print bx
mov ax,bx
jmp p
checkca:
cmp cx,ax
ja pc
;print ax
jmp p
pc:
;print cx
mov ax,cx
jmp p

p:
mov dl,10

div dl
mov byte[digit01],ah
mov byte[digit02],al
add byte[digit01],30h
add byte[digit02],30h


mov eax,4
mov ebx,1
mov ecx,digit02
mov edx,1
int 80h

mov eax,4
mov ebx,1
mov ecx,digit01
mov edx,1
int 80h

mov eax,1
mov ebx,0
int 80h




section .bss
digit01:resb 2
digit02:resb 2
num0:resw 1
digit11:resb 2
digit12:resb 2
num1:resw 1
digit21:resb 2
digit22:resb 2
num2:resw 1



