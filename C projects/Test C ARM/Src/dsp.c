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

void mel_filterbank(uint16_t p, uint16_t n, uint16_t fs)
{
	uint16_t fn2, b[4];
	float f0, lr;
  float bl[4], pf[150], fp[150], pm[150];
	
	f0  = 700.0f / (float)fs;
	fn2 = floor(n / 2);
	lr  = log((1.0f + 0.5f/f0)) / ((float)p + 1.0f);
	/* convert to fft bin numbers with 0 for DC term */
	bl[0] = (float)n * (f0 * (float)(exp(0) * lr) - 1);
	bl[1] = (float)n * (f0 * (float)(exp(1) * lr) - 1);
	bl[2] = (float)n * (f0 * (float)(exp(p) * lr) - 1);
	bl[3] = (float)n * (f0 * (float)(exp(p+1) * lr) - 1);	
	
	b[0] = floor(bl[0]) + 1;
	b[1] = ceil(bl[1]);
	b[2] = floor(bl[2]);
	b[3] = fmin(fn2, ceil(bl[3])) - 1;
	
	for(int8_t i = b[0]; i < b[3]; i++)
	{
	  pf[i] = log(1 + b[i] / (float)n / f0) / lr;
		fp[i] = floor(pf[i]);
		pm[i] = pf[i] - fp[i];
	}
	
	
}
/* End of file -------------------------------------------------------- */
