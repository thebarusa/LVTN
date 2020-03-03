/*
 * File: main.c
 *
 * MATLAB Coder version            : 4.2
 * C/C++ source code generated on  : 15-Feb-2020 20:27:06
 */

/*************************************************************************/
/* This automatically generated example C main file shows how to call    */
/* entry-point functions that MATLAB Coder generated. You must customize */
/* this file for your application. Do not modify this file directly.     */
/* Instead, make a copy of this file, modify it, and integrate it into   */
/* your development environment.                                         */
/*                                                                       */
/* This file initializes entry-point function arguments to a default     */
/* size and value before calling the entry-point functions. It does      */
/* not store or use any values returned from the entry-point functions.  */
/* If necessary, it does pre-allocate memory for returned values.        */
/* You can use this file as a starting point for a main function that    */
/* you can deploy in your application.                                   */
/*                                                                       */
/* After you copy the file, and before you deploy it, you must make the  */
/* following changes:                                                    */
/* * For variable-size function arguments, change the example sizes to   */
/* the sizes that your application requires.                             */
/* * Change the example values of function arguments to the values that  */
/* your application requires.                                            */
/* * If the entry-point functions return values, store these values or   */
/* otherwise use them as required by your application.                   */
/*                                                                       */
/*************************************************************************/
/* Include Files */
#include "endcut.h"
#include "main.h"
#include "endcut_terminate.h"
#include "endcut_emxAPI.h"
#include "endcut_initialize.h"

/* Function Declarations */
static void argInit_3200x1_real_T(double result[3200]);
static double argInit_real_T(void);
static unsigned int argInit_uint32_T(void);
static void main_endcut(void);

/* Function Definitions */

/*
 * Arguments    : double result[3200]
 * Return Type  : void
 */
static void argInit_3200x1_real_T(double result[3200])
{
  int idx0;

  /* Loop over the array to initialize each element. */
  for (idx0 = 0; idx0 < 3200; idx0++) {
    /* Set the value of the array element.
       Change this value to the value that the application requires. */
    result[idx0] = argInit_real_T();
  }
}

/*
 * Arguments    : void
 * Return Type  : double
 */
static double argInit_real_T(void)
{
  return 0.0;
}

/*
 * Arguments    : void
 * Return Type  : unsigned int
 */
static unsigned int argInit_uint32_T(void)
{
  return 0U;
}

/*
 * Arguments    : void
 * Return Type  : void
 */
static void main_endcut(void)
{
  emxArray_real_T *y;
  double dv0[3200];
  emxInitArray_real_T(&y, 1);

  /* Initialize function 'endcut' input arguments. */
  /* Initialize function input argument 'x'. */
  /* Call the entry-point 'endcut'. */
  argInit_3200x1_real_T(dv0);
  endcut(dv0, argInit_uint32_T(), argInit_real_T(), y);
  emxDestroyArray_real_T(y);
}

/*
 * Arguments    : int argc
 *                const char * const argv[]
 * Return Type  : int
 */
int main(int argc, const char * const argv[])
{
  (void)argc;
  (void)argv;

  /* Initialize the application.
     You do not need to do this more than one time. */
  endcut_initialize();

  /* Invoke the entry-point functions.
     You can call entry-point functions multiple times. */
  main_endcut();

  /* Terminate the application.
     You do not need to do this more than one time. */
  endcut_terminate();
  return 0;
}

/*
 * File trailer for main.c
 *
 * [EOF]
 */
