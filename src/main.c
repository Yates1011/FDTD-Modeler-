#include <stdio.h>
#include <math.h>

#define SIZE 200

int main()
 {
    double ez[SIZE] = {0.}, hy[SIZE] = {0.}, imp0 = 377.0;
    int qTime, maxTime = 200, mm;
    /* base name set to "sim" but the user could be prompted to change this */
    char basename[80] = "sim", filename[100];
    int frame = 0;
    /* file pointer used for output files */
    FILE *snapshot;

     /* begin time stepping */
     for (qTime = 0; qTime < maxTime; qTime++) {

         hy[SIZE-1] = hy[SIZE-2]; // simple ABC, I think...
         /* update magnetic field */
         for (mm = 0; mm < SIZE - 1; mm++)
         hy[mm] = hy[mm] + (ez[mm + 1] - ez[mm]) / imp0;

         ez[0] = ez[1]; // simple ABC, I think... again...

         /* update electric field */
         for (mm = 1; mm < SIZE; mm++)
         ez[mm] = ez[mm] + (hy[mm] - hy[mm - 1]) * imp0;

         /* using an additive source at node 50 */
         ez[50] += exp(-(qTime - 30.) * (qTime - 30.) / 100.);

         /* create a snapshot if time-step is a multiple of 10*/
         if (qTime % 10 == 0)
         {
            /* create file name and increment counter */
            sprintf(filename, "%s.%d", basename, frame++);

            snapshot = fopen(filename,"w");

            /* write data to file*/
            for(mm = 0; mm < SIZE; mm++)
                fprintf(snapshot, "%g\n", ez[mm]);

            fclose(snapshot);
         }

     printf("%g\n", ez[50]);
 } /* end of time-stepping */

 return 0;
}
