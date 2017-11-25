import os


numBits = 32

fileName = "CLA{}.v".format(numBits)

print fileName

with open(fileName, "w") as fObj:
    fObj.write("module CLA{}(x, y, cIn, s, cOut);\n".format(numBits))
    fObj.write("\n\tinput [{}:0] x, y;\n\tinput cIn;\n\n\toutput [{}:0] s;\n\toutput cOut;\n\n\twire [{}:0] g, p;\n\twire [{}:0] c;\n".format( \
    numBits-1, numBits-1, numBits-1, numBits) )
    
    
    fObj.write("\n\tassign g = x&y;\n\tassign p = x^y;\n\n\tassign c[0] = cIn;\n")
    
    for i in xrange(1, numBits+1):
        string = "\n\tassign c[{}] = g[{}] ".format(i, i-1)
        
        for j in xrange(i-2, -1, -1): #start stop step
            string += "| &p[{}:{}]&g[{}] ".format(i-1, j+1, j)
            
        string += "| &p[{}:0]&c[0];".format(i-1)
        
        
        fObj.write(string)
    
    
    fObj.write( "\n\n\tassign s = p^c[{}:0];\n".format(numBits-1) )
    fObj.write( "\n\tassign cOut = c[{}];\n".format(numBits) )
    fObj.write("\nendmodule\n")
