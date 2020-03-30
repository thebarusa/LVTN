/**
 * @file       dsp.c
 * @copyright  Copyright (C) BKU All rights reserved.
 * @license    This project is released under the BKU License.
 * @version    major.minor.patch
 * @date       19/3/2020
 * @author     Nguyen The Hung
 *             
 * @brief      digital signal process source file
 *             
 * @note          
 */

/* Includes ----------------------------------------------------------- */
#include "dsp.h"


/* Private defines ---------------------------------------------------- */


/* Private enumerate/structure ---------------------------------------- */

/* Private macros ----------------------------------------------------- */


/* Public variables --------------------------------------------------- */


/* Private variables -------------------------------------------------- */


/* Private function prototypes ---------------------------------------- */
void merge_array(float *des, int16_t *ndes, float *temp, int16_t ntemp)
{
	int16_t m = *ndes, k;
	*ndes += ntemp;
	for (k = (*ndes - ntemp); k < *ndes; k++)
	{
		des[k] = temp[k - m];
	}
	
}

void linspace(float a, float b, uint16_t n, float u[])
{
    float c;
    uint16_t i;
      
    /* step size */
    c = (b - a)/(n - 1);  
    /* fill vector */
    for(i = 0; i < n - 1; ++i)
        u[i] = a + i*c;   
    /* fix last entry to b */
    u[n - 1] = b;
}

void hamming(float h[], int16_t n)
{
	for(uint16_t i = 0; i < n; i++)
	{
		h[i] = 0.54 - 0.46 * cosf(2.0 * PI * (float)i / (float)(n-1));
	}
}

void endcut(float *y, float *x, int16_t n, float es, int16_t *ly, int16_t lx)
{
	float t1[10], t2[10],  avr, e1, e;
	int16_t i, ln, k, lt;
	
	*ly = 0;
	arm_mean_f32(x, (uint32_t)lx, &avr);	            // mean(x)
	arm_offset_f32(x, -avr, x, (uint32_t)lx);         // x = x - mean(x)
	arm_copy_f32(x, t1, (uint32_t)n);                 // t1 = x(1:n)
	arm_mult_f32(t1, t1, t2, (uint32_t)n);            // t2 = t1.^2
	arm_mean_f32(t2, (uint32_t)n, &e);                // e = mean(t1.^2)
	i  = n + 1;
	ln = lx - n + 1;
	
	while (i <= ln)
	{
		lt = 0;
		for (k=i-1; k<(i+n-1); k++)                     // t = x(i:i+n-1) 
		{
	    t1[lt++] = x[k];
		}
		arm_mult_f32(t1, t1, t2, (uint32_t)n);          // t2 = t1.^2
		arm_mean_f32(t2, (uint32_t)n, &e1);             // e1 = mean(t1.^2)
		if (~((e1 < es) | (fabsf(e1 - e) < es)))
		{
			merge_array(y, ly, t1, n);                    // y = [y;t] 
			*ly += n;
		}
		i = i + n;	
	}
}


void mel_filterbank(uint16_t p, uint16_t n, uint16_t fs, float fbank[])
{
	float mel_points[p+2], hz_points[p+2], f[p+2];
	float mel_low, mel_high; 
	uint16_t fm_left, fm_center, fm_right;
	uint16_t fb_length = floor(n/2)+1;
	
	mel_low = 0;
	mel_high = 2595.0f * log10f(1.0f + (((float)fs / 2.0f)/700.0f));
  linspace(mel_low, mel_high, p+2, mel_points);
	for(uint16_t i = 0; i < (p+2); i++)
	{
		hz_points[i] = 700 * (powf(10.0f, (mel_points[i]/2595.0f)) - 1);
	}
	for(uint16_t i = 0; i < (p+2); i++)
	{
		f[i] = floor((n+1)*hz_points[i]/fs);
	}
	
	f[0] = 1;
	for(uint16_t m = 1; m < (p+1); m++)
	{
		fm_left   = f[m-1];
		fm_center = f[m];
		fm_right  = f[m+1];
		for(uint16_t k = fm_left; k < (fm_center+1); k++)
		{
			fbank[(m-1)*fb_length+k-1] = ((float)k - f[m-1])/(f[m]-f[m-1]);
		}
		fbank[(m-1)*fb_length+fm_center] = 1;
		for(uint16_t k = fm_center; k < (fm_right+1); k++)
		{
			fbank[(m-1)*fb_length+k-1] = (f[m+1] - k)/(f[m+1] - f[m]);
		}
	} 	
}
/* End of file -------------------------------------------------------- */
