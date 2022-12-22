#include "windows.h"
#include "stdio.h"
char In[256],Out[256];
int N;
BYTE Crypt=0x67;
int APIENTRY WinMain(HINSTANCE hInstance,HINSTANCE hPrevInstance,
LPSTR lpCmdLine,int nCmdShow)
{
sprintf(In,"Моя строка");
N=strlen(In);
_asm
	{
	mov ecx,N ;запись в регистр ecx переменной N
	lea edi,Out ;копирование в edi(регистра приемника) адреса массива out
	lea esi,In ;копирование в esi(регистра источника) адреса массива out
	
	L: lodsb ;Объявление метки L, считываение одного байта из esi в al
	xor al,Crypt ;cравнение байта в al и crypt 
	jnz label ;переход к метке label если результат xor не 0
	mov al,0x20 ;запись в регистр al 20h
	label: stosb ;объявление метки label, запись строки байт в edi
	loop L ;цикл- вернуться к метке L
	}
MessageBox(NULL,Out,"TEST",MB_OK);
return 1;
}