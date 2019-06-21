section .data

msg1:db "Enter n:"
len1:equ $-msg1
msg2:db "Enter k:"
len2:equ $-msg2
line:db 0Ah
fmt1:db "%lf",0
fmt2:db "%lf",10

section .bss
num:resw 1
i:resw 1
j:resw 1
k:resw 1
a:resq 20
d:resw 1

section .text


global main:
extern printf
extern scanf


main:
mov eax,4
mov ebx,1
mov ecx,msg1
mov edx,len1
int 80h
call read_num


mov eax,4
mov ebx,1
mov ecx,msg2
mov edx,len2
int 80h
call read

mov byte[i],0
mov ebx,a

reading:
call read
movzx eax,byte[i]
fstp qword[ebx+8*eax]
inc byte[i]
mov al,byte[num]
cmp byte[i],al
jb reading

;call print

mov byte[i],0
mov ebx,a
mainloop:
mov al,byte[i]
mov byte[j],al
movzx eax,byte[i]
fld qword[ebx+8*eax]
subloop:
movzx eax,byte[j]
fld qword[ebx+8*eax]
fadd st1
fcomi st2
jne subcheck1

fsub st1

call print
fstp qword[ebx+8*eax]
call print
call printl

subcheck:


inc byte[j]
mov al,byte[num]
cmp byte[j],al
jb subloop

maincheck:
movzx eax,byte[i]
fstp qword[ebx+8*eax]
inc byte[i]
mov al,byte[num]
cmp byte[i],al
jb mainloop


;call print

exit:
mov ebx,0
mov eax,1
int 80h

subcheck1:
fsub st1
fstp qword[ebx+8*eax]
jmp subcheck

read:
push ebp
mov ebp,esp

sub esp,8
lea eax,[esp]
push eax
push fmt1
call scanf
fld qword[ebp-8]
mov esp,ebp
pop ebp
ret


print:
push ebp
mov ebp,esp

sub esp,8
fst qword[ebp-8]

push fmt2
call printf
mov esp,ebp
pop ebp

ret



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

printl:
pusha
mov eax,4
mov ebx,1
mov ecx,line
mov edx,1
int 80h
popa
ret
