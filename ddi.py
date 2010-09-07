import re, copy, sys
it = iter(open('DDI.txt'))
def readline():
    ret = it.next()
    #print ret
    return ret
allinsns = {}
allnames = []
while True:
    try:
        line = readline()
    except StopIteration:
        break
    if line.startswith('Encoding T'):   
        name = '%'
        while True:
            l = readline()
            if l.startswith('15 14 13'): break
            l = l.strip()
            if l: name = l
        nameorig = name
        name = re.sub('\s*(Outside|Inside|If|Not|<Rn> and) .*$', '', name)
        if re.search('\.\s*$', name):
            raise ValueError(name)
        l = readline()
        stuff = re.split(' +', l.strip())
        calcsize = 0
        bitsize = 32 if (stuff[0] == '1' and stuff[1] == '1' and stuff[2] == '1' and not (stuff[3] == '0' and stuff[4] == '0')) else 16
        bits = [None] * bitsize
        vars = []
        ns = set()
        for thing in stuff:
            if thing in ['(0)', '0']:
                bits[calcsize] = 0
                size = 1
                calcsize += size
                continue
            if thing in ['(1)', '1']:
                bits[calcsize] = 1
                size = 1
                calcsize += size
                continue
            elif len(thing) == 1 or thing in ['DN', 'DM', 'J1', 'J2', 'op', 'im', 'sh']:
                size = 1
            elif thing.startswith('imm'):
                size = int(thing[3:])
            elif thing == 'Rm':
                if name in ['ADD<c> <Rdn>,<Rm>',
                            'ADD<c> SP,<Rm>',
                            'BLX<c> <Rm>',
                            'BX<c> <Rm>',
                            'MOV<c> <Rd>,<Rm>',
                            ] or name == 'CMP<c> <Rn>,<Rm>' and 'not both' in nameorig:
                    size = 4
                else:
                    size = 4 if bitsize == 32 else 3
            elif thing.startswith('R'):
                size = 4 if bitsize == 32 else 3
            elif thing.startswith('CR'):
                size = 4
            elif thing == 'opc2' or (thing == 'opc1' and name in ['MCR<c> <coproc>,<opc1>,<Rt>,<CRn>,<CRm>{,<opc2>}',
                                                                  'MCR2<c> <coproc>,<opc1>,<Rt>,<CRn>,<CRm>{,<opc2>}',
                                                                  'MRC<c> <coproc>,<opc1>,<Rt>,<CRn>,<CRm>{,<opc2>}',
                                                                  'MRC2<c> <coproc>,<opc1>,<Rt>,<CRn>,<CRm>{,<opc2>}',
                                                                 ]):
                size = 3
            elif thing in ['type', 'shift', 'rotate']:
                size = 2
            elif thing in ['cond', 'coproc', 'option', 'firstcond', 'mask', 'opc1']:
                size = 4
            elif thing in ['msb', 'widthm1', 'sat_imm']:
                size = 5
            elif thing == 'register_list':
                size = 13 if bitsize == 32 else 8
            elif thing == 'SYSm':
                size = 8
            else:
                print line
                raise ValueError(repr(thing))
            if thing == 'type': thing = 'typ' # nimrod
            while thing in ns: thing += '_P'
            ns.add(thing)
            vars.append((thing, bitsize - 1 - calcsize, bitsize - calcsize - size))
            calcsize += size
            
        allnames.append((name, vars))
        #print calcsize, repr(name)
        assert calcsize == bitsize
        allinsns.setdefault(bitsize, []).append((tuple(bits), vars, name, False))

def identifier(name, vars):
    return '#: ' + name + '\n' + \
    '#  avail: ' + ' '.join('%s:%s' % (name, hi - lo + 1) for (name, hi, lo) in vars) + '\n'

if False:
    f = open('defs.nim', 'w')
    for name, vars in allnames:
        f.write(identifier(name, vars))
        f.write('\n')
    f.write('#: done\n')
    f.close()
    sys.exit(0)

handlers = {}
cur = None
cur_name = None
xxx = ''
for line in open('defs.nim'):
    if line.startswith('#:'):
        if cur is not None:
            handlers[cur] = xxx
        cur = None
        cur_name = line
    elif line.startswith('#  avail:'):
        cur = cur_name + line
        xxx = ''
    else:
        xxx += line


