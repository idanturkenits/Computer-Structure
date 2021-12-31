//idan turkenits 326685815

#include <stdio.h>
#include "pstring.h"


void run_main() {

	Pstring p1;
	Pstring p2;
	int len;
	int opt;

	// initialize first pstring
	scanf("%d", &len);
	scanf("%s", p1.str);
	p1.len = len;

	scanf("%d", &len);
	scanf("%s", p2.str);
	p2.len = len;

	// select which function to run
	printf("%d", pstrijcmp(&p1, &p2, 0,2));
}
