<HTML>
<HEAD>
<TITLE>On-line Registration</TITLE>
</HEAD>
<body bgcolor=#ccddda text=#000000  link=#0000ff alink=#ff0000 vlink=#000099>

<?

$Name=trim($Name);
$Position=trim($Position);
$University=trim($University);
$Email=trim($Email);
$Phone=trim($Phone);
$Fax=trim($Fax);
$Add1=trim($Add1);
$Add2=trim($Add2);
$Add3=trim($Add3);
$Add4=trim($Add4);
$Add5=trim($Add5);
$Add6=trim($Add6);
$Add7=trim($Add7);
$Dates=trim($Dates);
$WI=trim($WI);
$WII=trim($WII);
$WIII=trim($WIII);
$WIV=trim($WIV);
$Support=trim($Support);
$Comments=trim($Comments);

if ($Name == "") {
  echo ("Error - you didn't enter your name!  Click the \"Back\" button on your browser to correct your registration.");
  exit;
}

if ($Position == "") {
  echo ("Error - you didn't enter your position!  Click the \"Back\" button on your browser to correct your registration.");
  exit;
}

if ($University == "") {
  echo ("Error - you didn't enter your institution!  Click the \"Back\" button on your browser to correct your registration.");
  exit;
}

if ($Email == "") {
  echo ("Error - you didn't enter your email address!  Click the \"Back\" button on your browser to correct your registration.");
  exit;
}

if ($Add1 == "") {
  echo ("Error - you didn't enter your address!  Click the \"Back\" button on your browser to correct your registration.");
  exit;
}

if ($Add2 == "") {
  echo ("Error - Please enter your addresson more than one line!  Click the \"Back\" button on your browser to correct your registration.");
  exit;
}

if ($Dates == "") {
  echo ("Error - you didn't enter the dates of your visit to the Bernoulli centre!  Click the \"Back\" button on your browser to correct your registration.");
  exit;
}



if (!$file=fopen("./data.txt","a")) {
	echo ("Error - could not append to data file - notify sottile@math.tamu.edu");
	exit;
}

if (!flock($file,2)) {
	echo ("Error - cannot acquire lock - notify sottile@math.tamu.edu");
	exit;
}

fputs ($file,"--------------------------------------------------\n");
fputs ($file,"Data entered for $Name\n");
fputs ($file,"DName: $Name\n");
fputs ($file,"DPosition: $Position\n");
fputs ($file,"DUniversity: $University\n");
fputs ($file,"DEmail: $Email\n");
fputs ($file,"DPhone: $Phone\n");
fputs ($file,"DFax: $Fax\n");
fputs ($file,"DAddress1: $Add1\n");
fputs ($file,"DAddress2: $Add2\n");
fputs ($file,"DAddress3: $Add3\n");
fputs ($file,"DAddress4: $Add4\n");
fputs ($file,"DAddress5: $Add5\n");
fputs ($file,"DAddress6: $Add6\n");
fputs ($file,"DAddress7: $Add7\n");
fputs ($file,"DDates: $Dates \n");
fputs ($file,"DWI: $WI \n");
fputs ($file,"DWII: $WII\n");
fputs ($file,"DWIII: $WIII\n");
fputs ($file,"DWIV: $WIV\n");
fputs ($file,"DSupport: $Support\n");
fputs ($file,"DComments: $Comments\n");
$d=date("r"); fputs ($file,"dateofentry: $d\n");
fputs ($file,"--------------------------------------------------\n");
fclose($file);

if (!mail("sottile, itenberg@math.u-strasbg.fr, shapiro@math.su.se , kharlam@math.u-strasbg.fr, sabrina.martone@epfl.ch, talya.vanwoerden@epfl.ch, christiane.depaola@epfl.ch",
	  "Registration from $Name",
"Name:        $Name\n" .
"Position:    $Position\n" .
"Institution: $University\n" .
"Email:       $Email\n" .
"Telephone:   $Phone\n" .
"Fax:         $Fax\n" .
"Address:     $Add1\n" .
"             $Add2\n" .
"             $Add3\n" .
"             $Add4\n" .
"             $Add5\n" .
"             $Add6\n" .
"             $Add7\n" .
"Dates:       $Dates\n" .
"Workshops: \n" .
"January:     $WI\n" .
"March:       $WII\n" .
"April:       $WIII\n" .
"June:        $WIV\n\n" .
"Support Requested: $Support\n" .
"Comments: $Comments\n")) {
	echo ("Error - could not send email notification - notify sottile@math.tamu.edu");
}

echo "
<b>Thank you.  Your registration for the program<BR> \"Real and Tropical Algebraic Geometry\"
          at the Bernoulli Centre has been received. <BR>
If you have any questions, 
please contact us at: <br>
<br><br><font color=blue>
Viatcheslav Kharlamov   kharlam@math.u-strasbg.fr<br>
Illia Itenberg          itenberg@math.u-strasbg.fr <BR>
Boris Shapiro           shapiro@math.su.se <BR>
Frank Sottile           sottile@math.tamu.edu<br></font>
We look forward to seeing you in 2008.<br><br>
<br>
</b>";

echo "<table> ";
echo "<TR><Th align=left color=Red colspan=2>Summary of data entered.</th></tr>";
echo "<TR><th align=left> Name :</th> <td> $Name </td></tr>";
echo "<TR><th align=left> Position :</th> <td> $Position </td></tr>";
echo "<TR><th align=left> University : &nbsp;</th> <td>  $University </td></tr>";
echo "<TR><th align=left> Email :</th> <td>  $Email </td></tr>";
echo "<TR><th align=left>  Phone :</th> <td> $Phone </td></tr>";
echo "<TR><th align=left>  Fax :</th> <td> $Fax </td></tr>";
echo "<TR><th align=left>  Address :</th> <td> $Add1 </td></tr>";
echo " <TR> <TD></TD>    <TD>  $Add2 </td></tr>";
echo " <TR> <TD></TD>    <TD>  $Add3 </td></tr>";
echo " <TR> <TD></TD>    <TD>  $Add4 </td></tr>";
echo " <TR> <TD></TD>    <TD>  $Add5 </td></tr>";
echo " <TR> <TD></TD>    <TD>  $Add6 </td></tr>";
echo " <TR> <TD></TD>    <TD>  $Add7 </td></tr>";
echo " <TR> <Th>Dates: </Th><TD> $Dates </td></tr>";
echo " <TR> <th align=left colspan=2> Workshop attendance</th></tr>";
echo " <TR> <Th>21--26 January </th> <td> $WI </td></tr>";
echo " <TR> <Th>10--15 March </th> <td> $WII </td></tr>";
echo " <TR> <Th>21--26 April </th> <td> $WIII </td></tr>";
echo " <TR> <Th>16--21 June </th> <td> $WIV </td></tr>";
echo " <TR> <Th>Support Requested &nbsp;</th> <td> $Support </td></tr>";
echo " <TR valign=top> <Th>Comments</TH><TD width=700> $Comments </td></tr>";
echo "</table>";

?>
</BODY>
</HTML>

