#!/usr/bin/perl -w

#
#   Get the outputs
#
#
system("ls Data/*.output > out.tmp");
#system("ls Done/*.output > out.tmp");
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
 #
 #  Get the name of the Schubert problem
 #
 $filename =~ m/(G[\^\w]+)\.([\w]+)/;
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


}
