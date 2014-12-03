#include <stdio.h>
#include <math.h>

void sphere( float radius, float *surface, float *volume){
	*surface  = M_PI * 4 * radius * radius;
	*volume  = M_PI * ( 4 / 3 ) * radius * radius * radius;
}

