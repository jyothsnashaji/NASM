section .bss
digit0: resb 1
digit1: resb 1
array: resb 50
element: resb 1
num: resb 1
pos: resb 1
temp: resb 1
ele: resb 1
;Array to store 50 elements of 1 byte each.
section .data
msg1: db "Enter the number of elements : "
size1: equ $-msg1
msg2: db "Enter a number:"
size2: equ $-msg2
msg3: db "Enter the number to be searched : "
size3: equ $-msg3
msg_found: db "Element found at position : "
size_found: equ $-msg_found
msg_not: db "Element not found"
size_not: equ $-msg_not
55section .text
global _start
_start:
;Printing the message to enter the number
mov eax, 4
mov ebx, 1
mov ecx, msg1
mov edx, size1
int 80h
;Reading
mov eax,
mov ebx,
mov ecx,
mov edx,
int 80h the number
3
0
digit1
1
mov
mov
mov
mov
int eax,
ebx,
ecx,
edx,
80h 3
0
digit0
1
mov
mov
mov
mov
int eax,
ebx,
ecx,
edx,
80h 3
0
temp
1
sub byte[digit1], 30h
sub byte[digit0], 30h
mov
mov
mul
mov
mov
al, byte[digit1]
dl, 10
dl
byte[num], al
al, byte[digit0]
56add
mov
mov
mov
byte[num], al
al, byte[num]
byte[temp], al
ebx, array
reading:
push ebx
;Preserving The value of ebx in stack
;Printing the message to enter each element
mov eax, 4
mov ebx, 1
mov ecx, msg2
mov edx, size2
int 80h
;Reading
mov eax,
mov ebx,
mov ecx,
mov edx,
int 80h
the number
3
0
digit1
1
mov
mov
mov
mov
int eax,
ebx,
ecx,
edx,
80h
3
0
digit0
2
sub
sub
mov
mov
mul
add byte[digit1], 30h
byte[digit0], 30h
al, byte[digit1]
dl, 10
dl
al, byte[digit0]
;al
pop
mov
add
dec now contains the number
ebx
byte[ebx], al
ebx, 1
byte[temp]
57cmp byte[temp], 0
jg reading
;Comparing loop variable
;Loop using branch statements
;Reading
mov eax,
mov ebx,
mov ecx,
mov edx,
int 80h the number to be searched :.....
4
1
msg3
size3
;Reading
mov eax,
mov ebx,
mov ecx,
mov edx,
int 80h the number
3
0
digit1
1
mov
mov
mov
mov
int eax,
ebx,
ecx,
edx,
80h 3
0
digit0
2
sub
sub
mov
mov
mul
add byte[digit1], 30h
byte[digit0], 30h
al, byte[digit1]
dl, 10
dl
al, byte[digit0]
;al
pop
mov
add
dec
cmp now contains the number
ebx
byte[ebx], al
ebx, 1
byte[temp]
byte[temp], 0
58jg reading
;Comparing loop variable
;Loop using branch statements
;Reading
mov eax,
mov ebx,
mov ecx,
mov edx,
int 80h the number to be searched :.....
4
1
msg3
size3
;Reading
mov eax,
mov ebx,
mov ecx,
mov edx,
int 80h the number
3
0
digit1
1
mov
mov
mov
mov
int 3
0
digit0
2
eax,
ebx,
ecx,
edx,
80h
sub byte[digit1], 30h
sub byte[digit0], 30h
mov al, byte[digit1]
mov dl, 10
mul dl
add al, byte[digit0]
mov byte[ele], al
movzx ecx, byte[num]
mov ebx, array
mov byte[pos], 1
searching:
push ecx
mov al , byte[ebx]
59cmp al, byte[ele]
je found
add ebx, 1
pop ecx
add byte[pos], 1
loop searching
mov eax, 4
mov ebx, 1
mov ecx, msg_not
mov edx, size_not
int 80h
exit:
mov eax, 1
mov ebx, 0
int 80h
found:
mov eax,
mov ebx,
mov ecx,
mov edx,
int 80h
4
1
msg_found
size_found
movzx ax, byte[pos]
mov bl, 10
div bl
mov byte[digit1], al
mov byte[digit0], ah
add byte[digit0], 30h
add byte[digit1], 30h
mov eax, 4
mov ebx, 1
mov ecx, digit1
mov edx, 1
int 80h
mov eax, 4
mov ebx, 1
mov ecx, digit0
60mov edx, 1
int 80h
jmp exit
