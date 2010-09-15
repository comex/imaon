import re, copy, sys

def indent(g):
    return '  ' + re.sub('\n(.)', '\n  \\1', g)

class instruction:
    def __init__(self, bits, vars, name):
        self.bits = tuple(bits)
        self.vars = vars
        self.name = name
        self.specialcase = False

    def identifier(self):
        return '#: ' + self.name + '\n' + \
        '#  avail: ' + ' '.join('%s:%s' % (name, hi - lo + 1) for (name, hi, lo) in self.vars) + '\n'
        

it = iter(open('DDI.txt'))
def readline():
    ret = it.next()
    #print ret
    return ret
allinsns = {}
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
            
        #print calcsize, repr(name)
        assert calcsize == bitsize
        allinsns.setdefault(bitsize, []).append(instruction(bits, vars, name))
        # tuple(bits), vars, name, False))

if False:
    f = open('defs_.nim', 'w')
    for cat in allinsns.itervalues():
        for insn in cat:
            f.write(insn.identifier() + '\n')
    f.write('#: done\n')
    f.close()
    sys.exit(0)

def get_handlers():
    handlers = {}
    cur = None
    cur_name = None
    cur_handler = ''
    for line in open('defs.nim'):
        if line.startswith('#:'):
            if cur is not None:
                handlers[cur] = cur_handler
            cur = None
            cur_name = line
        elif line.startswith('#  avail:'):
            cur = cur_name + line
            cur_handler = ''
        else:
            cur_handler += line
    return handlers

handlers = get_handlers()


def handle_insn(bitsize, id, insn):
    result = ''
    result += '#' + insn.name + '\n'
    result += '#' + str(insn.bits) + '\n'

    result += 'block:\n'
    for name, hi, lo in insn.vars:
        expr = 'insn[%d,%d]' % (hi, lo)
        typ = 'TBinary'
        if re.match('R[a-z][a-z]?2?$', name):
            expr = 'TReg(%s.num)' % expr
            typ = 'TReg'
        elif name == 'S':
            expr = 'if %s.bit: {ifS} else: {}' % expr
            typ = 'TInsnFlags'
        result += '  var %s : %s = %s\n' % (name, typ, expr)
    handler = handlers[id].rstrip()
    del handlers[id]
    result += indent(handler) + '\n  nil\n'
    return result

def foo_(bitsize, insns, known, record):
    result = ''
    if len(insns) == 0: return result
    valid = [i for i in xrange(bitsize) if known[i] is None]
    for i in valid[:1]:
        # This is a hack due to O(huge) and won't work in all cases.
        # The assumption is that a specific case won't be preempted by an even more specific case.
        known2 = known[:]
        new1 = [x for x in insns if x.bits[i] == 1]
        known2[i] = 1
        results1 = foo_(bitsize, new1, known2, record + [(bitsize - i - 1, 1)])
        
        known2 = known[:]
        new2 = [x for x in insns if x.bits[i] == 0]
        known2[i] = 0
        results2 = foo_(bitsize, new2, known2, record + [(bitsize - i - 1, 0)])
        
        known2 = known[:]
        new3 = [x for x in insns if x.bits[i] is None]
        known2[i] = 2
        results3 = foo_(bitsize, new3, known2, record + [(bitsize - i - 1, 2)])
        
        result += '# %s\n' % record
        if results1:
            result += 'if bit(insn, %d):\n' % (bitsize - i - 1)
            result += indent(results1)
            if results2:
                assert result[-1] == '\n'
                result += 'else: #%d\n' % (bitsize - i - 1)
                result += indent(results2)
        elif results2:
            result += 'if not bit(insn, %d):\n' % (bitsize - i - 1)
            result += indent(results2)

        result += results3

            
    for insn in insns:
        id = insn.identifier()
        if not handlers.has_key(id): continue
        if all((known[i] == insn.bits[i]) or (known[i] == 2 and insn.bits[i] is None) for i in xrange(bitsize)):
            result += '#i: %r\n' % (insn,)
            result += handle_insn(bitsize, id, insn)
    return result
            

def foo(bitsize, insns, known={}):
    insns_ = []
    for insn in sorted(insns, key=lambda insn: len([i for i in insn.bits if i is not None])):
        id = insn.identifier()
        if not handlers.has_key(id):
            raise ValueError('! No handler for: ' + id)
        for insn2 in insns_:
            if all(insn.bits[i] == insn2.bits[i] or insn2.bits[i] is None for i in xrange(bitsize)):
                assert not insn2.specialcase
                #print 'Special case:', insn.name, 'of:', insn2.name
                #print insn.bits, insn2.bits
                insn.specialcase = True
                break
        insns_.append(insn)
    known_ = [None] * bitsize
    for k, v in known.iteritems(): known_[k] = v
    return foo_(bitsize, insns_, known_, [])
            
_32 = indent(indent(foo(32, allinsns[32], {0: 1, 1: 1, 2: 1})))
_16 = indent(indent(foo(16, allinsns[16], {})))
for k in handlers:
    print '! Bad handler: ' + k
open('disas.nim', 'w').write('''
import armtypes, armfuncs, types, funcs
import allAC
include "ltgt"
template ctxspec(TAsmCtx : typedesc, TVal : typedesc, TRVal : typedesc) =
  proc processInsn16*(ctx : TAsmCtx, insn : TBinary, t : TInsnFlags) : TVal =
%s

  proc processInsn32*(ctx : TAsmCtx, insn : TBinary, t : TInsnFlags) : TVal =
%s 

foreachAC(ctxspec)
''' % (_16, _32))
#handlers['general'] = '42\n'
#handlers['specific'] = '24\n'
#print foo(4, [([0, 1, 0, 1], [], 'specific'), ([0, None, 0, 1], [], 'general')], {})
