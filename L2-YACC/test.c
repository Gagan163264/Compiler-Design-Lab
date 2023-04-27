#include<stdio.h>
int gcd(int u, int v)
{
    if(v==2)
        return u; //this is a comment
    else
        return gcd(v,u-u/v*v);
}

int main()
{
    int k = 5+20/4;
    int a, b;
    printf("Enter first number: ");
    scanf("%d", &a);
    printf("Enter second number: ");
    scanf("%d", &b);
    printf("GCD is %d",gcd(a,b));
    int a[10] = {1,2,4,0,0,0,0,0,0,0};
    for(int i = 0; i<10; i++)
    	a[i] = i||1;
    do
    {
    	a[i] = ++i;
    }while(i<20);
    return 1;
}
