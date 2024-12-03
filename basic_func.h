#ifndef __BAISC_FUNC_H
#define __BAISC_FUNC_H
#include "cuda_runtime.h"
#include "device_launch_parameters.h"


__device__  int f1(
	int i1,
	int i2,
	int i3,
	int i4,
	int i5,
	int* i7,
	bool* b1,
	int i8,
	int* i9,
	bool* b2,
	bool* b3,
	int* i11,
	int* i12
);


__device__  int f2(
	int i1,
	int i2,
	int i3,
	int i4,
	int i5,
	int i6,
	int i7,
	int* i8,
	bool* b1,
	int i9,
	int i10,
	int* i11,
	int* i12
);

__device__ double f3(
    double  d1,
    double  d2,
    int*    i1,
    int     i2,
    int*    i3,
    bool*   b1,
    int     i4
);


#endif