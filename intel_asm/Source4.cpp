#include "windows.h"
#include "stdio.h"
extern "C" void Funct(char* x, char* y, int Len);
char In[256],Out[256];
int APIENTRY WinMain(HINSTANCE hInstance,HINSTANCE hPrevInstance,
LPSTR lpCmdLine,int nCmdShow)
{
sprintf(In,"Моя строка");
Funct(In,Out,strlen(In));
MessageBox(NULL,Out,"TEST",MB_OK);
return 1;
}