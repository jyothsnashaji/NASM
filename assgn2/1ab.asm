section .text 
global _start:
_start:


;read a
call read
mov byte[a],al

;read b
call read
mov byte[b],al

;reading the number of array elements
call read
mov byte[n],al
mov byte[temp],al
mov ebx,array

;reading array elements
reading:

push ebx
call read
pop ebx
mov byte[ebx],al

add ebx,1
dec byte[temp]
cmp byte[temp],0
jg reading

mov cl,byte[n]
mov byte[temp],cl
mov ebx, array

divisible:

mov al,byte[ebx]
mov cl,byte[a]
div cl
cmp ah,0
jne loopcheck


mov al,byte[ebx]


mov cl,byte[b]
div cl
cmp ah,0
jne loopcheck


mov al,byte[ebx]
push ebx
call print
pop ebx

loopcheck:
add ebx,1
dec byte[temp]
cmp byte[temp],0
jg divisible
jmp exit
read:
mov eax,3
mov ebx,0
mov ecx,d1
mov edx,1
int 80h

mov eax,3
mov ebx,0
mov ecx,d2
mov edx,1
int 80h

mov eax,3
mov ebx,0
mov ecx,j
mov edx,1
int 80h

sub byte[d1],30h
sub byte[d2],30h

mov al,byte[d1]
mov bl,10
mul bl
mov bl,byte[d2]
add al,bl
ret

print:
;xor ah,ah
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

mov eax,4 
mov ebx,0
mov ecx,tab
mov edx,1
int 80h
ret



exit:

mov eax,1
mov ebx,0
int 80h

section .data
tab:db " "

section .bss
d1:resb 1
d2:resb 1
array:resb 20
temp:resb 1
n:resb 1
a:resb 1
b:resb 1
j:resb 1
