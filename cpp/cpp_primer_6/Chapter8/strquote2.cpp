// strquote.cpp  -- different designs
#include <iostream>
#include <string>
using namespace std;
string version1(const string & s1, const string & s2);
const string & version2(string & s1, const string & s2);  // has side effect
const string & version3(string & s1, const string & s2, string & s3);  //解决strquote.cpp的问题 
 
int main()
{
    string input;
    string copy;
    string result;
	// added by ltl
	string & myresult = result ;

    cout << "Enter a string: ";
    getline(cin, input);
    copy = input;
    cout << "Your string as entered: " << input << endl;
    result = version1(input, "***");
    cout << "Your string enhanced: " << result << endl;
    cout << "Your original string: " << input << endl;
 
    result = version2(input, "###");
    cout << "Your string enhanced: " << result << endl;
    cout << "Your original string: " << input << endl;

    cout << "Resetting original string.\n";
    input = copy;
    result = version3(input, "@@@",myresult);
    cout << "Your string enhanced: " << myresult << endl;
    cout << "Your original string: " << input << endl;
	// cin.get();
	// cin.get();
    return 0;
}

string version1(const string & s1, const string & s2)
{
    string temp;

    temp = s2 + s1 + s2;
    return temp;
}

const string & version2(string & s1, const string & s2)   // has side effect
{
    s1 = s2 + s1 + s2;
// safe to return reference passed to function
    return s1; 
}

const string & version3(string & s1, const string & s2, string & s3)   // bad design
{
    s3 = s2 + s1 + s2;
// unsafe to return reference to local variable
    return s3;
}
