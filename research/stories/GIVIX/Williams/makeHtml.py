# mkHtml.py
# 
# Started 26 July 2018
#
# The purpose of this is to read Raw_Data.txt
#  and then arrange its output into a .html page to
#  display the data of the experiment that Robert
#  Williams carried out in 2014
#################################################################################
#
#  First, we will read in all the data and make a big dictionary whose keys
#   will be the Schubert problems (in Robert's Format), and the entry for a 
#   given Schubert problem will be a dictionary whose keys are computed cycle
#   types and entries are the frequency
#
import re
import procedures
#
#  This is a regular expression to find lines that start with a digit 0-9
#
dbegin = re.compile('\d')
delim  = re.compile(' \| ')
cbegin = re.compile('-')

AllProblems = {}
freq = {}

#
with open('Raw_data.txt','r') as problems:
  for line in problems:
    comment = cbegin.match(line)
    if not comment:
      if line.startswith('['):
        SchubertProblem = line.rstrip()
        #    rstrip() removes end-of-line character
        freq = {}
      m = dbegin.match(line)
      if m:
        pair = delim.split(line.rstrip())
        freq[pair[0]] = int(pair[1])
      #################################################################################
      AllProblems[SchubertProblem] = freq
#  There is a problem with the Schubert problems with 10 solutions; sometimes the identity was not observed!
for K in AllProblems.keys():
  if procedures.numSols(K) == 10 and len(AllProblems[K].keys()) < 32:
    AllProblems[K]['1,1,1,1,1,1,1,1,1,1'] = 0

#################################################################################
#
#  Dictionary created:
#
#for K in AllProblems.keys():
#  print(K,AllProblems[K])
#  print(procedures.numSols(K), procedures.listOfPartitions(K),procedures.listOfConditions(K))
#
# These next lines are to generate a list of all paritions that will be needed for the .html page
#
#Parts = set()
#for K in AllProblems.keys():
#  for part in procedures.listOfPartitions(K):
#    Parts = Parts.union({part})
#
#print(Parts)
#quit()
#################################################################################
#
#  This will sort the problems by the observed cycles
#
#
#  This dictionary will be indexed by the observed cycles in Robert's calculation.
#    Each entry is a list of keys of Schubert problems with that Galois group
# 
GalGroup = {}
numberCycles = {}

Cycles = set()
for K in AllProblems.keys():
  cycles = ''
  for thing in AllProblems[K].keys():
    cycles = cycles+f'({thing}),'
  cycles = cycles[:-1]
  Cycles = Cycles.union({cycles})
  numberCycles[cycles] = [len(AllProblems[K].keys()),AllProblems[K].keys()]
  if cycles in GalGroup:
    GalGroup[cycles].append(K)
  else:
    GalGroup[cycles] = [K]

#################################################################################    
#
#  Open a .html file for writing.
#
htmlF = open('Frobenius_Raw.html', 'w')

htmlF.writelines(procedures.header())

#
#  loops over the different Galois groups
#
for cycles in sorted(Cycles):
  print(len(GalGroup[cycles]),numberCycles[cycles][0])
  
  htmlF.write('<table border=1>\n')
  htmlF.write(f' <tr><th colspan={1+numberCycles[cycles][0]} align=left>These have the same Galois group</th></tr>\n')
  htmlF.write(' <tr><td>Schubert Problem</td>')
  for cc in numberCycles[cycles][1]:
    htmlF.write(f'  <td>({cc})</td>')
  htmlF.write('</tr>\n')

  counter = 0
  for SchubertProblem in GalGroup[cycles]:
    if counter == 0:
      counter = 1
      htmlF.write(' <tr valign=center bgcolor="#DCFFFD"><td>&nbsp;')
    else:
      counter = 0 
      htmlF.write(' <tr valign=center><td>&nbsp;')

    L1 = procedures.isFibred1(SchubertProblem)  # 2 = 1^4     in G(2,4)
    L2 = procedures.isFibred2(SchubertProblem)  # 3 = 2*1^4   in G(2,5)
    L3 = procedures.isFibred3(SchubertProblem)  # 2 = 21*1^3  in G{2,5)
    if not L1==0:
      #  These are problems that are fibred over [2,4]^4=2 in a G(2,4)
      for condition in procedures.listOfConditions(SchubertProblem):
        part = procedures.seqToPartition(condition,9)
        if condition[0]==2 and condition[1] > 4:     # This detects the row complement of [2,4]
          htmlF.write(f'<img src="tableaux/{part}_r.gif">&nbsp;')
        elif condition[0] > 2 and condition[2]==7:     # Detects column complement of [2,4]
          htmlF.write(f'<img src="tableaux/{part}_c.gif">&nbsp;')
        else:
            htmlF.write(f'<img src="tableaux/{part}.gif">&nbsp;')
    elif not L2==0:
      #  These are problems that are fibred over [2,5]*[3,5]^4=3 in a G(2,5)
      for condition in procedures.listOfConditions(SchubertProblem):
        part = procedures.seqToPartition(condition,9)
        if  (condition[0]==2 or condition[0]==3) and condition[1] > 4:     # This detects the row complement of [3,5] or of [2,5]
          htmlF.write(f'<img src="tableaux/{part}_r.gif">&nbsp;')
        elif condition[0] > 2 and condition[2]==7:     # Detects column complement of [3,5]
          htmlF.write(f'<img src="tableaux/{part}_c.gif">&nbsp;')
        else:
            htmlF.write(f'<img src="tableaux/{part}.gif">&nbsp;')
    elif not L3==0:
      #  These are problems that are fibred over [2,4]*[3,5]^3=2 in a G(2,5)
      for condition in procedures.listOfConditions(SchubertProblem):
        part = procedures.seqToPartition(condition,9)
        if  condition[0]==2 and condition[1]==4:     # This detects the two-row complement of [2,4]
          htmlF.write(f'<img src="tableaux/{part}_rr.gif">&nbsp;')
        elif condition[0] > 2 and condition[2]==7:     # Detects column complement of [3,5]
          htmlF.write(f'<img src="tableaux/{part}_c.gif">&nbsp;')
        else:
            htmlF.write(f'<img src="tableaux/{part}.gif">&nbsp;')
    elif L1==0 and L2==0 and L3==0:
      for condition in procedures.listOfConditions(SchubertProblem):
        part = procedures.seqToPartition(condition,9)
        htmlF.write(f'<img src="tableaux/{part}.gif">&nbsp;')

        
    htmlF.write('</td>')
    freq = AllProblems[SchubertProblem]
    for cc in numberCycles[cycles][1]:
      htmlF.write(f'  <td align=right>{freq[cc]}</td>')
  
    htmlF.write('</tr>\n')
  #  htmlF.write('')

  htmlF.write('</table>\n')

  
htmlF.write('\n</body>\n\n</html>')
htmlF.close()

