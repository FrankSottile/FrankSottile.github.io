#!/usr/bin/perl -w
##############################################################
# Perl code to compute solutions of the Schubert Problem
#
#			w333 w21 w1^4 = 6 in Gr(4,8)
#
#			(one flag at infinity)
#
# Began: 28 September 2010
#
# Nick Hein, 
#	Abraham Martin del Campo
# Frank Sottile 
#
#  The file first sets up a random number generator with a seed that should be 
# unique to this session.
#
#
#
################################################################

use 5.008006;
use strict;
use warnings;
use Benchmark;
my @numarr;
my $status;
my @lines;
my $pols;

my $prblmname = "G48_333_21_1^4.2c";
my $number_solutions = 6;
my $number_files = 500;
my $number_per_file = 200;

my $size = 500;
#
#
#  Set the random number generator to something squirrely 
#  involving the epoch and process ID
#
# Documentation: http://search.cpan.org/~fangly/Math-Random-MT-Perl-1.06/lib/Math/Random/MT/Perl.pm
#
use LIBS::MathRandomMTPerl;
#
my $date=time;
my $number = int(($date-1285950000)*($date-1285810420)/$$)+$$;
print "Seed for PID ", $$, " is ", $number, "  size of numbers is ",$size,"\n";
&Math::Random::MT::Perl::srand($number); 

#####################################################
#
#   Our Routines
#
sub drand {
  return int(&Math::Random::MT::Perl::rand($size))+1;
}
sub nrand {
  return int(&Math::Random::MT::Perl::rand(6*$size))-3*$size;
}

#########################################################
# Subroutine to choose equations with n flags real
#
#  Input:
#		number of real flags
#		number of complex conjugate pairs
#		a string with the name of the function in the library "Eqn.lib" to use
#	
#	Output:
#		A list of equations for the SchubertProblem
#
# Example:
#		get_equations(4,2,'G26_1')
# 
#  gives a list of equations for the problem
#  1^8 = 14 in G(2,6)
#	where 4 conditions are real flags, and 
#	the other are in 2 complex conjugate pairs
#

sub get_equations{
	my($numofreal, $numofcmp, $fnname) = @_;
	my @templist;
	for (my $a = 1; $a <= $numofreal; $a++){
		push(@templist, $fnname."(".nrand()."/".drand().")\n");
	}
	for (my $a = 1; $a <= $numofcmp; $a++){
		push(@templist, $fnname."_c(".nrand()."/".drand().",".nrand()."/".drand().")\n");
	}
	return @templist;
}

##########################################################################
#
#  Make sure temp directory exists
#
use Sys::Hostname; my $hn = hostname;	   # get computer host name
if( ! (-e "tempfiles" && -d "tempfiles")){
	mkdir("tempfiles")
	or die "Couldn't create the temp folder (tempfiles).";
}
if ( ! (-e "tempfiles/$hn"
            && -d "tempfiles/$hn") ) {
  mkdir("tempfiles/$hn")
    or die "Couldn't create temp directory (tempfiles/$hn).";
}
if ( ! (-e "tempfiles/$hn/$prblmname"
            && -d "tempfiles/$hn/$prblmname") ) {
  mkdir("tempfiles/$hn/$prblmname")
    or die "Couldn't create temp directory (tempfiles/$hn/$prblmname).";
}
if ( ! (-e "output/$prblmname"
            && -d "output/$prblmname") ) {
  mkdir("output/$prblmname")
    or die "Couldn't create temp directory (output/$prblmname).";
}

############################################################################
#
#  Set up filenames  
#  The filenames will include the process number
#
my $fileroot = "tempfiles/$hn/$prblmname/$$";
my $singularfile = "$fileroot.sing";
my $maplefile = "$fileroot.maple";
my $datafile = "$fileroot.data";
my $timefile = "$fileroot.time";
my $outputfile = sprintf("output/$prblmname/$$.output");

#
#  Set up the output file  This has two lines.  
#    One is the frequency vector and 
#    the other has the elapsed time of Singular computation.
#
open(OUTPUTFILE, ">", "$outputfile");
for (my $i=1; $i<= int($number_solutions/2); $i++)
{ 
 printf  OUTPUTFILE "0 ";
}
printf  OUTPUTFILE "0 \n0\n";
close(OUTPUTFILE);

