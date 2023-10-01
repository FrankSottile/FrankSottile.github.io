# functions.py
#
#  This file contains functions written for mkHtml.py
#
# def isFibredI(K):  This tests for the problem being fibered over [2,4]^4 in a G(2,4)
#
#################################################################################
import re

#################################################################################
#
#  This takes a sequence for an essential Schubert condition on G(k,n) and returns the partition as a string
#
def seqToPartition(seq,n=0):
  alpha = list(seq)
  if n==0:
    n = seq[len(alpha)-1]
  k = len(alpha)
  tableau=''
  for i in range(0,k):
    part = n-k+1+i-alpha[i]
    if part == 0:
      break
    tableau = tableau+str(part)

  return tableau
#################################################################################

#################################################################################
#
#  This strips the number of solutions from a key
#
def numSols(Kstr):
  cdelim = re.compile(',')
  return int(cdelim.split(Kstr)[0][1:])
#################################################################################

#################################################################################
#
#  This strips the list of partitions from a key
#
def listOfPartitions(Kstr):
  cdelim = re.compile(',')
  lbracket = re.compile('\[')
  rbracket = re.compile('\]')
  rrbracket = re.compile('\]\]')
  KNw = ''.join(Kstr.split())
  ParseMe = cdelim.split(KNw)
  listPartitions = []
  newList = []
  for i in range(1,len(ParseMe)):
    if lbracket.match(ParseMe[i]):
      newList.append(int(ParseMe[i][1:]))
    elif rrbracket.search(ParseMe[i]):
      newList.append(int(ParseMe[i][:-2]))
      listPartitions.append(seqToPartition(newList))
      break
    elif rbracket.search(ParseMe[i]):
      newList.append(int(ParseMe[i][:-1]))
      listPartitions.append(seqToPartition(newList))
      newList = []
    else:
      newList.append(int(ParseMe[i]))

  return sorted(listPartitions)
#################################################################################

#################################################################################
#
#  This strips the list of conditions from a key
#
def listOfConditions(Kstr):
  cdelim = re.compile(',')
  lbracket = re.compile('\[')
  rbracket = re.compile('\]')
  rrbracket = re.compile('\]\]')
  KNw = ''.join(Kstr.split())
  ParseMe = cdelim.split(KNw)
  listConditions = []
  newList = []
  for i in range(1,len(ParseMe)):
    if lbracket.match(ParseMe[i]):
      newList.append(int(ParseMe[i][1:]))
    elif rrbracket.search(ParseMe[i]):
      newList.append(int(ParseMe[i][:-2]))
      listConditions.append(newList)
      break
    elif rbracket.search(ParseMe[i]):
      newList.append(int(ParseMe[i][:-1]))
      listConditions.append(newList)
      newList = []
    else:
      newList.append(int(ParseMe[i]))

  return listConditions
#################################################################################

################################################################################
#
#  Header for .html file
#
def header():
  Lines = ['<html>\n\n<head>\n',' <title>Cycle types and frequency in Enriched Schubert problems in G(4,9)</title>\n']
  Lines.extend(['</head>\n\n','<body>\n','<h1>Cycle types and frequency in Enriched Schubert problems in G(4,9)</h1>\n'])

  return Lines
#  Lines.extend([''])
#  ,'','','','','','','','','','','','','','','',


#################################################################################
#
#  This takes the string encoding a Schubert problem 'pb
#    fibered over a probme of four lines [2,4]^4 = 2 in a G(2,4).  It returns either
#    0 (for false) or a list, which is the residual problem.
#
def isFibred1(K):
  tall = 0
  long = 0
  for condition in listOfConditions(K):
    if condition[0]==2 and condition[1] > 4:     # This detects the row complement of [2,4]
      long = long + 1
    if condition[0] > 2 and condition[2]==7:     # Detects column complement of [2,4]
      tall = tall + 1

  if long==2 and tall==2:
    residual = []
    for condition in listOfConditions(K):
      if condition[0]==2 and condition[1] > 4:     # This detects the row complement of [2,4]
        if condition[1] < 7:
          residual.append([condition[1]-3,condition[2]-3])
      elif condition[0] > 2 and condition[2]==7:     # Detects column complement of [2,4]
        if condition[0] < 5:
          residual.append([condition[0]-1,condition[1]-1])
      else:
        residual.append([condition[0]-2,condition[1]-2])

    return sorted([seqToPartition(x,5) for x in residual])
  else:
    return 0
#################################################################################
#################################################################################
#
#  This takes the string encoding a Schubert problem 'pbKey' and tests if it is
#    fibered over a probme of four lines [2,5]*[3,5]^4 = 3 in a G(2,5).  2*1^4
#    It returns either 0 (for false) or a list, which is the residual problem.
#
def isFibred2(K):
  tall = 0
  long = 0
  longish = 0 
  for condition in listOfConditions(K):
    if condition[0]==2 and condition[1] > 4:     # This detects the row complement of [3,5]
      long = long + 1
    if condition[0]==3 and condition[1] > 4:     # This detects the row complement of [2,5]
      longish = longish + 1
    if condition[0] > 2 and condition[2]==7:     # Detects column complement of [3,5]
      tall = tall + 1
#    This can be wrapped in with isFibredI ?
  if long==1 and longish==1 and tall==3:
    residual = []
    for condition in listOfConditions(K):
      if (condition[0]==2 or condition[0]==3) and condition[1] > 4:     # This detects the row complement of [3,5] or of [2,5]
        if condition[1] < 7:
          residual.append([condition[1]-3,condition[2]-3])
      elif condition[0] > 2 and condition[2]==7:     # Detects column complement of [3,5]
        if condition[0] < 5:                         # Detects does not contain a square 22 partition
          residual.append([condition[0]-1,condition[1]-1])
      else:
        residual.append([condition[0]-2,condition[1]-2])

    return sorted([seqToPartition(x,5) for x in residual])
  else:
    return 0
#################################################################################
#################################################################################
#
#  This takes the string encoding a Schubert problem 'pbKey' and tests if it is
#    fibered over a probme of four lines [2,4]*[3,5]^3 = 3 in a G(2,5).  Here, the
#    [2,4] is complemented in 2 rows with the other conditions in 3 columns.
#    It returns either 0 (for false) or a list, which is the residual problem.
#
def isFibred3(K):
  tall = 0
  long = 0
  for condition in listOfConditions(K):
    if condition[0]==2 and condition[1]==4:      # This detects the row complement of [2,4] = 21
      long = long + 2
    if condition[0] > 2 and condition[2]==7:     # Detects column complement of [3,5] = 1
      tall = tall + 1
#    This can be wrapped in with isFibredI ?
  if long==2 and tall==3:
    residual = []
    for condition in listOfConditions(K):
      if condition[0]==2 and condition[1]==4:     # This detects the row complement of [2,4]
          residual.append([2,4])
      elif condition[0] > 2 and condition[2]==7:     # Detects column complement of [3,5]
        if condition[0] < 5:                         # Detects does not contain a square 22 partition
          residual.append([condition[0]-1,condition[1]-1])
      else:
        residual.append([condition[0]-2,condition[1]-2])

    return sorted([seqToPartition(x,5) for x in residual])
  else:
    return 0
#################################################################################

