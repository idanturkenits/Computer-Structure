
#include <stdio.h>
///this is code in c, your code need to be in assembly
/// good luck!

int even(int x, int y){
    return x<<y;
}
int go(int *);

int go (int A[10]) {
    int sum = 0;
    int i = 0;
    while (i < 10) {
        if (A[i] % 2 == 0) {
            int num = even (A[i], i);
            sum += num;
        } else {
            sum += A[i];
        }
        i++;
    }
    return sum;
}


int main()
{
    int array[10] = {5,-3,4,-5,6,-1,2,3,-1,0};
    int answer = go(array);
    printf("this is you answer: %d", answer);
    return 0;
}