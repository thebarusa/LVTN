/*
 * File: mean.c
 *
 * MATLAB Coder version            : 4.2
 * C/C++ source code generated on  : 15-Feb-2020 20:27:06
 */

/* Include Files */
#include "endcut.h"
#include "mean.h"

/* Function Definitions */

/*
 * Arguments    : const double x_data[]
 *                const int x_size[1]
 * Return Type  : double
 */
double b_mean(const double x_data[], const int x_size[1])
{
  double y;
  int vlen;
  int k;
  vlen = x_size[0];
  if (x_size[0] == 0) {
    y = 0.0;
  } else {
    y = x_data[0];
    for (k = 2; k <= vlen; k++) {
      y += x_data[k - 1];
    }
  }

  y /= (double)x_size[0];
  return y;
}

/*
 * Arguments    : const double x[3200]
 * Return Type  : double
 */
double mean(const double x[3200])
{
  double y;
  int k;
  y = x[0];
  for (k = 0; k < 3199; k++) {
    y += x[k + 1];
  }

  y /= 3200.0;
  return y;
}

/*
 * File trailer for mean.c
 *
 * [EOF]
 */
