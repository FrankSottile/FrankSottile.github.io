import argparse
import time
from go import saveToFile
from prettyFormat import changeFormat
from os import remove


if __name__ == "__main__":
  parser = argparse.ArgumentParser(description='Main for calculating Gr(n,k)')
  parser.add_argument('-k', help='the value for k in Gr(k,n)', required=True, type=int)
  parser.add_argument('-n', help='the value for n in Gr(k,n)', required=True, type=int)
  parser.add_argument('-f','--file', help='Output file name', required=True)
  args = parser.parse_args()

  k = args.k
  n = args.n
  outFile = args.file
  
  if args.k < n and k > 0 and n > 0:
    tempFile = '__tempFile.txt'
    T = time.clock()
    saveToFile(k,n,tempFile)
    T = time.clock()-T
    changeFormat(tempFile, outFile,k,n,T)
    print (time.clock())
    
    remove(tempFile)
    
  else:
    print 'Invalid values for n or k'
  


