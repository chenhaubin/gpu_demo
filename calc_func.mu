#include "musa_runtime.h"
#include "device_launch_parameters.h"
#include "basic_func.h"
#include <stdlib.h>
#include <stdio.h>
__device__ double single_calc(
    int i1, 
    int i2, 
    int i3,
    int i4, 
    int i5, 
    int i6, 
    double d1, 
    double d2,
    int * i7, 
    bool *b1, 
    int i8){

    int t1 = 0;
    bool t2 = false;
    bool t3 = false;
    int t4 = i3;
    int t5 = i4;


    f1(
            i1,
            i3,
            i4,
            i5,
            i6,
            i7,
            b1,
            i8,
            &t1,
            &t2,
            &t3,
            &t4,
            &t5
        );
    
    int t6 = 0;
    int * t7 = (int*)malloc(sizeof(int) * (i2 + 1));
    my_f2(
        t1,
        t4,
        t5,
        i3,
        i4,
        i5,
        i6,
        i7,
        b1,
        i8,
        i2 + 1,
        t7,
        &t6
    );
    double t8 = f3(
        d2,
        d1,
        t7,
        t6,
        i7,
        b1,
        i8
        );
    
    free(t7);
    return t8;
}

__global__  void   calc_ken(
    int i1, 
    int * i2, 
    int * i3,
    int * i4, 
    int * i5, 
    int * i6,
    double * d1, 
    double * d2, 
    int * i7, 
    bool *b1, 
    int i8,
    double *d4
){
    int c = blockIdx.x;
    d4[c]= single_calc(
        i1, 
        i2[c], 
        i3[c],
        i4[c], 
        i5[c], 
        i6[c], 
        d1[c], 
        d2[c], 
        i7, 
        b1, 
        i8);
}

