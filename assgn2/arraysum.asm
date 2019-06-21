section .text 
global _start:
_start:

;reading the number of array elements
mov eax,3
mov ebx,0
mov ecx,d1
mov edx,1
int 80h

mov eax,3
mov ebx,0
mov ecx,d2
mov edx,2
int 80h

sub byte[d1],30h
sub byte[d2],30h

mov al,byte[d1]
mov bl,10
mul bl
movzx bx,byte[d2]
add ax,bx

mov word[n],ax
mov word[temp],ax
mov ebx,array
mov word[sum],0

;reading array elements
read:
push ebx

mov eax,3
mov ebx,0
mov ecx,d1
mov edx,1
int 80h

mov eax,3
mov ebx,0
mov ecx,d2
mov edx,2
int 80h

sub byte[d1],30h
sub byte[d2],30h

mov al,byte[d1]
mov bl,10
mul bl
movzx bx,byte[d2]
add ax,bx
add word[sum],ax
pop ebx
mov word[ebx],ax
add ebx,1
dec word[temp]
cmp word[temp],0
jg read

;printing sum
print:
mov ax,word[sum]
mov dl,10
div dl

mov byte[d1],al
mov byte[d2],ah

add byte[d1],30h
add byte[d2],30h

mov eax,4
mov ebx,0
mov ecx,d1
mov edx,1
int 80h

mov eax,4
mov ebx,0
mov ecx,d2
mov edx,1
int 80h

mov ax,word[sum]
mov bx,word[n]
div bx

mov byte[d1],al
mov byte[d2],dh

add byte[d1],30h
add byte[d2],30h

mov eax,4
mov ebx,0
mov ecx,d1
mov edx,1
int 80h

mov eax,4
mov ebx,0
mov ecx,d2
mov edx,1
int 80h



mov eax,1
mov ebx,0
int 80h

section .bss
d1:resb 1
d2:resb 1
array:resw 20
sum:resw 1
temp:resw 1
n:resw 1
avg:resw 1
