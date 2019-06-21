#include<stdio.h>
int main()
{int a[20],i,j,n,major,minor,t1,t2;
scanf("%d ",&n);
for(i=0;i<n*n;++i)

 scanf("%d",&a[i]);

for(i=0;i<n;++i)
 {t1=0;
t2=0;
 for(j=0;j<n;++j)
  {if(i==j)
    {major=n*i+j;
    ++t1;}
   if(i+j+1==n)
    {minor=n*i+j;
     ++t2;}
   if(t1+t2==2)
    {t1=a[major];
     t2=a[minor];
     a[major]=t2;
     a[minor]=t1;}
     
     }}
     
 for(i=0;i<n;++i)
{  for(j=0;j<n;++j)
    printf("%d ",a[i*n+j] );
    printf("\n");}   
    
    return 0;
    } 
