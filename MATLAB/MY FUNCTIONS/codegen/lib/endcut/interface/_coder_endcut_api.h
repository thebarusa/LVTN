/*
 * File: _coder_endcut_api.h
 *
 * MATLAB Coder version            : 4.2
 * C/C++ source code generated on  : 15-Feb-2020 20:27:06
 */

#ifndef _CODER_ENDCUT_API_H
#define _CODER_ENDCUT_API_H

/* Include Files */
#include "tmwtypes.h"
#include "mex.h"
#include "emlrt.h"
#include <stddef.h>
#include <stdlib.h>
#include "_coder_endcut_api.h"

/* Type Definitions */
#ifndef struct_emxArray_real_T
#define struct_emxArray_real_T

struct emxArray_real_T
{
  real_T *data;
  int32_T *size;
  int32_T allocatedSize;
  int32_T numDimensions;
  boolean_T canFreeData;
};

#endif                                 /*struct_emxArray_real_T*/

#ifndef typedef_emxArray_real_T
#define typedef_emxArray_real_T

typedef struct emxArray_real_T emxArray_real_T;

#endif                                 /*typedef_emxArray_real_T*/

/* Variable Declarations */
extern emlrtCTX emlrtRootTLSGlobal;
extern emlrtContext emlrtContextGlobal;

/* Function Declarations */
extern void endcut(real_T x[3200], uint32_T n, real_T es, emxArray_real_T *y);
extern void endcut_api(const mxArray *prhs[3], int32_T nlhs, const mxArray *
  plhs[1]);
extern void endcut_atexit(void);
extern void endcut_initialize(void);
extern void endcut_terminate(void);
extern void endcut_xil_shutdown(void);
extern void endcut_xil_terminate(void);

#endif

/*
 * File trailer for _coder_endcut_api.h
 *
 * [EOF]
 */
