<html>
<?php 
//////////////////////////////////////
//monotoneindivproblemview:  Frank's attempt to get the monotone conjecture data 
//                              displayed 
//
// Last Modification:  Abraham May 13, 2010
//////////////////////////////////////

 $DB = $_GET['DB'];	
 $result_id = $_GET['result_id'];

	//////////////////////////  Connect to DBase!!   ////////////////////////////
 $file_handle = fopen('phpconfig.php', "r");
 $line = '';
 while (!feof($file_handle)) {
	$line = fgets($file_handle);	
  if (preg_match('/\*\[hostname\]([^\[]+)/i',$line,$matches)) { 
		// found current hostname
  	$hostname = $matches[1];
 		preg_match('/\[username\]([^\[]+)/i',$line,$matches);
		$username = $matches[1];
		preg_match('/\[password\]([^\[]+)/i',$line,$matches);
		$password = $matches[1];
		break;
  }
 }
 fclose($file_handle);

 $dbh = mysql_connect($hostname,$username,$password);   // Connect to DBase
 //////////////////////////////////////////////////////////////////////////
	if (!mysql_select_db($DB)) {
			echo "Can't find database";
		}
 //////////////////////////////////////////////////////////////////////////////
 $query = sprintf ("SELECT Results.necklacetable, Results.request_id, "
	."Results.schubertproblem_id, "
	."Results.numinstances, Results.time_mhzseconds, "
	."SchubertProblems.problemname, SchubertProblems.numsolutions, "
	."SchubertProblems.schubertconditions, "
	."FlagVariety.flagvariety, FlagVariety.dimension, "
  ."Necklaces.necklaces, Necklaces.id, "
  ."Requests.necklace_id, Requests.id "
	."FROM Results JOIN SchubertProblems JOIN FlagVariety "
	."JOIN Necklaces JOIN Requests "
	."WHERE (Results.id='$result_id' "
  ."AND Requests.id = Results.request_id " //it should be Necklaces.id = Requests.necklace_id
	."AND Necklaces.id = Requests.necklace_id "
	."AND Results.schubertproblem_id=SchubertProblems.id "
	."AND FlagVariety.id = SchubertProblems.flagvariety_id) "
	."LIMIT 1"
 );

 $res = mysql_query($query, $dbh);
 if (!$res) {
	echo mysql_errno().": ". mysql_error ()."";
	return 0;
 }

 $thearray = mysql_fetch_array($res);
 extract ($thearray);
 // The extract( ) function automatically creates local variables from an array.

/////////////////  load libraries  ///////////////
 include("abraham.lib.php");
 include("table.class.inc.php");
	
///////////////////////////////////////////////////////////////
//       THE BEGINING OF THE CONSTRUCTION OF THE RESULTS TABLE
///////////////////////////////////////////////////////////////
//
 // extract the content of the necklace
 preg_match_all("/([^\[\]]+)/",$necklaces,$necklaceContent);
 $maxcross = sizeof($necklaceContent[0])-1;

$necklacearr=DisplayNecklace($problemname);
print_r($necklaceContent[0][1]);
print_r(printNecklace($necklaceContent[0][0],$necklacearr));

 // need to convert the list of triples r,n,i into an actual useful array
 //
 //  r = real solutions, n = necklace id,  i = instances
 //

 preg_match_all("/([-0-9]+),([-0-9]+),([-0-9]+)/",$necklacetable,$matches);  // get each table in page

 for ($q = 0; $q < count($matches[0]); $q++) {	// store the table in a PHP array	
//	$arr[$matches[1][$q]][$matches[2][$q]] = $matches[3][$q];	
	$arr[$matches[2][$q]][$matches[1][$q]] = $matches[3][$q];	
 }
 // $arr[n][r] where r are the real solutions: 0 2 4 etc, n are the necklaces

 //////   Start the table features  ////
	$atable = new html_table(array('border' => 1,'width' => '0%','cellpadding' => 5));
	$atable->alternate_color(0,'#DCFFFD');
	$atable->celldefault['width'] = 35;
	$atable->celldefault['align'] = 'right';
///////////

	$atable->new_row();
	$atable->new_cell('\\',array('align'=>'middle'));
	// create little space in the table between Necklaces and solutions
	$atable->new_cell(' ',array('width'=>'1px','bgcolor'=>'white','rowspan'=>'10000')); // better: count #rows

	# First row
	
 for ( $jj = $numsolutions % 2; $jj <= $numsolutions; $jj += 2) {
	$atable->new_cell($jj);
	$columntotal[$jj]=0; // initialize column totals
 }

///////// Sorting rows of the table  ////////////
//
$rworder = array();
$cntr = 0;
for($jj = $numsolutions; $jj >= $numsolutions % 2; $jj -= 2 ){ 
 for ($rw = 0; $rw <= $maxcross; $rw++){
 	 if(!$arr[$rw][$jj-2] and $arr[$rw][$jj]<>0){
			$rworder[$cntr] = $rw;
			$cntr ++;
	 }
  }
 }
//
//////////////////////////////////////////////////
// for($i = 0; $i < sizeof($rworder); $i++){
// 	$maxcolumn = $numsolutions - 2*(sizeof($arr[$i])-1);
// 	if(!$arr[$rworder[$i+1]][$maxcolumn-2] and 
// 	$arr[$rworder[$i+1]][$maxcolumn] < $arr[$rworder[$i]][$maxcolumn-){
// 		$temp[]=$i;
// 		$rworder[$i+1]
// 		}
// }

