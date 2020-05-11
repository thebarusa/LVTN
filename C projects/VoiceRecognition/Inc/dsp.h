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
#define FFT_LENGTH    256
#define MELFB_NUM     20
#define SAMPLE_RATE   8000
#define MELFB_LENGTH  (FFT_LENGTH/2 + 1)
#define SAMPLE_LENGTH 16000U
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
void hamming(float h[], int16_t n);
dsp_return block_frames(float mdes[], float src[], float h[], uint16_t nsrc, uint16_t m, uint16_t n);
void mel_filterbank(float32_t *fbank, uint16_t p, uint16_t n, uint16_t fs);
void dct_log_transform(float outvect[], float invect[], size_t len);
void mfcc(float matdes[], float matsrc[], uint16_t row, uint16_t col);
#endif // __DSP_H

/* End of file -------------------------------------------------------- */
