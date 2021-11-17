// Idan Turkenits 326685815
#include "ex2.h"

/*****************************************************
* input : int a
* output : magnitude
* function operation: converts the given integer to
* the magnitude form.
******************************************************/
magnitude int_to_magnitude(int a){
    if(a >= 0){
        return a;
    }else{
        return (1 << 31) | -a;
    }
}

/*****************************************************
* input : magnitude a
* output : int
* function operation: converts the given magnitude to
* the integer form.
******************************************************/
int magnitude_to_int(magnitude a){
    if(a > 0){
        return a;
    }else{
        return -(~(1 << 31) & a);
    }
}
/*****************************************************
* input : magnitude, magnitude
* output : magnitude
* function operation: adds the given magnitudes
******************************************************/
magnitude add(magnitude a, magnitude b){
    int a_int = magnitude_to_int(a);
    int b_int = magnitude_to_int(b);
    int sum =  a_int + b_int;
    if(a_int >= -b_int){
        return int_to_magnitude(sum & ~(1 << 31));
    }
    if(a_int < -b_int){
        return int_to_magnitude(sum | (1 << 31));
    }
}

/*****************************************************
* input : magnitude, magnitude
* output : magnitude
* function operation: substruct the given magnitudes
******************************************************/
magnitude sub(magnitude a, magnitude b){
    int a_int = magnitude_to_int(a);
    int b_int = magnitude_to_int(b);
    int result =  a_int - b_int;
    if(a_int >= b_int){
        return int_to_magnitude(result & ~(1 << 31));
    }
    if(b_int > a_int){
        return int_to_magnitude(result | (1 << 31));
    }
}

/*****************************************************
* input : magnitude, magnitude
* output : magnitude
* function operation: multiply the given magnitudes
******************************************************/
magnitude multi(magnitude a, magnitude b){
    int a_int = magnitude_to_int(a);
    int b_int = magnitude_to_int(b);
    int mult =  a_int * b_int;
    
    if(a_int >= 0 && b_int >= 0 || a_int <= 0 && b_int <= 0){
        return int_to_magnitude(mult & ~(1 << 31));
    }
    if(a_int > 0 && b_int < 0 || a_int < 0 && b_int > 0){
        return int_to_magnitude(mult | (1 << 31));
    }
}

/*********************************************************
* input : magnitude a, magnitude b
* output : int
* function operation: returns 1 if a > b, else returns 0
**********************************************************/
int greater(magnitude a, magnitude b){
    return magnitude_to_int(a) > magnitude_to_int(b);
}

/*********************************************************
* input : magnitude a, magnitude b
* output : int
* function operation: returns 1 if a = b, else returns 0
**********************************************************/
int equal(magnitude a, magnitude b){
    return magnitude_to_int(a) == magnitude_to_int(b);
}