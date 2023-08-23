/*  new_order.c
**  
**  Frank Sottile    1 January, 1998
**  
**  This file compiles the table of ranks of 
**  elements in the symmetric group in the universal k-Bruhat order.
**     
**  It steps through the symmetric group of order n, and for each
**  permutation pi, it computes |pi|, the rank of pi according to the 
**  formula at the beginning of section 3.2 in "Schubert Polynomials,..."
**
*/
#include <stdio.h>
#include <time.h>

main()
{
 int n, i, a, b, asc, temp, bigger, step, maxrank, rank;
 int pi[15], ranks[50];
 
 n=12;
 maxrank=n*n/4;
/*   Initialize the ranks array  */
  for (i=1; i<= maxrank +1; ++i)
     ranks[i]=0;

/*   Initialize the identity permutation  */
 for ( i=1; i <= n; ++i) 
   pi[i]=i;

/*   Looping through the symmetric group */
 asc=1;
 while(asc>0){

/*   Computes the rank +1 for the frequency array*/
  rank=1;
  for ( a=2; a<=n; ++a ){
    for ( b=1; b<a; ++b ){    
      if ( a<pi[a] ) {
        if ( b<pi[b] && pi[a]<pi[b]){
          rank = rank -1;
        }
        if ( b>pi[b]){
          rank = rank -1;
          if (pi[a]>pi[b]){
            rank = rank + 1;
	  }
        }
      }
      if ( a>pi[a] ) {
        if ( b<pi[b] && pi[a]<pi[b]){
          rank = rank +1;
        }
        if ( b>pi[b] && pi[a]<pi[b]){
          rank = rank -1;
        }
      }
    }
  }
  ranks[rank] = ranks[rank]+1;

/*   Increment the element of the symmetric group */
  asc = 0;
 
  for ( i = 1; i<n; ++i)
   if ( pi[i] < pi[i+1] )
     asc = i;

  if ( asc > 0 ) {
   temp = pi[asc];

   for ( i = asc+1; i <= n; ++i){
    if ( pi[i] > temp )
     bigger = i;
   }
   pi[asc]=pi[bigger];
   pi[bigger]=temp;
   for ( i=1; i <= (n-asc)/2; ++i){
    temp=pi[asc+i];
    pi[asc+i]=pi[n+1-i];
    pi[n+1-i]=temp;
   }
  }

  }

/*    Print clock time elapsed */
 printf("  n = %d,    elapsed time = %d\n",n ,clock());
  for ( i=1; i <= maxrank+1; ++i) 
  printf(" %d", ranks[i]);
  printf(" \n");
}

