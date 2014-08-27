// textin4.cpp -- reading chars with cin.get()
#include <iostream>
int main(void)
{
    using namespace std;
    int ch;                         // should be int, not char
    int count = 0;

    while ((ch = cin.get()) != EOF) // test for end-of-file
    {
        cout.put(char(ch));		//cout.put(ch);显示字符ch，ch的参数类型是char,
								// 不是int,进行强制转换
        ++count;
    }
    cout << endl << count << " characters read\n";
	return 0; 
}
