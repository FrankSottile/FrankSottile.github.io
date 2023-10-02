<?php
//		Abraham Martin del Campo
//		January 21, 2008
//		abraham.lib.php
//
//    Last Update:
//       May 7, 2010
//
////////////////////////////////////////////////////
//  	PHP file with functions needed and used
//		in the php codes for the experimental
//		project "Frontiers of Reallity in Schubert Calculus" (FRSC)
////////////////////////////////////////////////////

/////// Functions:	///////////
//
//	CompletePerm
//	EchoArray
//	EchoArrayMinus
//	CountNotA
//	Inversions
//	FlvsGr
//	DisplayName
//	DisplayName_Image
//	showtime
//	DisplayNecklace

//////////////////////////////////////////////////////
//
//                        CompletePerm      
//
////////////////  Function to Complete a given Permutation //////////////////////////
// input: 	$perm = array
//			$numb = number that the array will be completed to
// example:
// 		want to complete permutation 1 3 to be 1 3 2 4 5 6
//		let $p = array(1, 3); and we just have to type
//				CompletePerm($p, 6);
//
function CompletePerm($permut, $numb)
{
  $length = sizeof($permut); 
	$newp=0;
	$arr=array();
	for($i=0;$i<=$numb-1;$i++){
		$arr[$i]=0;
	}
	for($i=0;$i<=$length-1;$i++){
		$arr[$permut[$i]-1]=1;
	}
	for($i=0;$i<=$numb-1;$i++){
		if($arr[$i]==0){
			$newp++;
			$c = $length + $newp;
			$permut[$c-1]=$i+1;
		}
	}
	return $permut;
}
////////////// test of the function... aaaand....  It Works!!!  /////////////
//$p=array(1,3);
//$prueb="";
//$pch=CompletePerm($p, 6);
//for($i=0;$i<=6-1;$i++){
//$prueb .= $pch[$i];
//}
//echo $prueb;

///////////////////////////////////////////////////////////////////////////////
//
//						EchoArray
//
///////////////////  Function to Display an Array  ///////////////////////////
// input the array you want to display and the number of last elements you want to suppress
//
function EchoArray($arr)
{
 $str="";  //define an empty string
 for($i=0; $i< sizeof($arr); $i++){
 	$str .= $arr[$i]; // this step concatenate the elements of the array
 }
 return $str;
}
///////////////////////////////////////////////////////
//
//						EchoArrayMinus
//
////////////  Function to Display an Array truncated at the end  ///////////////////////////
// input the array you want to display and the number of last elements you want to suppress
function EchoArrayMinus($arr, $num)
{
 $str="";  //define an empty string
 for($i=0; $i< sizeof($arr)-$num; $i++){
	$str .= $arr[$i]; // this step concatenate the elements of the array
 }
 return $str;
}
////////////////////////////////////////////////
//
//						CountNotA
//
////////////////////////////////////////////////
//
////// Function to count the number of flags not starting with A ////////////////
//
//   In this function you have to input an array whith the letters that are in the array,
//   For example, if your problem is A214A215XX2Y.3  then, using regular expresions we can create
//	 an array $namearray that is of the form $namearray= (A, A, X, X, Y)
////////////////////////////////////////////////////////////////////////////////
function CountNotA($namearray)
{
 $counter=0;
 for($i=0; $i< sizeof($namearray); $i++){
 	if($namearray[$i] != 'A'){
		$counter++;
	}
 }
 return $counter;
}
//////////////////////////////////////////////
//
//				Inversions
//
/////////////////////////////////////////////
//	Function that counts the number of inversions of 
//	a given permutations
/////////////////////////////////////////////
function Inversions($permut){
 $counter=0;
 for($j=0; $j<= sizeof($permut)-2;$j++){
 	for($k=$j+1; $k<= sizeof($permut)-1;$k++){
  	if($permut[$k] < $permut[$j]){
    	$counter++;
    }
  }
 }
 return $counter;
}

////////////////////////////////////////////////////
//
//       FlvsGr
//
/////////////   This decides if the flag variety is a grassmanian or not    //////////
//
//    You have to enter the Flagvariety and the dimension, and this function will return
//      the string:  Fl($flag ; $dim)     or   Gr($flag; $dim)
//      e.g, if in the data base we have $flag = 1,2 and $dim = 4
//      then FlvsGr($flag, $dim)  will return the string
//                  Fl(1,2;4)
//        If in the databse we have $flag = 2 and $dim = 4
//        then FlvsGr() will return the string
//                  Gr(2;4)
////////////////////////////////////////////////////////////////

function FlvsGr($flag, $dim){
 if( substr_count($flag,',') ) {  
 // substr_count counts the number of times a comma appears in $flag
 	$flagvarietyname = "Fl($flag;$dim)" ;
 } else {
  $flagvarietyname = "Gr($flag;$dim)" ;
 }
 return $flagvarietyname;
}

