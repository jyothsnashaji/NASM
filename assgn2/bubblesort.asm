section .text 
global _start:
_start:

;reading the number of array elements
mov eax,4
mov ebx,0
mov ecx,entern
mov edx,len3
int 80h

call read
mov byte[n],al
mov byte[temp],al
mov byte[t],al

;reading array elements
mov eax,4
mov ebx,0
mov ecx,ele
mov edx,len4
int 80h
mov ebx,array
reading:

push ebx
call read
pop ebx
mov byte[ebx],al

add ebx,1
dec byte[temp]
cmp byte[temp],0
jg reading

mov byte[temp],0
mov ebx,array


  
mainsort:

mov byte[i],0
mov ecx,ebx
mov al,byte[n]
mov byte[limit],al
dec byte[limit]
mov al,byte[temp]
sub byte[limit],al

subsort:
mov al,byte[ecx]
cmp al,byte[ecx+1]
jb swap

check:
inc ecx
inc byte[i]
mov al,byte[i]
cmp al,byte[limit]
jb subsort

inc ebx
inc byte[temp]
mov al,byte[n]
dec al
cmp byte[temp],al
jb mainsort
call printarray
jmp exit

printarray:
mov ebx,array

printing:
mov al,byte[ebx]
push ebx
call print
pop ebx


add ebx,1
dec byte[t]
cmp byte[t],0
jg printing
ret

swap:
mov al,byte[ecx]
mov dl,byte[ecx+1]
mov byte[ecx+1],al
mov byte[ecx],dl

ret

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
mov ebx,1
mov ecx,d1
mov edx,1
int 80h

mov eax,4
mov ebx,1
mov ecx,d2
mov edx,1
int 80h

mov eax,4 
mov ebx,1
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
entern:db "Enter n: "
len3:equ $-entern
ele:db "Enter the elements: "
len4:equ $-ele

section .bss
d1:resb 1
d2:resb 1
array:resb 20
temp:resb 1
limit:resb 1
n:resb 1
j:resb 1
t:resb 1
i:resb 1
