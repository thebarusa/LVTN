/**
 * @file       dsp.c
 * @copyright  Copyright (C) BKU All rights reserved.
 * @license    This project is released under the BKU License.
 * @version    major.minor.patch
 * @date       19/3/2020
 * @author     Nguyen The Hung
 *             
 * @brief      digital signal process header file
 *             
 * @note          
 */

/* Define to prevent recursive inclusion ------------------------------ */
#ifndef __DSP_H
#define __DSP_H

/* Includes ----------------------------------------------------------- */
#include <stdint.h>
#include "arm_math.h"
#include <math.h>
#include <stdlib.h>
/* Public defines ----------------------------------------------------- */
#define FFT_LENGTH       256
#define FRAME_OVERLAP    100
#define MELFB_NUM     	 20
#define SAMPLE_RATE      8000
#define MELFB_LENGTH     (FFT_LENGTH/2 + 1)
#define SAMPLE_LENGTH    16000U
/* Public enumerate/structure ----------------------------------------- */
typedef enum 
{
	DSP_OK = 0,
	DSP_ERROR
}dsp_return;

/* Public macros ------------------------------------------------------ */


/* Public variables --------------------------------------------------- */


/* Public function prototypes ----------------------------------------- */
void merge_array(float32_t des[], int16_t *ndes, float32_t temp[], int16_t ntemp);
void linspace(float a, float b, uint16_t n, float u[]);
dsp_return block_frames(float mdes[], float src[], const float h[], uint16_t nsrc, uint16_t m, uint16_t n);
void dct_log_transform(float outvect[], float invect[], size_t len);
dsp_return mfcc(float mfcc_mat[], float signal[], const float hamming[], const float melfb[], uint32_t siglen);
float voice_compare(float Amat[], float Bmat[], uint32_t row, uint32_t colA, uint32_t colB);
#endif // __DSP_H

/* End of file -------------------------------------------------------- */
