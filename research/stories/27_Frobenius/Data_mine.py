# Data_mine.py
#
# 7 March 2021
# Started 24 July 2018
#
# The purpose of this is to read Data and write a file for Maple.
#  Data and Times are tables that need a prime number (myPrime) as key
#################################################################################
freq = dict()

timeData = open('Time-sec','r')
prime =  (timeData.readline()).rstrip()
time =  (timeData.readline()).rstrip()


problems = open('Data','r')
for line in problems:
  cycle = line.rstrip()
  #    rstrip() removes end-of-line character
  if not (cycle in freq):
    freq[cycle] = 1
  else:
    freq[cycle] = freq[cycle] + 1

print(f'Data[{prime}]:=[')
for cycle in freq:
  print('[%s,%d],' %(cycle,freq[cycle]))

print('NULL]:')

print(f'Times[{prime}]:={time}:')
