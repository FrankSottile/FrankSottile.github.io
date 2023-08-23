/*partitions.new.c
**
** Frank Sottile
** 25 March 1998
**
** The purpose of this file is to, for a given n,k, generate all
** parttions \lambda with first row of length (n-k) and first column   
** of length k, and then record their frequency by rank.  These are
** the essential partitions for n and k, that is, those represented 
** by a Grassmannian permutation in S_n but in no smaller symmetric group.
*/
#include <stdio.h>
#include <time.h>

main()
{
  int i,j, k, kp, n, np, rank;
  int frequency[26],  lambda[11];

  for (n=3; n<=10; ++n){

  printf("\nn=%d:\n",n);
  printf("  \\    ranks \n");
  printf(" k \\");
  for (i=n-1; i<=n*n/4; ++i)
    if(i<10) printf("  %d ",i);
    else printf(" %d ",i);
  printf("\n    \\");
  for (i=n-1; i<=n*n/4; ++i)
    printf("-----"); 
  printf("\n");

  /*k=5;*/  for(k=1; k<n; ++k){


    kp=k-1;
    np=n-2;
    
    /* Initialize frequency, lambda */
    
    for (i=0; i<= kp*(np-kp); ++i)
      frequency[i]=0;
    for (i=0; i<k; ++i)
      lambda[i]=i;
    
    /*  Compute rank lambda */
    rank=0;
    for (i=1; i<k; ++i)
      rank = rank+lambda[i]-i;
    
    frequency[rank]=frequency[rank]+1;

    /*
printf(" lambda = ");
for (i=1; i<=kp; ++i)
  printf("%d ",lambda[i]);
printf("  rank = %d\n",rank);
*/

    while (lambda[1]<=np-kp){
      
      i=kp;
      while (lambda[i]==np-kp+i)
	--i;
      ++lambda[i];
      while (i<= kp){
	++i;
	lambda[i]=lambda[i-1]+1;
      }
      
      /*  Compute rank lambda */
      rank=0;
      for (i=1; i<k; ++i)
	rank = rank+lambda[i]-i;
      
      frequency[rank]=frequency[rank]+1;

     }
  
    printf(" %d  |",k);
    if (k==1)   printf(" 1  \n");
    else {
      for (i=0; i<=kp*(np-kp); ++i)
      printf(" %d  ",frequency[i]);
    printf("\n");
    }  
  }
    printf("\n");
}
}
