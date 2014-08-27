#include <iostream.h>
//using namespace std;

/* º¯ÊıÄ£°æ */
template <class T>
T max(T x, T y)
{
    return x>y? x:y ;
}

int main( )
{
    int x = 7;
    int y = 4;
    cout<<x<<" with "<<y<<" and the max value is:";
    cout<<max( x, y)<<endl;
    double a = 3.5;
    double b = 4.5;
    cout<<a<<" with "<<b<<" and the max value is:";
    cout<<max( a, b)<<endl;
    
    return 0;
}
