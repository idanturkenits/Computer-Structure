#include <stdio.h>
#include <string.h>


int x = 100;
char c = 'a';
double d = 15.23;

void arith(int x, int y, int z){
    int t1 = (x + y) / 2;
    int t2 = z * 48;
    int t4 = t1 * t2;

    printf("the result is %d", t4);
}


void lower(char *s){
    for (int i = 0; i < strlen(s); i++)
        if (s[i] >= 'A' && s[i] <= 'Z')
            s[i] -= ('A' - 'a');
    
    printf("The new string is %s", s);
}

void sumAndSave(int *arr, int len, int *sum){
    *sum = 0;
    for(int i = 0; i < len; i++){
        *sum += arr[i];
    }
}

void multArrBy2(int *arr, int len){
    int mult = 2;
    for(int i = 0; i < len; i++){
        arr[i] = arr[i] * mult;
    }
}

int returnSumWithBias(int *arr, int len, int a, int b){
    int sum = 0;
    for(int i = 0; i < len; i++){
        int bias = a * b;
        sum += arr[i] + bias; 
    }
    return sum;
}

int main(){
    char str [20] = "HELLO WORLD";
    lower(str);
}


