// numstr.cpp -- following number input with line input
/*
* 此程序的BUG是当cin读取年份，将回车键生成的换行符留在了输入队列中
* 后面的cin.getline(address,80);看到换行符后，将认为是一个空行，并将一个
* 空字符串赋值给address数组。
* 解决BUG的思路是：在读取地址之前，先读取并丢弃换行符。可以使用没有参数的
* get()或使用接受一个char参数的get()
* cin >>year;
* cin.get();// or cin.get(ch);
*/ 
#include <iostream>
int main()
{
    using namespace std;
    cout << "What year was your house built?\n";
    int year;
    cin >> year;
    // cin.get();
    cout << "What is its street address?\n";
    char address[80];
    cin.getline(address, 80);
    cout << "Year built: " << year << endl;
    cout << "Address: " << address << endl;
    cout << "Done!\n";
    // cin.get();
    return 0; 
}
