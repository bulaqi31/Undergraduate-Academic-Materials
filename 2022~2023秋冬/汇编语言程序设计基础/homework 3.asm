.386
data segment use16
num2 dd 0 ;���������¼��������
op db '+'
aa db 0
ans dd 0 ;���������������������ֽ��
data ends

stack1 segment stack use16
   dw 100h dup(?)
stack1 ends
code segment use16
assume cs:code,ds:data
main:
   mov ax,data
   mov ds,ax
input:
   mov edx, 0
   mov ah, 1
   int 21h; al=getchar()
   mov aa, al; �����������㣬al��ֵ�ᱻ����
   sub aa, '0'
   cmp al, '0'
   jb operation; ������ַ���С����ô���ǲ��������ǻس���Ҫ����һ�β���
number:
   mov eax, num2
   mov ebx, 10
   mul ebx; *10
   mov dl, aa
   add eax, edx
   mov num2, eax
   jmp input

operation:
   mov cl, op;          ��ȡ֮ǰ��һ�������
   mov op, al;          ����Ϊ��ǰ�������
   cmp cl, '+'
   je do_add
   cmp cl, '*'
   je do_mul
   cmp cl, '/'
   je do_div
do_add:;                 �ӷ�
   mov eax, ans
   add eax, num2
   mov ans, eax
   jmp ok
do_mul:;                 �˷�
   mov eax, ans
   mul num2
   mov ans, eax
   jmp ok
do_div:; ����
   mov edx, 0;           ��edx��Ϊ0
   mov eax, ans
   div num2
   mov ans, eax
ok:
   mov dl, op
   cmp dl, 0Dh;   ����ǻس��������������
   je output
   mov eax, 0
   mov num2, eax;  �������������
   jmp input;
output:
   mov dl, 0Dh
   mov ah, 2
   int 21h
   mov dl, 0Ah
   mov ah, 2
   int 21h
   mov eax, ans
   mov cx,0
output_dec:;           ���ʮ����
   mov edx, 0
   cmp eax, 0
   je output_
   mov ebx, 10
   div ebx
   add dl, '0'
   push dx;    ������ַ���ջ
   add cx, 1
   jmp output_dec
output_:
   cmp cx, 0
   je output_it
   pop dx;      ���ַ���ջ�����
   mov ah, 2
   int 21h
   sub cx, 1
   jmp output_
output_it:
   mov dl, 0Dh
   mov ah, 2
   int 21h
   mov dl, 0Ah
   mov ah, 2
   int 21h
   mov eax, ans
output_hex:
   mov edx, 0
   cmp eax, 0
   je output0_
   mov ebx, 16
   div ebx
   add dl, '0';    ����һ��֮����ʮ������ͬ������Ҫ�ж��ǲ�����ĸ
   cmp dl, '9'
   jbe numb
letter:
   add dl, 7
numb:
   push dx
   add cx, 1
   jmp output_hex
output0_:
   mov bx, 8
   sub bx, cx
output1_:
   cmp bx, 0
   je output2_
   mov dl, '0';   ��������ǰ�油0
   mov ah, 2
   int 21h
   sub bx, 1
   jmp output1_
output2_:
   cmp cx, 0
   je done
   pop dx;      ���ַ���ջ�����
   mov ah, 2
   int 21h
   sub cx, 1
   jmp output2_
done:
   mov dl, 'h';  ���������������һ��h
   mov ah, 2
   int 21h
   mov dl, 0Dh
   mov ah, 2
   int 21h
   mov dl, 0Ah
   mov ah, 2
   int 21h
   mov ah, 4Ch
   int 21h
code ends
end main