import os
import math

os.chdir('/home/vignesh/Dropbox/CompOrg/Assign 1')

numBits = 4

numLevs = int(round(math.log(numBits, 2)))

fileName = "Prefix_Add{}_gen.v".format(numBits)

print fileName

with open(fileName, "w") as fObj:
    fObj.write("module Prefix_Add{}_gen(x, y, cIn, s, cOut);\n".format(numBits))
    fObj.write("\n\tinput [{}:0] x, y;\n\tinput cIn;\n\n\toutput [{}:0] s;\n\toutput cOut;\n".format( \
    numBits-1, numBits-1) )
    
    
    string = "\n\twire [{}:0] g0, p0".format(numBits-1)
    
    for i in xrange(1, numLevs+1):
        string += ", g{}, p{}".format(i, i)
        
    string += ";\n"
    
    fObj.write(string)
    
    fObj.write("\twire [{}:0] c;\n".format(numBits))
    
    fObj.write("\n\tassign g0[{0}:1] = x[{0}:1]&y[{0}:1];\n".format(numBits-1))
    
    fObj.write("\tassign p0[{}:0] = x^y;\n".format(numBits-1))
    
    fObj.write("\tassign c[0] = cIn;\n");
    
    fObj.write("\tassign g0[0] = x[0]&y[0] | c[0]&(x[0] | y[0]);\n\n\n")
    
    
    
    
    for lev in xrange(1, numLevs + 1):
    
    
        #g
        
        ind = numBits-1
        
        if(  (ind - 2**(lev-1)) >= 0 ):
        
            string = "\n\tassign g{0}[{2}] = g{1}[{2}] | p{1}[{2}]&g{1}[{3}]".format(lev, lev-1, ind, ind - 2**(lev-1))
            
        else:
            string = "\n\tg{0}[{2}] = g{1}[{2}]".format(lev, lev-1, ind)
    
        for ind in xrange(numBits-2, -1, -1):
        
            if(  (ind - 2**(lev-1)) >= 0 ):
                string += ", g{0}[{2}] = g{1}[{2}] | p{1}[{2}]&g{1}[{3}]".format(lev, lev-1, ind, ind - 2**(lev-1))
    
            else:
                string += ", g{0}[{2}] = g{1}[{2}]".format(lev, lev-1, ind)
    
        string += ";\n"
        
        fObj.write(string)
        
        
        
        #p
        
        ind = numBits-1
        
        if(  (ind - 2**(lev-1)) >= 0 ):
        
            string = "\tassign p{0}[{2}] = p{1}[{2}]&p{1}[{3}]".format(lev, lev-1, ind, ind - 2**(lev-1))
            
        else:
            string = "\tp{0}[{2}] = p{1}[{2}]".format(lev, lev-1, ind)
    
        for ind in xrange(numBits-2, -1, -1):
        
            if(  (ind - 2**(lev-1)) >= 0 ):
                string += ", p{0}[{2}] = p{1}[{2}]&p{1}[{3}]".format(lev, lev-1, ind, ind - 2**(lev-1))
    
            else:
                string += ", p{0}[{2}] = p{1}[{2}]".format(lev, lev-1, ind)
    
        string += ";\n"
    
        fObj.write(string)
    
    
    fObj.write( "\n\n\n\tassign c[{}:1] = g{}[{}:0];\n".format(numBits, numLevs, numBits-1) )
    fObj.write( "\tassign s = p0^c[{}:0];\n".format(numBits-1) )
    fObj.write( "\tassign cOut = c[{}];\n".format(numBits) )
    fObj.write("\nendmodule\n")