///////////////////////////////////////////////////////////////
//
//			DisplayName
//
///////////// function that display the Schubert problem name in a colored way  ///////////
//
//	This function takes the problemfilename and returns the problem name displayed with colors
//	and with exponents and indexes in their right place.
//
////////////////   NOTE ////////////////
// THIS IS THE VERSION WITHOUT THE YOUNG TABLEU IMAGES, (the version with the tableu is
//   "DisplayName_Image" below)
/////////////////////////////////////////////////////////////
function DisplayName($problemname)
{
 $nname;	

///////////////////////////////////////////////////////////////////////////////
//  $color is an array, the same as $colr but instead of the name of the color, it has as
//  values the html code for those colors
//////
 $color = array(
 	"W" => "#6600aa", 
	"X" => "#0000ff", 
	"Y" => "#00aa00", 
	"Z" => "#ff0000", 
	"U" => "#FF6600", 
	"V" => "#AAAA00", 
	"A" => "#000000");
///////////////////////////////////////////////////////////////////////////////
//  $colr is an array indexed by the letters { W, X, Y, Z, U, V, A} and that has as 
// values the name of a color for each of these letters, for instance, we are assigning  
// the letter X to be blue, so our array has the name blue indexed by X    
/////
 $colr = array(
	"W" => "purple", 
	"X" => "blue", 
	"Y" => "green", 
	"Z" => "red", 
	"U" => "orange", 
	"V" => "yellow");
	preg_match_all("/([A-Z])([0-9]*)(\^([0-9]+))?/", $problemname,$nom);

/////////  the following chain of if-loops are for setting as many subindeces as needed for the display in the image.
 for($i=0; $i<sizeof($nom{1});$i++){
 	if($nom{1}{$i}!= "A"){
		if(!$nom{2}{$i}){
			$nom{2}{$i}=1;
		}
		$nname[$i] = '<font color='.$color{$nom{1}{$i}}.'><b>('.$nom{1}{$i}.'<SUB>'.$nom{2}{$i}.'</SUB>)<SUP>'.$nom{4}{$i}.'</SUP></b></font>';
	}
	else{
		$nname[$i] = '<font><b>('.$nom{1}{$i}.'<SUB>'.$nom{2}{$i}.'</SUB>)<SUP>'.$nom{4}{$i}.'</SUP></b></font>';
	}
 }
 $nicename = EchoArray($nname);
 return $nicename;
}

///////////////////////////////////////////////////////////////////
//
//       DisplayName_Image
//
/////////////////  function to display the Schubert problem name with
/////////////////           colors and images          ///////////////////
//
//    This function takes the problem file name, and returns the problem name
//    displayed with letters in colors and images of the Young Tableu diagram
//    
//      You have to enter a size for display, either 1 = Small
//                                                   2 = Big
//
// NOTE:    To be able to see the tableu images, you need to copy the folder /Tableu
//          in the same directory where the php files are.
//////////////////////////////////////////////////////////////////////

