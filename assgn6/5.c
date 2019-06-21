#include<stdio.h>
int Fibonacci(int i)
{
if (i == 0)
return 0;
if (i == 1)
return 1;
return (Fibonacci(i - 1) + Fibonacci(i - 2));
}

int main()
{int n;
 scanf("%d",&n);
 printf("%d", Fibonacci(n));
return 0;
}
