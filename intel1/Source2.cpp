#include "windows.h"
#include "stdio.h"

char Out[256];
int X;
int APIENTRY WinMain(HINSTANCE hInstance,HINSTANCE hPrevInstance,
LPSTR lpCmdLine,int nCmdShow)
{ _asm //подключение ассемблерной вставки
	{
		 mov eax,2 		;копирует 2 в регистр eax
		 mov ebx,3  	;аналогично
		 add eax,ebx 	;eax +ebx = 2+3=5; результат записан в eax
		 mov X,eax 		;копирует в переменную X из регистра eax
	 }
	 sprintf(Out,"число - %d",X);	//создаем строку, которая будет 
	 //записана в массив out
	 MessageBox(NULL,Out,"TEST",MB_OK);
	 return 1;
}