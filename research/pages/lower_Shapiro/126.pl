#!/usr/bin/perl -w

my $tagBegin = "<td align=right>";
my $tagEnd   = "</td>";
my $space = "&nbsp;";

 my $SchubertProblem = "G48_2^8.txt";

 open(DATA, "<",  "G48_2^8.txt");
 my @l = <DATA>;
 close(DATA);
 #
 # The first line of the output file has the frequency table
 #
for (my $i=0; $i<=4; $i++){
 my $type = sprintf "%dr%dc", 8-2*$i,$i;
 my $str = $l[2*$i+1];
#print $str;

 my @rawfreq=();
 my $sum=0;
 while ($str =~ m/([0-9]+)\s/g) {
   push(@rawfreq, $1);
   $sum=$sum+$1;
 }
 #
 printf " We computed %d instances of the Schubert problem %s of type %s \n",$sum,$SchubertProblem,$type;

 $row=sprintf("\nG48_2^8\n\n <tr>\n <!-- %s.%s  %s -->", $SchubertProblem, $type, $str );
 my $nrow="0 ";
#
#   This is slightly fishy........  initializing freq = (0) !
#
 my @freq=(0);
 for (my $j=0; $j<=62; $j++){
  push(@freq,$rawfreq[2*$j+1]);
  if ($j==6*int($j/6)){
#   $nrow = sprintf("%s\n   ",$nrow);  
  }
#   $nrow = sprintf("%s%s%d%s",$nrow, $tagBegin,2*$j,$tagEnd); 
   $nrow = sprintf("%s%d ",$nrow, $rawfreq[2*$j+1]);  
 }

print $nrow, "\n"; #die;

 for (my $ii=0; $ii<=$#freq-1; $ii++) {
  if ($ii==6*int($ii/6)) { 
   $row = sprintf("%s\n   ",$row);  
  }
  if ($freq[$ii]==0){ 
   $row = sprintf("%s%s%s%s",$row, $tagBegin,$space,$tagEnd);
  } else {
   $row = sprintf("%s%s%d%s",$row, $tagBegin,$freq[$ii],$tagEnd);
  }

 }
 print $row,"\n </tr>\n";
#die;

}
die;
