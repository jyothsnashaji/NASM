section .text
global _start:
_start:

;checking number of vowels
mov eax,4
mov ebx,1
mov ecx,msg
mov edx,len1
int 80h


;reading string

mov eax,string
mov byte[len],0
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

mov dl,byte[d]
mov byte[eax],dl
inc eax
inc byte[len]
jmp read

end_read:
mov byte[eax],0

mov eax,string
mov byte[a],0

count:
mov dl,byte[eax]

cmp dl,'a'
je inc_a

cmp dl,'A'
je inc_a

cmp dl,'e'
je inc_a

cmp dl,'E'
je inc_a

cmp dl,'i'
je inc_a

cmp dl,'I'
je inc_a

cmp dl,'o'
je inc_a

cmp dl,'O'
je inc_a

cmp dl,'u'
je inc_a

cmp dl,'U'
je inc_a

check:
inc eax
dec byte[len]
cmp byte[len],0
jne count


mov eax,4
mov ebx,1
mov ecx,msga
mov edx,alen
int 80h
mov dx,word[a]
mov word[num],dx
call print_num
call printl



jmp exit

inc_a:
inc byte[a]
jmp check


print_num:
mov byte[nod],0
pusha
cmp word[num],0
je print0
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

print0:
mov eax,4
mov ebx,1
mov ecx,zero
mov edx,1
int 80h
jmp end_print

printl:
mov eax,4
mov ebx,1
mov ecx,newline
mov edx,1
int 80h
ret

;printing string

print:
cmp byte[len],0
je endprint

mov dl,byte[eax]
mov byte[d],dl

pusha
mov eax,4
mov ebx,1
mov ecx,d
mov edx,1
int 80h
popa

inc eax
dec byte[len]
jmp print

endprint:
ret


exit:
mov eax,1
mov ebx,0
int 80h

section .bss
d:resw 1
string:resw 50
len:resw 1
a:resw 1
num:resw 1
nod:resw 1

section .data
tab:db " "
newline:db 0Ah
zero:db "0"
msga:db "Number of vowels: "
alen:equ $-msga
msg:db "Enter string: "
len1:equ $-msg