//$necklaceKey[1] = array_unique($necklacearr1[1]);
//print_r($necklaceKey[1]);
	// create little space between Solutions and Totals
	$atable->new_cell(' ',array('width'=>'1px','bgcolor'=>'white','rowspan'=>'10000'));
	$atable->new_cell('Total',array('align'=>'middle'));

   // create a little space between the title and the data
	$atable->new_row();
	$atable->new_cell(' ',array('height'=>'1px','bgcolor'=>'white','colspan'=>'10000'));
   
   // create one row for each necklace	
	for( $ii = 0; $ii <= $maxcross; $ii++) {
	   $atable->new_row();
//   	 $atable->new_cell('['.$necklaceContent[1][$rworder[$ii]].']');
		 $atable->new_cell(EchoArray(printNecklace($necklaceContent[1][$rworder[$ii]],$necklacearr)));
		 $rowtotal=0; // initialize row total
			# Fill each row.

		for( $jj = $numsolutions % 2; $jj <= $numsolutions; $jj += 2) {
			if(!$arr[$rworder[$ii]][$jj]){
				$atable->new_cell('&nbsp;');
			}else{
			   $atable->new_cell($arr[$rworder[$ii]][$jj] );
			}

			$rowtotal += $arr[$rworder[$ii]][$jj];
			$columntotal[$jj] += $arr[$rworder[$ii]][$jj];
		}
		
		$atable->new_cell($rowtotal);
		$totalbyrows+=$rowtotal;
	}
   
   // Create the final row with Totals	
	$atable->new_row();
	$atable->new_cell(' ',array('height'=>'1px','bgcolor'=>'white','colspan'=>'10000'));
	# Total row.
	$atable->new_row();
	$atable->new_cell('Total');
	for( $jj = $numsolutions % 2; $jj <= $numsolutions; $jj += 2) {
        $atable->new_cell($columntotal[$jj]);
        $totalbycolumns+=$columntotal[$jj];
	}
    
	### If $totalbycolumns==$totalbyrows, OK. Otherwise, freak out.
	if( $totalbycolumns==$totalbyrows ) {
        $atable->new_cell($totalbycolumns) ;
	} else {
        $atable->new_cell('Error, totals disagree') ;
	}
/////////   Table done   /////////////

 //////   Start the Key table  ////
	$keytable = new html_table(array('border' => 1,'width' => '0%','cellpadding' => 5));
	$keytable->alternate_color(0,'#DCFFFD');
	$keytable->celldefault['width'] = 35;

	$keytable->new_row();
	$keytable->new_cell(' ',array('bgcolor'=>'white'));
	$keytable->new_cell(' ',array('bgcolor'=>'white'));
	$keytable->new_cell('Key',array('align'=>'middle'));
	$keytable->new_row();
	$keytable->new_cell('Condition',array('bgcolor'=>'white'));
	$keytable->new_cell('Name',array('bgcolor'=>'white'));
	$keytable->new_cell('Symbol',array('bgcolor'=>'white'));
	$keytable->new_cell('Codimension',array('bgcolor'=>'white'));
	$keytable->new_row();
	$keytable->new_cell(' ',array('height'=>'1px','bgcolor'=>'white','colspan'=>'10000'));

	$necklaceKey = array_unique($necklacearr[1]);
//	print_r($necklaceKey);
	for($i=0; $i<sizeof($necklaceKey); $i++){
		$keytable->new_row();
		$keytable->new_cell($nom[1]);
	}
///////////

?>

<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<title>Enumerative Problem with 
<?php
 echo ''.$numsolutions.' solutions on '.FlvsGr($flagvariety,$dimension).'';
?>
</title>
</head>
<H1>
<?php
echo 'Enumerative Problem '.DisplayName_Image($problemname,1).' = '.$numsolutions.' on '.FlvsGr($flagvariety,$dimension).'';
?>
</H1>
<!--&nbsp;&nbsp;&nbsp;
<a href="http://www.math.tamu.edu/~secant/help.html">help/faq</a>-->
<HR COLOR=#0000FF size=2 noshade></HR>

<?php
//echo '<b>Database = '.$DB.'</b><br><br>';
echo '<a href="monotone.php?DB='.$DB.'">Problem View</a><br><br>';

//if($numfailures == 0){
//   echo '<br> Failures = '.$numfailures.'<br>';
//}else{
//   echo '<br> <a href="failure.php?DB='.$DB.'&requestid='.$request_id.'" >Failures</a> = '.$numfailures.'<br>';
//}
?>

<!--<br>
	<div align="left"><strong>
	    Schubert Problem Id:</strong>
<?php
echo $schubertproblem_id;
?>
<br>-->
<strong>Request Id:</strong>
<?php
echo $request_id;
?>
<!--<br>
<strong>Schubert Condition:</strong>
<?php 
echo $schubertconditions;
?>-->
<!--<br>
<strong>Number of points:</strong>
<?php
echo "$numpoints = ".join(' + ',split(',',$pointspartition));
?>
<br>-->
<?php
$stime = showtime($time_mhzseconds);
$time_per_instance_ghzseconds = number_format($time_mhzseconds / ($numinstances*1000), 3);
echo "\n<br>$numinstances instances in $stime[1] $stime[2] ($time_per_instance_ghzseconds GHz-seconds per instance)"
?>
<br>

<hr>
<strong>
Necklace \ Number of Solutions 
</strong>

<?php	
	$atable->show_table();
?>
<HR COLOR=#0000FF size=2 noshade></HR>
<?php
$keytable->show_table();
?>
</BODY>
</HTML>
