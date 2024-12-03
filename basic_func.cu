#include "cuda_runtime.h"
#include "device_launch_parameters.h"


__device__ bool f17(int i1)
{

		if (i1 % 4 == 0 && i1 % 100 != 0)
		{
			return true;
		}
		else
		{
			return false;
		}
}

__device__ int  f16(
	int i1,
	int i2,
	int i3
)
{
	if(i2 < 3)
	{
		--i1;
		i2 += 12;
	}
	return 365 * i1 + (i1 >> 2) - i1 / 100 + i1 / 400 + (153 * i2 - 457) / 5 + i3 -306;
}

__device__ int  f14(
	int* i1,
	int i2,
	int i3,
	int i4
)
{
	int t1 = i4 / 10000;
	int t2 = (i4  % 10000) / 100;
	int t3 = i4 % 100;
	int t4 = i1[0] / 10000;
	int t5 = (i1[0] % 10000) / 100;
	int t6 = i1[0] % 100;
	int t7 = f16(t1, t2, t3) - f16(t4, t5,t6);
	if(t7 > i3 || t7 < i2)
	{
		int t8 = t7 - (t7 /7 *2);
		if(t8 > i3)
		{
			t8 = i3;
		}
		while (i2 <= t8)
		{
			int t9 = i2 - (i2 - t8) / 2;
			if (i1[t9] > i4)
			{
				t8 = t9 - 1;
			}
			else
			{
				return t9;
			}
		}
	}
	else if(i1[t7] == i4)
	{
		return t7;
	}
	
	else
	{
		if(i1[t7] < i4)
		{
			i2 = t7;
		}
		else if(i1[t7] > i4)
		{
			i3 = t7;
		}
		while (i2 <= i3)
		{
			int t9 = i2 - (i2 - i3) / 2; 
			if (i1[t9] > i4)
			{
				i3 = t9 - 1;
			}
			else
			{
				return t9;
			}
		}
	
	}
	return -1;
}

__device__ int f15(
	int i1,
	int* i2,
	bool* b1,
	int i3,
	bool* b2
)
{
	if (0 == i3) return -1;
	int t1 = f14(
		i2,
		0,
		i3 - 1,
		i1
	);
	
	if (-1 == t1)
	{
		return -1;
	}
	*b2 = b1[t1];
	return 0;
}

__device__ int f13(
	int i1,
	int* i2
)
{

	*i2 = -1;
	int t1 = i1 % 100;
	int t2 = i1 % 10000 / 100;
	int t3 = i1 / 10000;

		if (1 == t2 || 3 == t2 || 5 == t2 || 7 == t2 ||
			8 == t2 || 10 == t2 || 12 == t2)
		{
			if (t3 > 31)
			{
				*i2 = (i1 / 100) * 100 + 31;
			}
			else
			{
				*i2 = i1;
			}

		}
		else if (2 != t2)
		{
			if (t3 > 30)
			{
				*i2 = (i1 / 100) * 100 + 30;
			}
			else
			{
				*i2 = i1;
			}

		}
		else {
				*i2 = (i1 / 100) * 100 + 28;
		}
	
	return 0;
}

__device__ int f12(
	int i1,
	int i2,
	int* i3,
	int i4,
	int* i5
)
{

	if (0 == i4) return -1;
	int t1 = f14(i3, 0, i4 - 1, i1);
	int t2 = f14(i3, 0, i4 - 1, i2);
	if (-1 == t1 || -1 == t2)
	{
		return -1;
	}
	*i5 = t2 - t1;

	return 0;
}

__device__ int f9(
	int i1,
	int i2,
	int* i3,
	bool* b1,
	int i4,
	double* d1
)
{
	int t1 = 0;
	*d1 = 0;
    f12(
        i1,
        i2,
        i3,
        i4,
        &t1
		);
    *d1 = (double)(t1) / 365;
	return 0;
}
__device__ int  f10(
	int i1,
	int i2,
	int* i3
)
{
	int t1 = i1 / 10000;
	int t2 = (i1 / 100) % 100;
	int t3 = i1 % 100;
	*i3 = (t1 + (t2 + i2 - 1) / 12) * 10000 + (((t2 + i2 - 1) % 12) + 1) * 100 + t3;
	f13(*i3, i3);

	return 0;
}

__device__ int f11(
	int i1,
	int* i2
)
{

	*i2 = -1;
	int t1 = i1 % 10000 / 100;
	int t2 = i1 / 10000;
	if (1 == t1 || 3 == t1 || 5 == t1 || 7 == t1 ||
		8 == t1 || 10 == t1 || 12 == t1)
	{
		*i2 = (i1 / 100) * 100 + 31;
	}
	else if (2 != t1)
	{
		*i2 = (i1 / 100) * 100 + 30;
	}
	else {
			*i2 = (i1 / 100) * 100 + 28;
	}
	return 0;
}

