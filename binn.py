import sys
thing = int(sys.argv[1], 16)
i = 31
while i >= 0:
    print i, '\t', 1 if thing & (1 << i) else 0
    i -= 1
    
