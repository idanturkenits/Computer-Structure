
#include <stdio.h>
///this is code in c, your code need to be in assembly
/// good luck!

int even(int x, int y);
int go(int *);

int main()
{
    int array[10] = {5,-3,4,-5,6,-1,2,3,-1,0};
    int answer = go(array);
    printf("this is you answer: %d", answer);
    return 0;
}