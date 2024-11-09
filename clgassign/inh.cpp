#include<iostream>
using namespace std;
class parent{
protected :
  int c;
public:
  void display(){
  c = 100;
  cout<<"base class"<<c<<"\n";
  
  }
  
};
class child : public parent{
 public:
   void disp(){
     c=200;
     cout<<"derived class"<<c<<"\n";
     
  }
  };
int main()
{

child obj;
parent p;
obj.disp();
obj.display();
p.display();

return 0;

}
