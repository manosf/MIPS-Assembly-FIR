void fir(int X[], int H[], int Y[], int n, int m)
{
    int i, j;
    int y0;
    for (j=0; j<m; j++)
    {
      y0=0;
      for (i=0; i<n; i++)
        {
          y0+=X[i+j]*H[i];
        }
        Y[j]=y0;
    }
}