__device__ int f7(
	int i1,
	int i2,
	int i3,
	int* i4,
	int i5,
	int* i6
)
{
	int t1 = 0;
	int t2 = 0;
	int t3 = 0;

    f10(
        i1,
        i2,
        &t3
    );
    
    f11(i1, &t2);
    if (i1 == t2) {
        f11(t3, i6);
    }
    else {
        *i6 = t3;
    }

	return 0;
}

__device__ int f8(
	int i1,
	int* i2,
	bool* b1,
	int i3,
	int* i4
)
{
	bool t1 = false;
	f15(
		i1,
		i2,
		b1,
		i3,
		&t1);
	if (true == t1)
	{
		*i4 = i1;
		return 0;
	}
}

__device__ int f6(
	int i1,
	int i2,
	int i3,
	int* i4,
	bool* b1,
	int i5,
	int* i6
)
{
	f7(
		i1,
		i2,
		i3,
		i4,
		i5,
		i6
	);
	f8(
		*i6,
		i4,
		b1,
		i5,
		i6
	);
	return 0;
}

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
)
{
    int t1 = 0;
    int t2 = 0;
    int t3 = i4;
    int t4 = t3;

    
    t2 = 0;
    t1 = i1;
    i11[0] = i2;
    t2 = 1;
    t1 += 1;
        

    while (t4 < i5)
    {
        f6(
            i4,
            i6 * t1,
            i7,
            i8,
            b1,
            i9,
            &t4
        );
        
        if (t4 >= i5)
        {
            i11[t2] = i5;
            ++t2;
            
            break;
        }
        else
        {
            i11[t2] = t4;
            ++t2;
            ++t1;
        }
    }
    if (i10 < t2)
    {
        return -1;
    }

    *i12 = t2;
	return 0;
}


__device__ double f3(
    double  d1,
    double  d2,
    int*    i1,
    int     i2,
    int*    i3,
    bool*   b1,
    int     i4
){
	double t1 = 0.0;
    double t2 =0.0;
	for (int i = 0; i < i2; ++i)
	{
		f9(
			i1[i],
			i1[i + 1],
			i3,
			b1,
			i4,
			&t1
		);
        t2 += (d2 / 100.0 * t1 * d1);
	}

	return t2;
}

__device__ int  f4(
	int i1,
	int i2,
	int* i3,
	int i4,
	int* i5
)
{
	if (0 == i4) return -1;
	if (i1 > i2) return -1;
	int t1 = i1 / 10000;
	int t2 = i1 % 10000 / 100;
	int t3 = i2 / 10000;
	int t4 = i2 % 10000 / 100;
	*i5 = (t3 - t1) * 12 + t4 - t2;
	return 0;
}

__device__  int f5(
	int i1,
	int i2,
	int i3,
	int i4,
	int i5,
	int* i6,
	bool* b1,
	int i7
)
{
	int t1 = 0;
	int t2 = 0;
	if (i1 > i3)
	{
		return -1;
	}
	if (i2 <= i3)
	{
		return -1;
	}
	int t3 = 0;
	int t4 = 0;
    f4(
        i1,
        i3,
        i6,
        i7,
        &t3
    );
    t1 = (int)floor((double)t3 / (double)i4);

    f7(
        i1,
        t1 * i4,
        i5,
        i6,
        i7,
        &t2
    );
    
    f8(
         t2,
         i6,
         b1,
         i7,
         &t2
    );
    
    if (t2 > i3)
    {
        t1 -= 1;
    }

	return t1;
}

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
)
{
	*b3 = false;
	*b2 = false;
	int t1 = 0;
	bool t2 = true;

	int t3 = 0;

	int t4 = i2;
		t1 = f5(
			i2,
			i3,
			i1,
			i4,
			i5,
			i7,
			b1,
			i8
		);

			*b2 = false;
			while (t3 < i3)
			{
				
                f6(
                    i2,
                    i4 * t1,
                    i5,
                    i7,
                    b1,
                    i8,
                    &t3
                );
				
				if (t3 > i1 && t2 == true)
				{
					t2 = false;
					*i9 = t1 - 1;
					
						f6(
							i2,
							i4 * (*i9),
							i5,
							i7,
							b1,
							i8,
							i11
						);
					
					if (t3 >= i3)
					{
						*b3 = true;
						*i12 = i3;
					}
					else
					{
						*i12 = t3;
					}
					break;
				}
				t4 = t3;
				++t1;
			}
		

	
	return 0;
}
