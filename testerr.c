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
    typedef A;
    int a, b;
    printf("Enter first number: ");
    scanf("%d", &a);
    printf("Enter second number: ");
    scanf("%d", &b); 7+8 //syntax error
    printf("GCD is %d",gcd(a,b));
    return 1;
}
