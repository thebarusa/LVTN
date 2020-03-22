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


/* Public enumerate/structure ----------------------------------------- */


/* Public macros ------------------------------------------------------ */


/* Public variables --------------------------------------------------- */


/* Public function prototypes ----------------------------------------- */
void merge_array(float32_t *des, int16_t *ndes, float32_t *temp, int16_t ntemp);
void endcut(float32_t *y, float32_t *x, int16_t n, float32_t es, int16_t *ly, int16_t lx);
#endif // __DSP_H

/* End of file -------------------------------------------------------- */
