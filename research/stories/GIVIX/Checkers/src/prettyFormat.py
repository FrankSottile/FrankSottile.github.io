import simplejson as json
import os


def schToOutput(condition,k,n):
  if condition == []:
    return ''
  string = '('
  i = n-k
  for num in condition:
    if num == 99:
      i-=1;
    else:
      if i != 0:
        string += str(i)
  string += ')'
  return string


def changeFormat(in_FileName, out_FileName, k, n, TYME):
  in_file = open(in_FileName, 'r')
  out_file = open(out_FileName, 'w')
  out_file.write('###########################################################\n#\n')
  out_file.write('###        Grassmannian   Gr(' + str(k) + ',' + str(n) + ') \n#\n')
  out_file.write('###########################################################\n')
  #Sort on number of solutions, may not be feasible for larger Grassmanians
  all_input = []
  for line in in_file:
    all_input.append(json.loads(line))
  all_input = sorted(all_input, key=lambda x: x[1])

  ctr = 0
  
  for result in all_input:
    sch_prob  = result[0]
    solutions = result[1]
    formatted = []
  
    #remove 99's, add 1 to everything
    for condition in sch_prob:
      formatted.append([x+1 for x in condition if x != 99])
    
    #put numSolutions at the front of output list
    formatted.insert(0,solutions)
  
    #Create comment line
    comment = '# '
    #Empty condition makes it terminate correctly
    sch_prob.append([])
    prev = sch_prob[0]
    mult = 0
    for condition in sch_prob:
      #only need to print when we reach something new
      if condition == prev:
        mult += 1
      else:
        comment += schToOutput(prev,k,n)
        if mult != 1:
          comment += '^' + str(mult)
        if condition != sch_prob[-1]:
          comment += ' * '
        mult = 1
        prev = condition
  
    comment += ' = ' + str(solutions)

    #remove added empty condition
    sch_prob.pop()

    out_file.write(str(formatted) + '\n')
    out_file.write(comment + '\n')
    out_file.write('###########################################################\n')

    ctr += 1
  in_file.close()

  out_file.write( '#   Number of Schubert problems that might not be at least alternating = ' + str(ctr) + '\n')
  out_file.write( '#   Elapsed time = ' + str(TYME) + '   seconds \n')

  out_file.close()
