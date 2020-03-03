/*
 * File: endcut.c
 *
 * MATLAB Coder version            : 4.2
 * C/C++ source code generated on  : 15-Feb-2020 20:27:06
 */

/* Include Files */
#include <math.h>
#include <string.h>
#include "endcut.h"
#include "endcut_emxutil.h"
#include "mean.h"
#include "power.h"

/* Function Definitions */

/*
 * cat khoang lang ra khoi x.
 *  n là do dài frame, es là nguong nang luong.
 * Arguments    : double x[3200]
 *                unsigned int n
 *                double es
 *                emxArray_real_T *y
 * Return Type  : void
 */
void endcut(double x[3200], unsigned int n, double es, emxArray_real_T *y)
{
  double d0;
  int i0;
  int i;
  int x_size[1];
  double x_data[3200];
  double tmp_data[3200];
  int tmp_size[1];
  double e_tmp;
  unsigned int u0;
  int x_size_tmp;
  int i1;
  int i2;
  d0 = mean(x);
  for (i0 = 0; i0 < 3200; i0++) {
    x[i0] -= d0;
  }

  y->size[0] = 0;
  if (1U > n) {
    i = 0;
  } else {
    i = (int)n;
  }

  x_size[0] = i;
  if (0 <= i - 1) {
    memcpy(&x_data[0], &x[0], (unsigned int)(i * (int)sizeof(double)));
  }

  power(x_data, x_size, tmp_data, tmp_size);
  e_tmp = b_mean(tmp_data, tmp_size);
  i = (int)(n + 1U);
  while ((unsigned int)i <= 3201U - n) {
    u0 = i + n;
    i0 = (int)(u0 - 1U);
    if ((unsigned int)i > (unsigned int)i0) {
      i = 0;
      i0 = 0;
    } else {
      i--;
    }

    x_size_tmp = i0 - i;
    x_size[0] = x_size_tmp;
    for (i1 = 0; i1 < x_size_tmp; i1++) {
      x_data[i1] = x[i + i1];
    }

    power(x_data, x_size, tmp_data, tmp_size);
    d0 = b_mean(tmp_data, tmp_size);
    if ((!(d0 < es)) && (!(fabs(d0 - e_tmp) < es))) {
      i1 = y->size[0];
      i2 = y->size[0];
      y->size[0] = (i1 + i0) - i;
      emxEnsureCapacity_real_T(y, i2);
      for (i0 = 0; i0 < x_size_tmp; i0++) {
        y->data[i1 + i0] = x[i + i0];
      }
    }

    i = (int)u0;
  }
}

/*
 * File trailer for endcut.c
 *
 * [EOF]
 */
