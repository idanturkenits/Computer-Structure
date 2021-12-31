#include <stdio.h>

#define  SIZE 400000000
char a[SIZE], b[SIZE];

void cpy1(char* src, char *dst, int number_of_bytes){
    for(int i = 0; i < number_of_bytes; i++){
        *dst++ = *src++;
    }
}


void cpy2(char* src, char *dst, int number_of_bytes){
    for(int i = 0; i < number_of_bytes; i+=4){
        *dst++ = *src++;
        *dst++ = *src++;
        *dst++ = *src++;
        *dst++ = *src++;
    }
}


void cpy3(char* src, char *dst, int number_of_bytes){
    
    int repeat = number_of_bytes / sizeof(unsigned long long);
    int after = number_of_bytes % sizeof(unsigned long long);

    unsigned long long * usrc = (unsigned long long *) src;
    unsigned long long * udst = (unsigned long long *) dst;
    

    for(int i = 0; i < repeat; i++){
        *udst++ = *usrc++;
    }

    src = (char *)usrc;
    dst = (char *)udst;

    for(int i = 0; i < after; i++){
        *src++ = *dst++;
    }
}

void cpy4(char* src, char *dst, int number_of_bytes){
        
    int repeat = number_of_bytes / (sizeof(unsigned long));
    int after = number_of_bytes % (sizeof(unsigned long));

    unsigned long * usrc = (unsigned long *) src;
    unsigned long * udst = (unsigned long *) dst;
    

    for(int i = 0; i < repeat; i+=4){
        *udst++ = *usrc++;
        *udst++ = *usrc++;
        *udst++ = *usrc++;
        *udst++ = *usrc++;
    }

    src = (char *)usrc;
    dst = (char *)udst;

    for(int i = 0; i < after; i++){
        *src++ = *dst++;
    }
}
void main(){
    //#define m cpy1
     #define m cpy2
    // #define m cpy3
    //#define m cpy4
	for(int i = 0; i < 30; i++){
		m(a,b,SIZE);
	}
}
