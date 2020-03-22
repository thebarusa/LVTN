#include <stdio.h>
#include <math.h>
#include <conio.h>
#include <stdlib.h>

float mean (float *a, int la)
{
	float avr;
	int i;
	for(i=0; i<la; i++) 
	{
    avr += a[i];
  }
  avr /= (float)la;
  return avr;
}

void nhapmang(float a[], int *n)
{ printf("nhap so phan tu : " );
  scanf("%d",n);
  int i, k;
  for(i=0;i<*n;i++)
  { printf("phan tu thu %d : ",i);
    scanf("%f",&a[i]);
  }
}

int xuatmang(float a[],int n)
 {
 	int i;
  for(i=0;i<n;i++)
   {
     printf("%f \n",a[i]);
   }
 }
 
void gopmang(float *a, int *n, float *temp, int nTemp)
{
	int m = *n, k;
	*n += nTemp;
	for (k = (*n - nTemp); k < *n; k++)
	{
		a[k] = temp[k - m];
	}
}

void endcut (float y[], float x[], int n, float es, int lx, int *ly)
{
	float t1[10], t2[10], avr, e1, e;
	int i, ln, k, lt;
	
	*ly = 0;
	avr = mean(x, lx);
	for (i=0; i<lx; i++)  // x = x - mean(x)
	   x[i] -= avr;	   
  for (i=0; i<n; i++)   // t1 = x(1:n)
	   t1[i] = x[i];
  for (i=0; i<n; i++)   // t2 = t1.^2
	   t2[i] = pow(t1[i], 2);  	 
	e  = mean(t2, n);     // e = mean(t1.^2)
	i  = n + 1;
	ln = lx - n + 1;
	
	while (i <= ln)   
	{
		lt = 0;
		for (k=i-1; k<(i+n-1); k++)   // t = x(i:i+n-1) 
	     t1[lt++] = x[k];
	  
	  for (k=0; k<n; k++)           // t2 = t1.^2
	     t2[k] = pow(t1[k], 2); 
	  e1 = mean(t2, n);             // e1 = mean(t1.^2)
	  if (~((e1<es) | (fabsf(e1-e)<es)))
	  {	
	  	gopmang(y, ly, t1, n);     // y = [y;t] 	  	   
	  	*ly += n;	  	
		}
		i = i + n;
	}
}

int main()
{
	int la, lb, i;
	float a[10], b[10], avr;
	
	nhapmang(a, &la);
	
	avr = mean(a, la);
	printf("Gia tri mean: %f \n",avr);
	
	endcut (b, a, 2, 0.005, la, &lb);
	printf("Sau endcut \n");
	for(i=0; i<lb; i++)
	{
		printf("%f \n",b[i]);
	}
}