extern "C" int  batch_calc(
    int i1, 
    int i2,
    int * i3, 
    int * i4,
    int * i5, 
    int * i6, 
    int * i7,
    double * d1, 
    double * d2, 
    int * i8, 
    bool *b1, 
    int i9,
    double *d3
    ){
    
    int * dev_i3=NULL;
	int * dev_i4=NULL;
	int * dev_i5=NULL;
	int * dev_i6=NULL;
	int * dev_i7=NULL; 
	double * dev_d1    =NULL;
	double * dev_d2    =NULL;
    int *dev_i8    =NULL;
    bool* dev_b1 =NULL;
    double * dev_d3 = NULL;
    musaError_t cudaStatus;
    
    cudaStatus  = musaMalloc((void**)&dev_i3, i2 * sizeof(int));                   
    if(cudaStatus != musaSuccess )                                                                         
    {                                                                                                      
        printf("\ncudaMalloc CU_FAILed!<<<%s>>>\n",musaGetErrorString(cudaStatus));                        
        printf("Error:<%s,%s,%d>  dev_i3\n",__FILE__,__FUNCTION__,__LINE__ );               
        goto Error;                                                                                        
    }                                                                                                      
    musaMemcpy(dev_i3, i3, i2  * sizeof(int), musaMemcpyHostToDevice);
    
    
    cudaStatus  = musaMalloc((void**)&dev_i4, i2 * sizeof(int));                   
    if(cudaStatus != musaSuccess )                                                                         
    {                                                                                                      
        printf("\ncudaMalloc CU_FAILed!<<<%s>>>\n",musaGetErrorString(cudaStatus));                        
        printf("Error:<%s,%s,%d>  dev_i4\n",__FILE__,__FUNCTION__,__LINE__ );               
        goto Error;                                                                                        
    }                                                                                                      
    musaMemcpy(dev_i4, i4, i2  * sizeof(int), musaMemcpyHostToDevice);
    
    cudaStatus  = musaMalloc((void**)&dev_i5, i2 * sizeof(int));                   
    if(cudaStatus != musaSuccess )                                                                         
    {                                                                                                      
        printf("\ncudaMalloc CU_FAILed!<<<%s>>>\n",musaGetErrorString(cudaStatus));                        
        printf("Error:<%s,%s,%d>  dev_i5\n",__FILE__,__FUNCTION__,__LINE__ );               
        goto Error;                                                                                        
    }                                                                                                      
    musaMemcpy(dev_i5, i5, i2  * sizeof(int), musaMemcpyHostToDevice);
    
    cudaStatus  = musaMalloc((void**)&dev_i6, i2 * sizeof(int));                   
    if(cudaStatus != musaSuccess )                                                                         
    {                                                                                                      
        printf("\ncudaMalloc CU_FAILed!<<<%s>>>\n",musaGetErrorString(cudaStatus));                        
        printf("Error:<%s,%s,%d>  dev_i6\n",__FILE__,__FUNCTION__,__LINE__ );               
        goto Error;                                                                                        
    }                                                                                                      
    musaMemcpy(dev_i6, i6, i2  * sizeof(int), musaMemcpyHostToDevice);
    
    cudaStatus  = musaMalloc((void**)&dev_i7, i2 * sizeof(int));                   
    if(cudaStatus != musaSuccess )                                                                         
    {                                                                                                      
        printf("\ncudaMalloc CU_FAILed!<<<%s>>>\n",musaGetErrorString(cudaStatus));                        
        printf("Error:<%s,%s,%d>  dev_i7\n",__FILE__,__FUNCTION__,__LINE__ );               
        goto Error;                                                                                        
    }                                                                                                      
    musaMemcpy(dev_i7, i7, i2  * sizeof(int), musaMemcpyHostToDevice);
    
    cudaStatus  = musaMalloc((void**)&dev_d1, i2 * sizeof(double));                   
    if(cudaStatus != musaSuccess )                                                                         
    {                                                                                                      
        printf("\ncudaMalloc CU_FAILed!<<<%s>>>\n",musaGetErrorString(cudaStatus));                        
        printf("Error:<%s,%s,%d>  dev_d1\n",__FILE__,__FUNCTION__,__LINE__ );               
        goto Error;                                                                                        
    }                                                                                                      
    musaMemcpy(dev_d1, d1, i2  * sizeof(double), musaMemcpyHostToDevice);
    
    cudaStatus  = musaMalloc((void**)&dev_d2, i2 * sizeof(double));                   
    if(cudaStatus != musaSuccess )                                                                         
    {                                                                                                      
        printf("\ncudaMalloc CU_FAILed!<<<%s>>>\n",musaGetErrorString(cudaStatus));                        
        printf("Error:<%s,%s,%d>  dev_d2\n",__FILE__,__FUNCTION__,__LINE__ );               
        goto Error;                                                                                        
    }                                                                                                      
    musaMemcpy(dev_d2, d2, i2  * sizeof(double), musaMemcpyHostToDevice);
    
    cudaStatus  = musaMalloc((void**)&dev_i8, i9 * sizeof(int));                   
    if(cudaStatus != musaSuccess )                                                                         
    {                                                                                                      
        printf("\ncudaMalloc CU_FAILed!<<<%s>>>\n",musaGetErrorString(cudaStatus));                        
        printf("Error:<%s,%s,%d>  dev_i8\n",__FILE__,__FUNCTION__,__LINE__ );               
        goto Error;                                                                                        
    }                                                                                                      
    musaMemcpy(dev_i8, i8, i9  * sizeof(int), musaMemcpyHostToDevice);
    
    cudaStatus  = musaMalloc((void**)&dev_b1, i9 * sizeof(bool));                   
    if(cudaStatus != musaSuccess )                                                                         
    {                                                                                                      
        printf("\ncudaMalloc CU_FAILed!<<<%s>>>\n",musaGetErrorString(cudaStatus));                        
        printf("Error:<%s,%s,%d>  dev_b1\n",__FILE__,__FUNCTION__,__LINE__ );               
        goto Error;                                                                                        
    }                                                                                                      
    musaMemcpy(dev_b1, b1, i9  * sizeof(bool), musaMemcpyHostToDevice);
    
    cudaStatus  = musaMalloc((void**)&dev_d3, i2 * sizeof(double));                   
    if(cudaStatus != musaSuccess )                                                                         
    {                                                                                                      
        printf("\ncudaMalloc CU_FAILed!<<<%s>>>\n",musaGetErrorString(cudaStatus));                        
        printf("Error:<%s,%s,%d>  dev_d4\n",__FILE__,__FUNCTION__,__LINE__ );               
        goto Error;                                                                                        
    }                                                                                                      
    musaMemset(dev_d3, 0x00, i2  * sizeof(double));
    
    calc_ken<<< i2,1>>>(
        i1, 
        dev_i3, 
        dev_i4,
        dev_i5, 
        dev_i6, 
        dev_i7, 
        dev_d1, 
        dev_d2, 
        dev_i8, 
        dev_b1, 
        i9,
        dev_d3);
    
    musaMemcpy(d3, dev_d3, i2 * sizeof(double), musaMemcpyDeviceToHost);
Error:
    musaFree(dev_i3);
    musaFree(dev_i4);
    musaFree(dev_i5);
    musaFree(dev_i6);
    musaFree(dev_i7);
    musaFree(dev_d1);
    
    musaFree(dev_d2);
    musaFree(dev_d3);
    musaFree(dev_i8);
    
    musaFree(dev_b1);
    return 0;
}







