data segment stack
c db 0
d dw 0
data ends
code segment
assume cs:code, ds:data
main:
   mov ax, 0B800h;   �Կ��ڴ�λ��
   mov es, ax
   mov di,0
input1:
   mov ah, 1
   int 21h
   sub al, 30h
   cmp al, 9h;    �ж��ǲ�������
   jbe number1
   sub al, 7h
number1:
   mov cl, 4;    �������λ��Ҫ����16
   shl al, cl
   mov c, al
input2:
   mov ah, 1
   int 21h
   sub al, 30h
   cmp al, 9h
   jbe number2
   sub al, 7h
number2:
   add al, c;    ����ԭ�ȵĸ�λ
   mov cx, 16
doit:
   cmp cx, 0
   je over
   mov byte ptr es:[di], al;     �����ַ�����ɫ
   mov byte ptr es:[di+1], 7Ch
   mov bl, al
   mov d, cx;    �˴��Ȱ�cx ��ֵ�������� �����޸�cl��ᵼ����ѭ��
   mov cl, 4;    ������λ����Ҫ��cl
   shr bl, cl
   mov cx, d
   cmp bl, 9
   jbe num1
   add bl, 7
num1:
   add bl, '0'
   mov byte ptr es:[di+2], bl
   mov byte ptr es:[di+3], 1Ah
   mov bl, al
   and bl, 15
   cmp bl, 9
   jbe num2
   add bl, 7
num2:
   add bl, '0'
   mov byte ptr es:[di+4], bl
   mov byte ptr es:[di+5], 1Ah
   add al, 1;     ������һ���ַ�
   add di, 160;   ���������һ��
   sub cx, 1
   jmp doit
over:
   mov ah, 0
   int 16h;       ��esc�˳�����
   mov ah, 4Ch
   int 21h
code ends
end main