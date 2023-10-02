#!/usr/bin/perl -w

my $tagBegin = "<td align=right>";
my $tagEnd   = "</td>";
my $space = "&nbsp;";

#
#   Get the outputs
#
system("ls Done/*.output > out.tmp");
open(OUTPUTS, "<", "out.tmp");
my @lines = <OUTPUTS>;
close OUTPUTS;
unlink("out.tmp");

#
#  read the output files to get the frequency data
#
foreach my $filename (@lines)
{
 chomp($filename);

print $filename, "\n";

 #
 #  Get the name of the Schubert problem
 #
 $filename =~ m/([GL][\^\w]+)\.([\w]+)/;
 my ($SchubertProblem,$type) = ($1,$2);

 open(DATA, "<", $filename);
 my @l = <DATA>;
 close(DATA);
 #
 # The first line of the output file has the frequency table
 #
 my $str = $l[0];
 my @freq=();
 my $sum=0;
 #
 while ($str =~ m/([0-9]+)\s/g) {
   push(@freq, $1);
   $sum=$sum+$1;
 }

 printf " We computed %d instances of the Schubert problem %s of type %s \n",$sum,$SchubertProblem,$type;
 $row=sprintf("\n%s\n\n <tr>\n <!-- %s.%s  %s -->",$filename, $SchubertProblem, $type, $str );
 for (my $i=0; $i<=$#freq; $i++) {
  if ($i==3*int($i/3)) { 
   $row = sprintf("%s\n   ",$row);  
  }
  if ($freq[$i]==0){ 
   $row = sprintf("%s%s%s%s",$row, $tagBegin,$space,$tagEnd);
  } else {
   $row = sprintf("%s%s%d%s",$row, $tagBegin,$freq[$i],$tagEnd);
  }

 }
 print $row,"\n </tr>\n";
}
