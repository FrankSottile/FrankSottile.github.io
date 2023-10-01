# Simplify.py
# 
# 26 July 2018
#
# This read Robert's "Schubert_Stats.txt" and writes a simple ASCII table
#################################################################################

import re
#
#  This is a regular expression to find lines that start with a digit 0-9
#
dbegin = re.compile('\d')
cbegin = re.compile('-')
delim  = re.compile(' \| ')

freq = dict()
textF = open('Raw_data.txt', 'w')
with open('Schubert_Stats.txt','r') as problems:
  for line in problems:
    if line.startswith('['):
      textF.write(line.rstrip())
      textF.write('\n')
      #    rstrip() removes end-of-line character
    m = dbegin.match(line)
    if m:
      textF.write(line.rstrip())
      textF.write('\n')
    m = cbegin.match(line)
    if m:
      textF.write(line.rstrip())
      textF.write('\n')
