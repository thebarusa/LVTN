/*
 * File: power.c
 *
 * MATLAB Coder version            : 4.2
 * C/C++ source code generated on  : 15-Feb-2020 20:27:06
 */

/* Include Files */
#include "endcut.h"
#include "power.h"

/* Function Definitions */

/*
 * Arguments    : const double a_data[]
 *                const int a_size[1]
 *                double y_data[]
 *                int y_size[1]
 * Return Type  : void
 */
void power(const double a_data[], const int a_size[1], double y_data[], int
           y_size[1])
{
  int nx;
  int k;
  y_size[0] = (short)a_size[0];
  nx = (short)a_size[0];
  for (k = 0; k < nx; k++) {
    y_data[k] = a_data[k] * a_data[k];
  }
}

/*
 * File trailer for power.c
 *
 * [EOF]
 */