#
#  The outer loop
#
my $t0 = Benchmark -> new;
for (my $outer=1; $outer<=$number_files; $outer++)
{
  #  Initialize @freq
  my @freq=();
  for (my $i=0;  $i<= int($number_solutions/2); $i++){push(@freq,0)}
  ###########################################################################
  #
  #  Singular header
  #
  #  Note: we assume that the data will always be generic
  #
  open(SING, ">$singularfile");
  #
  printf SING  "LIB \"LIBS/Eqn.lib\";\n" or return -1;
  printf SING  "LIB \"linalg.lib\";\n";
  printf SING  "int T=timer;\n";
  #printf SING  "ring R = 32003, (a,b,c,d,e,f,g), dp;\n";
  printf SING  "ring R = 0, (a,b,c,d,e,f,g), dp;\n";
  printf SING  "ideal I;\n";
  printf SING  "poly P,Q;\n";
  printf SING  "link M=\":w %s\";\n", $maplefile;
  printf SING  "fprintf(M, \"interface(quiet=true):\");\n"; 
  printf SING  "fprintf(M, \"file:=fopen(\\\"%s\\\",WRITE):\");\n", $datafile;

  ########################################################################################
  for (my $i=1; $i<=$number_per_file; $i++){
    printf SING "I = \n";
    foreach $pols (get_equations(0,2,'G48_1_333inf')){
      printf SING " $pols+";
    }
    foreach $pols (get_equations(1,0,'G48_21_333inf')){
      printf SING " $pols+";
    }
    printf SING "0;\n";
    printf SING "I = std(I);\n";
    printf SING "P = univarpol(I,1);\n";
    printf SING "Q = gcd(P, diff(P, var(1))); \n";
    printf SING "if (deg(P)<>%d or Q<>1) {\n", $number_solutions;
    printf SING " I = \n";
    foreach $pols (get_equations(0,2,'G48_1_333inf')){
      printf SING " $pols+";
    }
    foreach $pols (get_equations(1,0,'G48_21_333inf')){
      printf SING " $pols+";
    }
    printf SING " 0;\n";
    printf SING " I = std(I);\n";
    printf SING " P = univarpol(I,1);\n";
    printf SING "}\n";
    printf SING "if (deg(P)==%d) {\n", $number_solutions;
    printf SING " short=0;\n";
    printf SING " fprintf(M, \"F:=%%s:\", P);\n"; 
    printf SING " fprintf(M, \"fprintf(file, \\\"%%d\\\\n\\\",nops(realroot(F))):\");\n"; 
    printf SING "}\n";
  }
  ########################################################################################
  printf SING  "fprintf(M, \"fclose(file):\");\n"; 
  printf SING  "fprintf(M, \"quit:\");\n"; 
  print  SING  "close(M);\n" or return -1;
  printf SING  "M=\":w %s\";\n", $timefile;
  printf SING  "fprintf(M, \"%%s\", timer-T);\n"; 
  print  SING  "close(M);\n" or return -1;
  print  SING  "quit;\n" or return -1;
  close(SING);
  ########################################################################################
  # 
  #  Now run the Singular and the maple file
  #
  $status = system("nice -n20 Singular -q < $singularfile");
  #$status = system("nice -n20 Singular --ticks-per-sec=1000  -q < $singularfile");

  if ( $status != 0 ) {
    # Singular run failed.
    # Put an error message and stop the computation.
    die "Singular run failed.";
  }
  $status = system("nice -n20 maple -q < $maplefile");
  #$status = system("nice -n20 /Library/Frameworks/Maple.framework/Versions/Current/bin/maple -q < $maplefile");
  if ( $status != 0 ) {
    # Maple run failed.
    # Put an error message and stop the computation.
    die "Maple run failed.";
  }
  ########################################################################################
  # 
  #  Read the data
  #
  open(DATAFILE, "<$datafile");
  @lines = <DATAFILE>;
  close DATAFILE;
  foreach my $l (@lines) {
    chomp($l);
    $freq[$l/2]++;
  }
  #
  #  Read the time
  #
  open(TIMEFILE, "<$timefile");
  @lines = <TIMEFILE>;
  close TIMEFILE;
  chomp($lines[0]);
  my $newtime=$lines[0];
  #
  #  Read output file to get results of previous computations
  #
  open(OUTPUTFILE, "<$outputfile");
  @lines = <OUTPUTFILE>;
  close(OUTPUTFILE);
  #
  # The first line of the output file has the frequency table
  #
  my $str = $lines[0];
  my @oldfreq=();
  #
  while ($str =~ m/([0-9]+)\s/g) {
    push(@oldfreq, $1);
  }
  #
  #  The second line stores the time
  #
  my $oldtime = $lines[1];
  #
  #  Now we update the outputfile
  #
  open(OUTPUTFILE, ">$outputfile");
  #
  #   Possible bug if odd number of solutions
  #
  for (my $i=0; $i<=int($number_solutions/2); $i++){
    printf OUTPUTFILE "%d ", $oldfreq[$i]+$freq[$i];
  }
  printf OUTPUTFILE "\n%d", $oldtime+$newtime;
  close(OUTPUTFILE);
  # 
  #  Clean up the mess
  #
  unlink($singularfile);
  unlink($maplefile);
  unlink($datafile);
  unlink($timefile);
  # system("rm -rf tempfiles/$hn/$prblmname/");
}
my $t1 = Benchmark->new;
my $td = timediff($t1, $t0);
#print "the code took:",timestr($td),"\n";



