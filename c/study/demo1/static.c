/*
在C语言中，static的字面意思很容易把我们导入歧途，其实它的作用有三条。
(1)第一个作用：隐藏。
当我们同时编译多个文件时，所有未加static前缀的全局变量和函数都具有全局可见性。为理解这句话，我举例来说明。我们要同时编译两个源文件，一个是a.c，另一个是main.c。
下面是a.c的内容
#include <cstdio>增加这条语句
char a = ‘A‘; // global variable
void msg() 
{
     printf("Hello\n"); 
}
如果加了static，就会对其它源文件隐藏。Static可以用作函数和变量的前缀，对于函数来讲，static的作用仅限于隐藏，而对于变量，static还有下面两个作用

(2)static的第二个作用是保持变量内容的持久。存储在静态数据区的变量会在程序刚开始运行时就完成初始化，也是唯一的一次初始化。共有两种变量存储在静态存储区：全局变量和static变量，只不过和全局变量比起来，static可以控制变量的可见范围，说到底static还是用来隐藏的。

(3)static的第三个作用是默认初始化为0。其实全局变量也具备这一属性，因为全局变量也存储在静态数据区。在静态数据区，内存中所有的字节默认值都是0x00，某些时候这一特点可以减少程序员的工作量

*/

#include <stdio.h>

//static 的变量默认初始化为0	
static int a;
static char arr[10] = "hello";

int main(int argc, char **argv)
{
    //static 的变量默认初始化为0	
	// static int a;
	// static char arr[10];

	printf("integer:%d,string:[%s]\n",a,arr);
	return 0;
}
