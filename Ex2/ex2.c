#include "ex2.h"

magnitude int_to_magnitude(int a){
    if(a >= 0){
        return a;
    }else{
        return (1 << 31) | -a;
    }
}

int magnitude_to_int(magnitude a){
    if(a > 0){
        return a;
    }else{
        return (1 << 31) | -a;
    }
}

magnitude add(magnitude a, magnitude b){
    return int_to_magnitude(magnitude_to_int(a) + magnitude_to_int(b));
}

magnitude sub(magnitude a, magnitude b){
    return int_to_magnitude(magnitude_to_int(a) - magnitude_to_int(b));
}

magnitude multi(magnitude a, magnitude b){
    return int_to_magnitude(magnitude_to_int(a) * magnitude_to_int(b));
}
int greater(magnitude a, magnitude b){
    return magnitude_to_int(a) > magnitude_to_int(b);
}
int equal(magnitude a, magnitude b){
    return magnitude_to_int(a) == magnitude_to_int(b);
}