section .text 
global _start:
_start:


;reading the number of array elements
mov eax,4
mov ebx,1
mov ecx,entern
mov edx,len3
int 80h

call read
mov byte[n],al
mov byte[temp],al


;reading array elements
mov eax,4
mov ebx,1
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

mov cl,byte[n]
mov byte[temp],cl
mov ebx, array
mov byte[ce],0
mov byte[co],0

divisible:

mov al,byte[ebx]
mov cl,2
div cl
cmp ah,0
je ine
inc byte[co]
jmp loopcheck

ine:
inc byte[ce]

loopcheck:
add ebx,1
dec byte[temp]
cmp byte[temp],0
jg divisible

mov eax,4
mov ebx,1
mov ecx,eve
mov edx,len1
int 80h
mov al,byte[ce]
call print

mov eax,4
mov ebx,1
mov ecx,odd
mov edx,len2
int 80h
mov al,byte[co]
call print
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
eve:db "Even numbers: "
len1:equ $-eve
odd:db "Odd numbers:"
len2:equ $-odd
entern:db "Enter n: "
len3:equ $-entern
ele:db "Enter the elements: "
len4:equ $-ele

section .bss
d1:resb 1
d2:resb 1
array:resb 20
temp:resb 1
n:resb 1
j:resb 1
ce:resb 1
co:resb 1
