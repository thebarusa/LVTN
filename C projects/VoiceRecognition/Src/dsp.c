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
float *fbank;

/* Private variables -------------------------------------------------- */


/* Private function prototypes ---------------------------------------- */
void merge_array(float des[], int16_t *ndes, float temp[], int16_t ntemp)
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
		h[i] = 0.54f - 0.46f * cosf(2.0f * PI * (float)i / (float)(n-1));
	}
}

dsp_return block_frames(float mdes[], float src[], const float h[], uint16_t nsrc, uint16_t m, uint16_t n)
{
	uint16_t nbFrame = floor((nsrc-n)/m)+1;
	uint16_t i, j, k = 0;
	float fft_1[n+1], fft_2[n+1];
	arm_rfft_fast_instance_f32 real_fft;
	
	if(arm_rfft_fast_init_f32(&real_fft, n) != ARM_MATH_SUCCESS)
	{
		return DSP_ERROR;
	}
	
	for(i = 0; i < nbFrame; i++)
	{
		for(j = 0; j < n; j++)
		{
			fft_1[j] = src[i*m+j] * h[j];					
		}
		arm_rfft_fast_f32(&real_fft, fft_1, fft_2, 0);	
		fft_2[n] = fft_2[1];
		fft_2[1] = 0;
		arm_cmplx_mag_squared_f32(fft_2, fft_1, n/2 + 1);
		for(j = 0; j < (n/2 + 1); j++)
		{
			mdes[j*nbFrame + i] = fft_1[j];
		  //mdes[k++] = fft_1[j];
		}
	}
	return DSP_OK;
}

void mel_filterbank(float *fbank, uint16_t p, uint16_t n, uint16_t fs)
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

// DCT type II, unscaled.
// See: https://en.wikipedia.org/wiki/Discrete_cosine_transform#DCT-II
void dct_log_transform(float outvect[], float invect[], size_t len) 
{
	float factor = PI / (float)len;
	float scale = sqrtf(2.0f/(float)len);
	for (size_t i = 0; i < len; i++) 
	{
		float sum = 0;
		for (size_t j = 0; j < len; j++)
			sum += logf(invect[j]) * cosf(((float)j + 0.5f) * (float)i * factor);
		if(i == 0)
			outvect[i] = sum*scale*1.0f/sqrtf(2.0f);
		else
			outvect[i] = sum*scale;
	}
}

void mfcc(float matdes[], float matsrc[], uint16_t row, uint16_t col)
{
	float invect[row], outvect[row];
	uint8_t k = 0;
	for(uint8_t j = 0; j < col; j++)
	{
		k = 0;
		for(uint8_t i = 0; i < row; i++)
		{
			invect[k++] = matsrc[i*col+j];
		}
		dct_log_transform(outvect, invect, row);
		k = 0;
		for(uint8_t i = 0; i < row; i++)
		{
			matdes[i*col+j] = outvect[k++];
		}		
	}
}

/* End of file -------------------------------------------------------- */