function DisplayName_Image($problemname, $number)
{
 $nname;  // empty variable that will store the name as a string
 $size;   // empty variable that will store a string with the size
 $scale;
 if ($number == 1){
 	$size = "Small";
 }
 if ($number == 2){
 	$size = "Big";  
 }

///////////////////////////////////////////////////////////////////////////////
//  $colr is an array indexed by the letters { W, X, Y, Z, U, V, A} and that has as 
//  values the name of a color for each of these letters, for instance, we are assigning  
//  the letter X to be blue, so our array has the name blue indexed by X    
/////
 $colr = array(
	"W" => "purple", 
	"X" => "blue", 
	"Y" => "green", 
	"Z" => "red", 
	"U" => "orange", 
	"V" => "yellow");
   
///////////////////////////////////////////////////////////////////////////////
//  $color is an array, the same as $colr but instead of the name of the color, it has as
//  values the html code for those colors
//////
 $color = array(
	"W" => "#6600aa", 
	"X" => "#0000ff", 
	"Y" => "#00aa00", 
	"Z" => "#ff0000", 
	"U" => "#FF6600", 
	"V" => "#AAAA00", 
	"A" => "#000000");
   
 preg_match_all("/([A-Z])([0-9]*)(\^([0-9]+))?/", $problemname,$nom);  // regular expression that collects the letters, the partitions, and the exponents in the problem name.

 for($i=0; $i<sizeof($nom{1});$i++){
 	if($nom{1}{$i}!= "A"){
  	if(!$nom{2}{$i}){
    	$nom{2}{$i}=1;
    }
         
/////////  the following chain of if-loops are for setting as many subindeces as needed for the display in the image.
          
    if($nom{2}{$i}>100){
    	$nname[$i] = '<font color='.$color{$nom{1}{$i}}.'><b>('.$nom{1}{$i}.'<SUB><SUB><SUB><IMG SRC="Tableau/'.$nom{2}{$i}.'.'.$colr{$nom{1}{$i}}.'.'.$size.'.gif"></SUB></SUB></SUB>)<SUP>'.$nom{4}{$i}.'</SUP></b></font>';
    }
    else{
    	if($nom{2}{$i}>10){
      	$nname[$i] = '<font color='.$color{$nom{1}{$i}}.'><b>('.$nom{1}{$i}.'<SUB><SUB><IMG SRC="Tableau/'.$nom{2}{$i}.'.'.$colr{$nom{1}{$i}}.'.'.$size.'.gif"></SUB></SUB>)<SUP>'.$nom{4}{$i}.'</SUP></b></font>';
      }
      else{
      	$nname[$i] = '<font color='.$color{$nom{1}{$i}}.'><b>('.$nom{1}{$i}.'<SUB><IMG SRC="Tableau/'.$nom{2}{$i}.'.'.$colr{$nom{1}{$i}}.'.'.$size.'.gif"></SUB>)<SUP>'.$nom{4}{$i}.'</SUP></b></font>';
      }
    }
  }
  else{
  	$nname[$i] = '<font><b>('.$nom{1}{$i}.'<SUB>'.$nom{2}{$i}.'</SUB>)<SUP>'.$nom{4}{$i}.'</SUP></b></font>';
  }
 }
 $nicename = EchoArray($nname);
 return $nicename;
}
//////////////////////////////////////////////////
//
//       showtime
//
//////////////////////////////////////////////////
// Function that displays time in terms of
// secs, mins, hrs, days...
//////////////////////////////////////////////////
function showtime($number){
 $timearray;
 $timed=$number/1000;
 $timearray[2] = 'GHz-secs.';

 if($timed>100){
 	$timed = ($number)/60000;
  $timearray[2] = 'GHz-mins.';
  if($timed>100){
  	$timed = ($number)/3600000;
    $timearray[2] = 'GHz-hrs.';
    if($timed>30){
    	$timed = ($number)/86400000;
      $timearray[2] = 'GHz-days.';
		  if($timed>400){
		  	$timed = ($number)/31536000000;
		    $timearray[2] = 'GHz-years.';
		  }
    }
  }
 }
 $timearray[1] = number_format($timed,3);
 return $timearray;
}
////////////////////////////
//
//		DisplayNecklace
//
////////////////////////////
//	Function that creates an array of colored letters
//	that represents the points of conditions of a Schubert pblm.
//	
//  Example:
//  For the Schubert Problem A2135^3 X^2 Y^2 creates the array:
//  A,A,A,a,a,b,b     with A in black, a in blue, b in green.
///////////////////////////
function DisplayNecklace($problemname){	
	preg_match_all("/([A-Z])([0-9]*)(\^([0-9]+))?/", $problemname,$nom);
	$necklacearr = array();
	$condarr = range('a','h');
	$condarrmix = range('A', 'E');
	$countA=0;
	$countcond = 0;
 for($i=0; $i< sizeof($nom[1]); $i++){
	if($nom[4][$i]>0){
		$temp = $nom[4][$i];
	}else{ $temp = 1; }
 	if($nom[1][$i]!="A"){
		while($temp > 0){
			$necklacearr[1][] = $condarr[$countcond];
			$necklacearr[2][] = $nom[1][$i];				
			$temp = $temp-1;
		}
		$countcond = $countcond+1;
	}else{
		while($temp > 0){
			$necklacearr[1][] = $condarrmix[$countA];
			$necklacearr[2][] = $nom[1][$i];				
			$temp = $temp-1;
		}
		$countA = $countA+1;
	}
 }
return $necklacearr;
}

//////////////////
//	printNecklace
//////////////////
//

function printNecklace($permutation,$necklc){
	$printneck;
	$color = array(
		"W" => "#6600aa", 
		"X" => "#0000ff", 
		"Y" => "#00aa00", 
		"Z" => "#ff0000", 
		"U" => "#FF6600", 
		"V" => "#AAAA00", 
		"A" => "#000000");
	for($i=0; $i < sizeof($necklc[1]); $i++){
		$printneck[$i] ='<font color='.$color[$necklc[2][$permutation[2*$i]-1]].'><b>'.$necklc[1][$permutation[2*$i]-1].'</b></font>';
	}
	return $printneck;
}
//////////////////
function array_sort($array, $key)
{
   for ($i = 0; $i < sizeof($array); $i++) {
        $sort_values[$i] = $array[$i][$key];
   }
   asort ($sort_values);
   reset ($sort_values);
   while (list ($arr_key, $arr_val) = each ($sort_values)) {
          $sorted_arr[] = $array[$arr_key];
   }
   return $sorted_arr;
}
//--END--
?>