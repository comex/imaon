import os, struct, re
imaon = os.popen('./test all16').read().strip().split('\n')
todis = ''
for i in xrange(0x10000):
    todis += struct.pack('H', i)
open('/tmp/todis', 'w').write(todis)
objdump = os.popen('/Users/comex/arm-none-eabi/bin/objdump -M force-thumb -m arm -b binary -D /tmp/todis').read()
objdump = re.sub(re.compile('^\s*[0-9a-z]*:\s*', re.M), '', re.sub(re.compile('^.*?(?=\s0000\s)', re.S), '', objdump)).split('\n')
for a, b in zip(imaon, objdump):
    print a + '  ' + b


