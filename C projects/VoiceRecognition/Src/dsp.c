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
#include "main.h"
//#include "dsp_coeffs.c"

/* Private defines ---------------------------------------------------- */


/* Private enumerate/structure ---------------------------------------- */

/* Private macros ----------------------------------------------------- */


/* Public variables --------------------------------------------------- */

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

dsp_return block_frames(float mdes[], float src[], const float h[], uint16_t nsrc, uint16_t m, uint16_t n)
{
	uint16_t nbFrame = floor((nsrc-n)/m)+1;
	uint16_t i, j;
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

dsp_return mfcc(float mfcc_mat[], float signal[], const float hamming[], const float melfb[], uint32_t siglen)
{
	dsp_return ret; 
	uint32_t nbFrame;
	float frame[MELFB_LENGTH*MAX_MEL_FRAME];
	float result[MELFB_NUM*MAX_MEL_FRAME];
	float invect[MELFB_NUM], outvect[MELFB_NUM];
	uint8_t k = 0;
	arm_matrix_instance_f32 fb;
	arm_matrix_instance_f32 fr;
	arm_matrix_instance_f32 res;
	
	arm_mat_init_f32(&fb, MELFB_NUM, MELFB_LENGTH, (float32_t *)melfb);
	
	if(siglen > 1000)
	{
		nbFrame = (siglen - FFT_LENGTH) / FRAME_OVERLAP + 1;
		arm_mat_init_f32(&fr, MELFB_LENGTH, nbFrame, (float32_t *)frame);
		arm_mat_init_f32(&res, MELFB_NUM, nbFrame, (float32_t *)result);
		block_frames(frame, signal, hamming, (uint16_t)siglen, FRAME_OVERLAP, FFT_LENGTH);
		if(arm_mat_mult_f32(&fb, &fr, &res) != ARM_MATH_SUCCESS)
			return DSP_ERROR;
		for(uint8_t j = 0; j < nbFrame; j++)
		{
			k = 0;
			for(uint8_t i = 0; i < MELFB_NUM; i++)
			{
				invect[k++] = result[i*nbFrame+j];
			}
			dct_log_transform(outvect, invect, MELFB_NUM);
			k = 0;
			for(uint8_t i = 0; i < MELFB_NUM; i++)
			{
				mfcc_mat[i*nbFrame+j] = outvect[k++];
			}		
		}
	}
}

//float euclidean(float Avect[], float Bvect[], uint32_t len)
//{
//	float Cvect[len];
//	float result;
//	
//	arm_sub_f32(Avect, Bvect, Cvect, len);
//	arm_rms_f32(Cvect, len, &result);
//	return (result * sqrtf(len));
//}

float euclidean(float Avect[], float Bvect[], uint32_t len)
{
	float Cvect[len];
	float result;
	float pesi[MELFB_NUM] = {0.2f, 0.9f, 0.95f, 0.9f, 0.7f, 0.9f, 1.0f, 1.0f, 1.0f, 0.95f, 0.3f, 0.3f, 0.3f};
	arm_sub_f32(Avect, Bvect, Cvect, len);
	arm_abs_f32(Cvect, Cvect, len);
	arm_mult_f32(Cvect, pesi, Cvect, len);
	arm_mean_f32(Cvect, len, &result);
	return (result * len);
}

float voice_compare(float Amat[], float Bmat[], uint32_t row, uint32_t colA, uint32_t colB)
{
	float d_mat[colA][colB];
	float min_sum = 0, min;
	uint32_t id;
	float AmatT[row*colA];
	float BmatT[row*colB];
	arm_matrix_instance_f32 A, B, AT, BT;

	arm_mat_init_f32(&A, row, colA, Amat);
	arm_mat_init_f32(&B, row, colB, Bmat);
	arm_mat_init_f32(&AT, colA, row, AmatT);
	arm_mat_init_f32(&BT, colB, row, BmatT);
	
	arm_mat_trans_f32(&A, &AT);
	arm_mat_trans_f32(&B, &BT);
	for(uint32_t i = 0; i < colA; i++)
	{
		for(uint32_t j = 0; j < colB; j++)
		{
      d_mat[i][j] = euclidean(&AmatT[i * row], &BmatT[j * row], row);
		}
		arm_min_f32(d_mat[i], colB, &min, &id);
		min_sum += min;
	}
	
	return (min_sum / (float)colA);
}
/* End of file -------------------------------------------------------- */
