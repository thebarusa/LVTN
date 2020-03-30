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
/* Public defines ----------------------------------------------------- */
#define FFT_LENGTH   256
#define MELFB_NUM    20
#define SAMPLE_RATE  8000
#define MELFB_LENGTH (FFT_LENGTH/2 + 1)
/* Public enumerate/structure ----------------------------------------- */


/* Public macros ------------------------------------------------------ */


/* Public variables --------------------------------------------------- */


/* Public function prototypes ----------------------------------------- */
void merge_array(float32_t *des, int16_t *ndes, float32_t *temp, int16_t ntemp);
void linspace(float a, float b, uint16_t n, float u[]);
void hamming(float h[], int16_t n);
void endcut(float32_t *y, float32_t *x, int16_t n, float32_t es, int16_t *ly, int16_t lx);
void mel_filterbank(uint16_t p, uint16_t n, uint16_t fs, float fbank[]);
#endif // __DSP_H

/* End of file -------------------------------------------------------- */
