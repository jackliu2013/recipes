//tabtenn0.cpp -- simple base-class methods
#include "tabtenn0.h"
#include <iostream>

/* 
*	此处构造函数使用了第12章介绍的成员初始化列表的语法。
*
*	也可以采用下面的形式
* TableTennisPlayer::TableTennisPlayer (const string & fn, 
*    const string & ln, bool ht)
*	{
*		firstname = fn;
*	 	lastname = ln;
*		hasTable = ht;
*	}
*	此种形式首先为firstname调用string的默认构造函数，在调用string的赋值运算符将firstname
*	设置为fn。但初始化列表直接使用string的复制构造函数将firstname初始化为fn。
*/
TableTennisPlayer::TableTennisPlayer (const string & fn, 
    const string & ln, bool ht) : firstname(fn),
	    lastname(ln), hasTable(ht) {}
    
void TableTennisPlayer::Name() const
{
    std::cout << lastname << ", " << firstname;
}
