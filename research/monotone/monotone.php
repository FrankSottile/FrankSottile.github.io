<html>
<!---  monotone.php:   This is Frank's attempt to get a php that will display monotone secant -->
<!--                   conjecture pages -->
<?php 	
 $DB = $_GET['DB']; 
 // This will retrieve the DataBase
 if(!$DB){
	$DB = secantTesting;  //set secantTesting as default DB
 }
 //////////////////////////////////////////////////////
 // Configuration to connect to the Database is stored
 // in the file phpconfig.php
 //////////////////////////////////////////////////////
 $file_handle = fopen('phpconfig.php', "r");
 $line = '';
 while(!feof($file_handle)){
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
 // Connect to DBase
 $dbh = mysql_connect($hostname,$username,$password);

 ///////////////////////////////////////////////////////
 //   	This is for listing all DataBases
 ///////////////////////////////////////////////////////
 //    $DBS = mysql_list_dbs($dbh);
 //    $dbstring = "";
 //	   while ($dba = mysql_fetch_object($DBS))
 //  	{
 //        if( $dba->Database == $DB ) {
 //            // the currently displayed database:
 //            // show and highlight the name, but don't link
 //            $dbstring .= '--- <i>'.$dba->Database.'</i> ---<br />';
 //        } else {
 //            // another database: show and link it
 //            $dburl = 'problemview.php?DB='.$dba->Database;
 //            $dbstring .= '<a href="'.$dburl.'">'.$dba->Database.'</a><br />';
 //        }
 //  	}

 if(!mysql_select_db($DB)) {
	echo "Can't find database";
 }
 /////////////////////////////////////////////////////////////	
 ///  
 $query = sprintf(
	"SELECT SchubertProblems.problemname, SchubertProblems.numsolutions, "
	."FlagVariety.flagvariety, FlagVariety.dimension, "
	."Results.id AS result_id, Requests.computationtype_id,"
	."Results.necklacetable, Results.time_mhzseconds, "
	."Results.numinstances, "
	."Results.packetssubmitted, Requests.id,"
	."Requests.packetnumber, Requests.totalnumpackets, "
  ."Requests.computationlength_id, Requests.necklace_id "
	."FROM Results RIGHT JOIN (Requests JOIN SchubertProblems JOIN FlagVariety) "
	."ON (Results.request_id = Requests.id) "
	."WHERE (Requests.schubertproblem_id = SchubertProblems.id "
	."and SchubertProblems.flagvariety_id = FlagVariety.id) "
	."ORDER BY numsolutions, problemname;");
	          
 ///
 $res = mysql_query($query, $dbh);

 if (!$res) {
	echo mysql_errno().": ". mysql_error ()."";
	return 0;
 }

 /////////////////  load libraries  ///////////////
 include("abraham.lib.php"); 
 include("table.class.inc.php");

///////////////////////////////////////////////////////////////
//       THE BEGINING OF THE CONSTRUCTION OF THE PROBLEMS TABLE
//////////////////////////////////////////////////////////
//

//////   Start the table features  ////
 $atable = new html_table(array('border' => 1, 'cellpadding'=>2));
 $atable->alternate_color(0,'#DCFFFD');
// $atable->celldefault['width'] = 100;
////////////////////////////////////////////////////////////

 $atable->new_row();
 $atable->new_cell('Results');
 $atable->new_cell('Req. Id');
 $atable->new_cell('Problem');
 $atable->new_cell('Flag variety');
 $atable->new_cell('Comput.<br>Type');	
 $atable->new_cell('Comp.<br>Length');
 $atable->new_cell('Packets <br>running');
 $atable->new_cell('Packets <br>completed');
 $atable->new_cell('Actual <br>instance');
 $atable->new_cell('Comput. time');
 $atable->new_cell('Seconds <br>per instance');
 $atable->new_cell('Failures');
////////////////////////////////////////////

// initialization of counting variables to display totals
/////////////////////////////////
 $totaltime=0;
 $totalproblems=0;
 $totalinstances;
 $totalrunninginstances=0;
//////////////////////////////////
//
// $totaltime   will count the total amount of time of the whole computation
// $totalproblems   will count the amount of problems we computed (that are listed)
// $totalinstances   will count the total number of instances that have been computed so far.
// $totalrunninginstances   is the total number of instances that the db thinks are running
//
/////////////////////////////////
		
 while ($thearray = mysql_fetch_array($res)) {
	extract ($thearray);
	$atable->new_row();

	//  Create link to IndivProblemview //		
	$indivlink = '<a href="monotoneindivproblemview.php?DB='.$DB.'&result_id='.$result_id.'">Data</a>';
	$atable->new_cell($indivlink);
  $atable->new_cell($id);     		

	// Display the Problem using colors and images //
	// abraham.lib.php:  DisplayName_Image
	$atable->new_cell(
		DisplayName_Image($problemname,1).' = '.$numsolutions
	);

	// count the number of problems that are listed
  $totalproblems++;
  
	$atable->new_cell(FlvsGr($flagvariety,$dimension));
  $atable->new_cell($computationtype_id);
  $atable->new_cell($computationlength_id);
   //////// Packets Running ////////
  if(($packetnumber-$packetssubmitted) !=0){
		$atable->new_cell($packetnumber-$packetssubmitted);
    $totalrunninginstances += $packetnumber-$packetssubmitted;
	} else {
		$atable->new_cell('&nbsp;');
  }
	////////////////
	$atable->new_cell($packetssubmitted.'/'.$totalnumpackets);		
	$atable->new_cell('&nbsp;'.$numinstances.'');
	// count the number of total instances computed
  $totalinstances=$totalinstances + $numinstances;
	$stime= showtime($time_mhzseconds);
	
	// count the total time spent for the whole experiment
	$totaltime= $totaltime+$time_mhzseconds;
	$atable->new_cell($stime[1].' '.$stime[2].'');
	// if loop that will display the amount of time spent 
	//    in the problem, or blank space if there is no time spent
  if( $numinstances != 0 ) {
  	$atable->new_cell(number_format(($time_mhzseconds/$numinstances)/1000,3));
  } else {
		$atable->new_cell('&nbsp;');
	}
	////////////////////////////////////////////////////
	//   If there is a failure, it will create a link, if not
	//   it will only show a blank cell
	if($numfailures == 0){
		$linkfailure = '&nbsp;';
		$atable->new_cell($linkfailure);
	}else{
		$linkfailure = '<a href="failure.php?DB='.$DB.'&requestid='.$request_id.'" >'.$numfailures.'</a>';
		$atable->new_cell($linkfailure,array('bgcolor'=>'#FF0000'));
	}
 }
 // Last row: number of runninginstances
 $atable->new_row();
 $atable->new_cell('&nbsp;');
 $atable->new_cell('&nbsp;');
 $atable->new_cell('&nbsp;');
 $atable->new_cell('&nbsp;');
 $atable->new_cell('&nbsp;');
 $atable->new_cell('&nbsp;');
 $atable->new_cell("Tot.: $totalrunninginstances");
 $atable->new_cell('&nbsp;');
 $atable->new_cell('&nbsp;');
 $atable->new_cell('&nbsp;');
 $atable->new_cell('&nbsp;');
 $atable->new_cell('&nbsp;');
?>
<head>
 <meta http-equiv="content-type" content="text/html; charset=utf-8">
 <title>Monotone Experimental Project</title>
</head>
<H1>
 Monotone Experimental Project
</H1>
&nbsp;&nbsp;&nbsp;
<a href="http://www.math.tamu.edu/~secant/help.html">help/faq</a>
 <BODY>
 <div align="left"><font face="Verdana" size="2">Statistics:</font>
 <br>
 <?php
	//////// Display of totals  ////////
	$stringinstance=number_format($totalinstances);
	$stringtime=showtime($totaltime);
	$tottime=$stringtime[1];
	echo "<br>Computed $stringinstance Instances of $totalproblems Schubert Problems in $tottime $stringtime[2]";
	/////////////////////////////
  echo '<HR COLOR=#0000FF size=2 noshade></HR>';  // This just print a fancy blue line
	echo '<div align="left"><font face="Verdana" size="2">All Results:</font><br></br>';
	$atable->show_table();   // This is for displaying the table created above
 ?>
 <br>
 <strong><a href="http://www.math.tamu.edu/%7Easanchez/Calendar/february08.html" class="not-link">Team Calendar</a> </strong>
 <br>
 <strong><a href="http://www.math.tamu.edu/~secant" class="not-link">Project Webpage</a> </strong>
 <br />
 <strong><a href="http://frsc-wiki.wikidot.com/">Wiki</a></strong>
</BODY>
</HTML>
