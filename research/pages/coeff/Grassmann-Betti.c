/*Grassmann-Betti.c
**
** Frank Sottile
** 25 March 1998
**
** The purpose of this file is to, for a given n,k, generate all
** parttions \lambda with first row of length at most (n-k) and 
** first column of length at most k, and then record their frequency 
** by rank.  This generates the Betti numbers of the Grassmannian.
*/
#include <stdio.h>
#include <time.h>

main()
{
  int i,j, k, kp, n, np, rank;
  int frequency[30],  lambda[11];

  for (n=1; n<=9; ++n){


    printf("\nn=%d:\n",n);
    printf(" \\    ranks \n");
    printf("k \\");
    for (i=0; i<=n*n/4; ++i)
      if(i<10) printf("  %d ",i);
      else printf(" %d ",i);
    printf("\n   \\");
    for (i=0; i<=n*n/4; ++i)
      printf("----"); 
    printf("\n");
    printf(" 0 | 1  \n");
    
    for(k=1; k<=n; ++k){
      
      /* Initialize frequency, lambda */
      
      for (i=0; i<= k*(n-k); ++i)
	frequency[i]=0;
      for (i=0; i<=k; ++i)
	lambda[i]=i;
      
      /*  Compute rank lambda */
      rank=0;
      for (i=1; i<=k; ++i)
	rank = rank+lambda[i]-i;
      
      frequency[rank]=frequency[rank]+1;
      
      while (lambda[1]<=n-k){
	
	i=k;
	while (lambda[i]==n-k+i)
	  --i;
	++lambda[i];
	while (i<= k){
	  ++i;
	  lambda[i]=lambda[i-1]+1;
	}
	
	/*  Compute rank lambda */
	rank=0;
	for (i=1; i<=k; ++i)
	  rank = rank+lambda[i]-i;
	
	frequency[rank]=frequency[rank]+1;
	
      }
      
      printf(" %d |",k);
      
      for (i=0; i<=k*(n-k); ++i){
	if (frequency[i]>9)
	  printf("%d  ",frequency[i]);
	else
	  printf(" %d  ",frequency[i]);
      }
      printf("\n");
      
    }
    printf("\n");
  }
}

  