#    for i in xrange(bitsize):
#        
#    valid = [(i, len([x for x in insns if x[0][i] == 1])) for i in xrange(bitsize) if all(x[0][i] is not None for x in insns)]
#    i, score = min(valid, key=lambda (i, l): abs(l - float(len(insns))/2))
#    if score == 0 or score == len(insns):
#        for insn in insns:
#        return

def indent(g):
    return '  ' + re.sub('\n(.)', '\n  \\1', g)

def handle_insn(bitsize, id, insn):
    result = ''
    result += '#' + insn[2] + '\n'
    result += '#' + str(insn[0]) + '\n'

    result += 'block:\n'
    for name, hi, lo in insn[1]:
        expr = 'insn[%d,%d]' % (hi, lo)
        typ = 'TBinary'
        if re.match('R[a-z][a-z]?$', name):
            expr = 'TReg(%s.num)' % expr
            typ = 'TReg'
        elif name == 'S':
            expr = 'int(%s.num)' % expr
            typ = 'int'
        result += '  var %s : %s = %s\n' % (name, typ, expr)
    handler = handlers[id].rstrip()
    del handlers[id]
    result += indent(handler) + '\n  nil\n'
    return result

def foo_(bitsize, insns, known):
    result = ''
    if len(insns) == 0: return result
    valid = [i for i in xrange(bitsize) if known[i] is None]
    for i in valid[:1]:
        # This is a hack due to O(huge) and won't work in all cases.
        # The assumption is that a specific case won't be preempted by an even more specific case.
        known2 = known[:]
        new = [x for x in insns if x[0][i] == 1]
        known2[i] = 1
        results1 = foo_(bitsize, new, known2)
        
        known2 = known[:]
        new = [x for x in insns if x[0][i] == 0]
        known2[i] = 0
        results2 = foo_(bitsize, new, known2)
        
        known2 = known[:]
        new = [x for x in insns if x[0][i] is None]
        known2[i] = 2
        results3 = foo_(bitsize, new, known2)
        
        if results1:
            result += 'if bit(insn, %d):\n' % (bitsize - i - 1)
            result += indent(results1)
            if results2:
                assert result[-1] == '\n'
                result += 'else:\n'
                result += indent(results2)
        elif results2:
            result += 'if not bit(insn, %d):\n' % (bitsize - i - 1)
            result += indent(results2)

        result += results3

            
    for insn in insns:
        id = identifier(insn[2], insn[1])
        if not handlers.has_key(id): continue
        if all((known[i] == insn[0][i]) or (known[i] == 2 and insn[0][i] is None) for i in xrange(bitsize)):
            #result += '#k: [%s]\n' % known
            result += '#i: %r\n' % (insn,)
            result += handle_insn(bitsize, id, insn)
    return result
            

def foo(bitsize, insns, known={}):
    insns_ = []
    for insn in sorted(insns, key=lambda insn: len([i for i in insn[0] if i is not None])):
        id = identifier(insn[2], insn[1])
        if not handlers.has_key(id): continue
        my_bits = insn[0]
        for insn2 in insns_:
            his_bits = insn2[0]
            if all(my_bits[i] == his_bits[i] or his_bits[i] is None for i in xrange(bitsize)):
                #print 'Special case:', insn[2], 'of:', insn2[2]
                #print my_bits, his_bits
                #print insn2
                specialcase = True
                break
        else:
            specialcase = False
        insns_.append((insn[0], insn[1], insn[2], specialcase))
    known_ = [None] * bitsize
    for k, v in known.iteritems(): known_[k] = v
    return foo_(bitsize, insns_, known_) + 'return nil'
            
#for insn in allinsns[16]:
#    print insn
#die
_32 = indent(foo(32, allinsns[32], {0: 1, 1: 1, 2: 1}))
_16 = indent(foo(16, allinsns[16], {}))
open('disas.nim', 'w').write('''
import armtypes, armfuncs, types
proc processInsn16*[TAsmCtx](ctx : TAsmCtx, insn : TBinary, t : TInsnFlags) : TEnt =
%s

proc processInsn32*[TAsmCtx](ctx : TAsmCtx, insn : TBinary, t : TInsnFlags) : TEnt =
%s
''' % (_16, _32))
#handlers['general'] = '42\n'
#handlers['specific'] = '24\n'
#print foo(4, [([0, 1, 0, 1], [], 'specific'), ([0, None, 0, 1], [], 'general')], {})
