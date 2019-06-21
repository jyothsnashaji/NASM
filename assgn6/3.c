#include<stdio.h>

int addNumbers(int n)
{ if(n != 0)
return (n + addNumbers(n-1));
else
return n;
}
int main()
{int n;
 scanf("%d",&n);
 printf("%d", addNumbers(n));
return 0;
}
