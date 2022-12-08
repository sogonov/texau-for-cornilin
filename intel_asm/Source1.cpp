#include "windows.h" //подключение библиотек
#include "stdio.h"
char Out[256]; //массив, хранящий текст
int X; //переменная, необходимая в следующем примере

int APIENTRY WinMain(HINSTANCE hInstance, 
HINSTANCE hPrevInstance, LPSTR lpCmdLine, int nCmdShow)
// функция, выводящая на экран сообщение с результатом
{
sprintf(Out,"Моя программа");
MessageBox(NULL, Out, "TEST", MB_OK);
return 1;
}
