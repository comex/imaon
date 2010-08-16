
import armtypes, armops, armfuncs
proc processInsn16*(insn : TBinary, t : int) : PInsn =
  if bit(insn, 15):
    if bit(insn, 14):
      if bit(insn, 13):
        if not bit(insn, 12):
          if not bit(insn, 11):
            #i: ((1, 1, 1, 0, 0, None, None, None, None, None, None, None, None, None, None, None), [('imm11', 10, 0)], 'B<c> <label>', False)
            #B<c> <label>
            #(1, 1, 1, 0, 0, None, None, None, None, None, None, None, None, None, None, None)
            block:
              var imm11 : TBinary = insn[10,0]
              return z(opB, 0, PCRel(!sxt(cat(imm11, b"0"))))
              nil
      else:
        if bit(insn, 12):
          if bit(insn, 11):
            if bit(insn, 10):
              if bit(insn, 9):
                if bit(insn, 8):
                  #i: ((1, 1, 0, 1, 1, 1, 1, 1, None, None, None, None, None, None, None, None), [('imm8', 7, 0)], 'SVC<c> #<imm8>', True)
                  #SVC<c> #<imm8>
                  #(1, 1, 0, 1, 1, 1, 1, 1, None, None, None, None, None, None, None, None)
                  block:
                    var imm8 : TBinary = insn[7,0]
                    return z(opSVC, 0, imm8)
                    nil
          #i: ((1, 1, 0, 1, None, None, None, None, None, None, None, None, None, None, None, None), [('cond', 11, 8), ('imm8', 7, 0)], 'B<c> <label>', False)
          #B<c> <label>
          #(1, 1, 0, 1, None, None, None, None, None, None, None, None, None, None, None, None)
          block:
            var cond : TBinary = insn[11,8]
            var imm8 : TBinary = insn[7,0]
            return z(opB, Cond(cond), PCRel(!sxt(cat(imm8, b"0"))))
            nil
        else:
          if bit(insn, 11):
            #i: ((1, 1, 0, 0, 1, None, None, None, None, None, None, None, None, None, None, None), [('Rn', 10, 8), ('register_list', 7, 0)], 'LDM<c> <Rn>,<registers> <Rn> included in <registers>', False)
            #LDM<c> <Rn>,<registers> <Rn> included in <registers>
            #(1, 1, 0, 0, 1, None, None, None, None, None, None, None, None, None, None, None)
            block:
              var Rn : TEnt = Reg(b2int(insn[10,8]))
              var register_list : TBinary = insn[7,0]
              var rl = RegList(cat(b"00000000", register_list))
              var op : TOp
              if Rn.base.regNum in rl.base.rlNums:
                  excl(rl.base.rlNums, Rn.base.regNum)
                  op = opLDM
              else:
                  op = opLDMIA
              return z(op, 0, Rn, rl)
              nil
          else:
            #i: ((1, 1, 0, 0, 0, None, None, None, None, None, None, None, None, None, None, None), [('Rn', 10, 8), ('register_list', 7, 0)], 'STM<c> <Rn>!,<registers>', False)
            #STM<c> <Rn>!,<registers>
            #(1, 1, 0, 0, 0, None, None, None, None, None, None, None, None, None, None, None)
            block:
              var Rn : TEnt = Reg(b2int(insn[10,8]))
              var register_list : TBinary = insn[7,0]
              
              nil
    else:
      if bit(insn, 13):
        if bit(insn, 12):
          if bit(insn, 11):
            if bit(insn, 10):
              if bit(insn, 9):
                if bit(insn, 8):
                  if not bit(insn, 7):
                    if bit(insn, 6):
                      if not bit(insn, 5):
                        if not bit(insn, 4):
                          if not bit(insn, 3):
                            if not bit(insn, 2):
                              if not bit(insn, 1):
                                if not bit(insn, 0):
                                  #i: ((1, 0, 1, 1, 1, 1, 1, 1, 0, 1, 0, 0, 0, 0, 0, 0), [], 'SEV<c>', True)
                                  #SEV<c>
                                  #(1, 0, 1, 1, 1, 1, 1, 1, 0, 1, 0, 0, 0, 0, 0, 0)
                                  block:
                                    
                                    nil
                    else:
                      if bit(insn, 5):
                        if bit(insn, 4):
                          if not bit(insn, 3):
                            if not bit(insn, 2):
                              if not bit(insn, 1):
                                if not bit(insn, 0):
                                  #i: ((1, 0, 1, 1, 1, 1, 1, 1, 0, 0, 1, 1, 0, 0, 0, 0), [], 'WFI<c>', True)
                                  #WFI<c>
                                  #(1, 0, 1, 1, 1, 1, 1, 1, 0, 0, 1, 1, 0, 0, 0, 0)
                                  block:
                                    return z(opWFI, 0)
                                    nil
                        else:
                          if not bit(insn, 3):
                            if not bit(insn, 2):
                              if not bit(insn, 1):
                                if not bit(insn, 0):
                                  #i: ((1, 0, 1, 1, 1, 1, 1, 1, 0, 0, 1, 0, 0, 0, 0, 0), [], 'WFE<c>', True)
                                  #WFE<c>
                                  #(1, 0, 1, 1, 1, 1, 1, 1, 0, 0, 1, 0, 0, 0, 0, 0)
                                  block:
                                    return z(opWFE, 0)
                                    nil
                      else:
                        if bit(insn, 4):
                          if not bit(insn, 3):
                            if not bit(insn, 2):
                              if not bit(insn, 1):
                                if not bit(insn, 0):
                                  #i: ((1, 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 1, 0, 0, 0, 0), [], 'YIELD<c>', True)
                                  #YIELD<c>
                                  #(1, 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 1, 0, 0, 0, 0)
                                  block:
                                    return z(opYIELD, 0)
                                    nil
                        else:
                          if not bit(insn, 3):
                            if not bit(insn, 2):
                              if not bit(insn, 1):
                                if not bit(insn, 0):
                                  #i: ((1, 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0), [], 'NOP<c>', True)
                                  #NOP<c>
                                  #(1, 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0)
                                  block:
                                    
                                    nil
                  #i: ((1, 0, 1, 1, 1, 1, 1, 1, None, None, None, None, None, None, None, None), [('firstcond', 7, 4), ('mask', 3, 0)], 'IT{x{y{z}}} <firstcond>', False)
                  #IT{x{y{z}}} <firstcond>
                  #(1, 0, 1, 1, 1, 1, 1, 1, None, None, None, None, None, None, None, None)
                  block:
                    var firstcond : TBinary = insn[7,4]
                    var mask : TBinary = insn[3,0]
                    # Yuk.  This will need special care.
                    if mask == b"0000": break
                    return z(opIT, Cond(firstcond) or (b2int(mask) shl 5))
                    nil
                else:
                  #i: ((1, 0, 1, 1, 1, 1, 1, 0, None, None, None, None, None, None, None, None), [('imm8', 7, 0)], 'BKPT #<imm8>', False)
                  #BKPT #<imm8>
                  #(1, 0, 1, 1, 1, 1, 1, 0, None, None, None, None, None, None, None, None)
                  block:
                    var imm8 : TBinary = insn[7,0]
                    return z(opBKPT, 0, imm8)
                    nil
              else:
                #i: ((1, 0, 1, 1, 1, 1, 0, None, None, None, None, None, None, None, None, None), [('P', 8, 8), ('register_list', 7, 0)], 'POP<c> <registers>', False)
                #POP<c> <registers>
                #(1, 0, 1, 1, 1, 1, 0, None, None, None, None, None, None, None, None, None)
                block:
                  var P : TBinary = insn[8,8]
                  var register_list : TBinary = insn[7,0]
                  
                  nil
            else:
              if bit(insn, 9):
                if not bit(insn, 8):
                  if bit(insn, 7):
                    if bit(insn, 6):
                      #i: ((1, 0, 1, 1, 1, 0, 1, 0, 1, 1, None, None, None, None, None, None), [('Rm', 5, 3), ('Rd', 2, 0)], 'REVSH<c> <Rd>,<Rm>', False)
                      #REVSH<c> <Rd>,<Rm>
                      #(1, 0, 1, 1, 1, 0, 1, 0, 1, 1, None, None, None, None, None, None)
                      block:
                        var Rm : TEnt = Reg(b2int(insn[5,3]))
                        var Rd : TEnt = Reg(b2int(insn[2,0]))
                        
                        nil
                  else:
                    if bit(insn, 6):
                      #i: ((1, 0, 1, 1, 1, 0, 1, 0, 0, 1, None, None, None, None, None, None), [('Rm', 5, 3), ('Rd', 2, 0)], 'REV16<c> <Rd>,<Rm>', False)
                      #REV16<c> <Rd>,<Rm>
                      #(1, 0, 1, 1, 1, 0, 1, 0, 0, 1, None, None, None, None, None, None)
                      block:
                        var Rm : TEnt = Reg(b2int(insn[5,3]))
                        var Rd : TEnt = Reg(b2int(insn[2,0]))
                        
                        nil
                    else:
                      #i: ((1, 0, 1, 1, 1, 0, 1, 0, 0, 0, None, None, None, None, None, None), [('Rm', 5, 3), ('Rd', 2, 0)], 'REV<c> <Rd>,<Rm>', False)
                      #REV<c> <Rd>,<Rm>
                      #(1, 0, 1, 1, 1, 0, 1, 0, 0, 0, None, None, None, None, None, None)
                      block:
                        var Rm : TEnt = Reg(b2int(insn[5,3]))
                        var Rd : TEnt = Reg(b2int(insn[2,0]))
                        
                        nil
          else:
            if bit(insn, 10):
              if bit(insn, 9):
                if not bit(insn, 8):
                  if not bit(insn, 7):
                    if bit(insn, 6):
                      if bit(insn, 5):
                        if not bit(insn, 3):
                          if not bit(insn, 2):
                            #i: ((1, 0, 1, 1, 0, 1, 1, 0, 0, 1, 1, None, 0, 0, None, None), [('im', 4, 4), ('I', 1, 1), ('F', 0, 0)], 'CPS<effect> <iflags>', False)
                            #CPS<effect> <iflags>
                            #(1, 0, 1, 1, 0, 1, 1, 0, 0, 1, 1, None, 0, 0, None, None)
                            block:
                              var im : TBinary = insn[4,4]
                              var I : TBinary = insn[1,1]
                              var F : TBinary = insn[0,0]
                              
                              nil
              else:
                #i: ((1, 0, 1, 1, 0, 1, 0, None, None, None, None, None, None, None, None, None), [('M', 8, 8), ('register_list', 7, 0)], 'PUSH<c> <registers>', False)
                #PUSH<c> <registers>
                #(1, 0, 1, 1, 0, 1, 0, None, None, None, None, None, None, None, None, None)
                block:
                  var M : TBinary = insn[8,8]
                  var register_list : TBinary = insn[7,0]
                  
                  nil
            else:
              if bit(insn, 9):
                if not bit(insn, 8):
                  if bit(insn, 7):
                    if bit(insn, 6):
                      #i: ((1, 0, 1, 1, 0, 0, 1, 0, 1, 1, None, None, None, None, None, None), [('Rm', 5, 3), ('Rd', 2, 0)], 'UXTB<c> <Rd>,<Rm>', False)
                      #UXTB<c> <Rd>,<Rm>
                      #(1, 0, 1, 1, 0, 0, 1, 0, 1, 1, None, None, None, None, None, None)
                      block:
                        var Rm : TEnt = Reg(b2int(insn[5,3]))
                        var Rd : TEnt = Reg(b2int(insn[2,0]))
                        return z(opUXTB, 0, Rd, Rm)
                        nil
                    else:
                      #i: ((1, 0, 1, 1, 0, 0, 1, 0, 1, 0, None, None, None, None, None, None), [('Rm', 5, 3), ('Rd', 2, 0)], 'UXTH<c> <Rd>,<Rm>', False)
                      #UXTH<c> <Rd>,<Rm>
                      #(1, 0, 1, 1, 0, 0, 1, 0, 1, 0, None, None, None, None, None, None)
                      block:
                        var Rm : TEnt = Reg(b2int(insn[5,3]))
                        var Rd : TEnt = Reg(b2int(insn[2,0]))
                        return z(opUXTH, 0, Rd, Rm)
                        nil
                  else:
                    if bit(insn, 6):
                      #i: ((1, 0, 1, 1, 0, 0, 1, 0, 0, 1, None, None, None, None, None, None), [('Rm', 5, 3), ('Rd', 2, 0)], 'SXTB<c> <Rd>,<Rm>', False)
                      #SXTB<c> <Rd>,<Rm>
                      #(1, 0, 1, 1, 0, 0, 1, 0, 0, 1, None, None, None, None, None, None)
                      block:
                        var Rm : TEnt = Reg(b2int(insn[5,3]))
                        var Rd : TEnt = Reg(b2int(insn[2,0]))
                        
                        nil
                    else:
                      #i: ((1, 0, 1, 1, 0, 0, 1, 0, 0, 0, None, None, None, None, None, None), [('Rm', 5, 3), ('Rd', 2, 0)], 'SXTH<c> <Rd>,<Rm>', False)
                      #SXTH<c> <Rd>,<Rm>
                      #(1, 0, 1, 1, 0, 0, 1, 0, 0, 0, None, None, None, None, None, None)
                      block:
                        var Rm : TEnt = Reg(b2int(insn[5,3]))
                        var Rd : TEnt = Reg(b2int(insn[2,0]))
                        
                        nil
              else:
                if not bit(insn, 8):
                  if bit(insn, 7):
                    #i: ((1, 0, 1, 1, 0, 0, 0, 0, 1, None, None, None, None, None, None, None), [('imm7', 6, 0)], 'SUB<c> SP,SP,#<imm7>', False)
                    #SUB<c> SP,SP,#<imm7>
                    #(1, 0, 1, 1, 0, 0, 0, 0, 1, None, None, None, None, None, None, None)
                    block:
                      var imm7 : TBinary = insn[6,0]
                      
                      nil
                  else:
                    #i: ((1, 0, 1, 1, 0, 0, 0, 0, 0, None, None, None, None, None, None, None), [('imm7', 6, 0)], 'ADD<c> SP,SP,#<imm7>', False)
                    #ADD<c> SP,SP,#<imm7>
                    #(1, 0, 1, 1, 0, 0, 0, 0, 0, None, None, None, None, None, None, None)
                    block:
                      var imm7 : TBinary = insn[6,0]
                      return z(opADD, 0, SP, SP, cat(imm7, b"00"))
                      nil
          if not bit(insn, 10):
            if bit(insn, 8):
              #i: ((1, 0, 1, 1, None, 0, None, 1, None, None, None, None, None, None, None, None), [('op', 11, 11), ('i', 9, 9), ('imm5', 7, 3), ('Rn', 2, 0)], 'CB{N}Z <Rn>,<label>', False)
              #CB{N}Z <Rn>,<label>
              #(1, 0, 1, 1, None, 0, None, 1, None, None, None, None, None, None, None, None)
              block:
                var op : TBinary = insn[11,11]
                var i : TBinary = insn[9,9]
                var imm5 : TBinary = insn[7,3]
                var Rn : TEnt = Reg(b2int(insn[2,0]))
                if op.bit:
                    return z(opCBNZ, 0, PCRel(!cat(i, imm5, b"0")))
                else:
                    return z(opCBZ,  0, PCRel(!cat(i, imm5, b"0")))
                nil
        else:
          if bit(insn, 11):
            #i: ((1, 0, 1, 0, 1, None, None, None, None, None, None, None, None, None, None, None), [('Rd', 10, 8), ('imm8', 7, 0)], 'ADD<c> <Rd>,SP,#<imm8>', False)
            #ADD<c> <Rd>,SP,#<imm8>
            #(1, 0, 1, 0, 1, None, None, None, None, None, None, None, None, None, None, None)
            block:
              var Rd : TEnt = Reg(b2int(insn[10,8]))
              var imm8 : TBinary = insn[7,0]
              return z(opADD, 0, Rd, SP, cat(imm8, b"00"))
              nil
          else:
            #i: ((1, 0, 1, 0, 0, None, None, None, None, None, None, None, None, None, None, None), [('Rd', 10, 8), ('imm8', 7, 0)], 'ADR<c> <Rd>,<label>', False)
            #ADR<c> <Rd>,<label>
            #(1, 0, 1, 0, 0, None, None, None, None, None, None, None, None, None, None, None)
            block:
              var Rd : TEnt = Reg(b2int(insn[10,8]))
              var imm8 : TBinary = insn[7,0]
              return z(opADR, 0, Rd, PC, cat(imm8, b"00"))
              nil
      else:
        if bit(insn, 12):
          if bit(insn, 11):
            #i: ((1, 0, 0, 1, 1, None, None, None, None, None, None, None, None, None, None, None), [('Rt', 10, 8), ('imm8', 7, 0)], 'LDR<c> <Rt>,[SP{,#<imm8>}]', False)
            #LDR<c> <Rt>,[SP{,#<imm8>}]
            #(1, 0, 0, 1, 1, None, None, None, None, None, None, None, None, None, None, None)
            block:
              var Rt : TEnt = Reg(b2int(insn[10,8]))
              var imm8 : TBinary = insn[7,0]
              return z(opLDR, 0, Rt, Deref(SP, @cat(imm8, b"00")))
              nil
          else:
            #i: ((1, 0, 0, 1, 0, None, None, None, None, None, None, None, None, None, None, None), [('Rt', 10, 8), ('imm8', 7, 0)], 'STR<c> <Rt>,[SP,#<imm8>]', False)
            #STR<c> <Rt>,[SP,#<imm8>]
            #(1, 0, 0, 1, 0, None, None, None, None, None, None, None, None, None, None, None)
            block:
              var Rt : TEnt = Reg(b2int(insn[10,8]))
              var imm8 : TBinary = insn[7,0]
              
              nil
        else:
          if bit(insn, 11):
            #i: ((1, 0, 0, 0, 1, None, None, None, None, None, None, None, None, None, None, None), [('imm5', 10, 6), ('Rn', 5, 3), ('Rt', 2, 0)], 'LDRH<c> <Rt>,[<Rn>{,#<imm5>}]', False)
            #LDRH<c> <Rt>,[<Rn>{,#<imm5>}]
            #(1, 0, 0, 0, 1, None, None, None, None, None, None, None, None, None, None, None)
            block:
              var imm5 : TBinary = insn[10,6]
              var Rn : TEnt = Reg(b2int(insn[5,3]))
              var Rt : TEnt = Reg(b2int(insn[2,0]))
              
              nil
          else:
            #i: ((1, 0, 0, 0, 0, None, None, None, None, None, None, None, None, None, None, None), [('imm5', 10, 6), ('Rn', 5, 3), ('Rt', 2, 0)], 'STRH<c> <Rt>,[<Rn>{,#<imm5>}]', False)
            #STRH<c> <Rt>,[<Rn>{,#<imm5>}]
            #(1, 0, 0, 0, 0, None, None, None, None, None, None, None, None, None, None, None)
            block:
              var imm5 : TBinary = insn[10,6]
              var Rn : TEnt = Reg(b2int(insn[5,3]))
              var Rt : TEnt = Reg(b2int(insn[2,0]))
              
              nil
  else:
    if bit(insn, 14):
      if bit(insn, 13):
        if bit(insn, 12):
          if bit(insn, 11):
            #i: ((0, 1, 1, 1, 1, None, None, None, None, None, None, None, None, None, None, None), [('imm5', 10, 6), ('Rn', 5, 3), ('Rt', 2, 0)], 'LDRB<c> <Rt>,[<Rn>{,#<imm5>}]', False)
            #LDRB<c> <Rt>,[<Rn>{,#<imm5>}]
            #(0, 1, 1, 1, 1, None, None, None, None, None, None, None, None, None, None, None)
            block:
              var imm5 : TBinary = insn[10,6]
              var Rn : TEnt = Reg(b2int(insn[5,3]))
              var Rt : TEnt = Reg(b2int(insn[2,0]))
              
              nil
          else:
            #i: ((0, 1, 1, 1, 0, None, None, None, None, None, None, None, None, None, None, None), [('imm5', 10, 6), ('Rn', 5, 3), ('Rt', 2, 0)], 'STRB<c> <Rt>,[<Rn>,#<imm5>]', False)
            #STRB<c> <Rt>,[<Rn>,#<imm5>]
            #(0, 1, 1, 1, 0, None, None, None, None, None, None, None, None, None, None, None)
            block:
              var imm5 : TBinary = insn[10,6]
              var Rn : TEnt = Reg(b2int(insn[5,3]))
              var Rt : TEnt = Reg(b2int(insn[2,0]))
              
              nil
        else:
          if bit(insn, 11):
            #i: ((0, 1, 1, 0, 1, None, None, None, None, None, None, None, None, None, None, None), [('imm5', 10, 6), ('Rn', 5, 3), ('Rt', 2, 0)], 'LDR<c> <Rt>, [<Rn>{,#<imm5>}]', False)
            #LDR<c> <Rt>, [<Rn>{,#<imm5>}]
            #(0, 1, 1, 0, 1, None, None, None, None, None, None, None, None, None, None, None)
            block:
              var imm5 : TBinary = insn[10,6]
              var Rn : TEnt = Reg(b2int(insn[5,3]))
              var Rt : TEnt = Reg(b2int(insn[2,0]))
              return z(opLDR, 0, Rt, Deref(Rn, @cat(imm5, b"00")))
              nil
          else:
            #i: ((0, 1, 1, 0, 0, None, None, None, None, None, None, None, None, None, None, None), [('imm5', 10, 6), ('Rn', 5, 3), ('Rt', 2, 0)], 'STR<c> <Rt>, [<Rn>{,#<imm5>}]', False)
            #STR<c> <Rt>, [<Rn>{,#<imm5>}]
            #(0, 1, 1, 0, 0, None, None, None, None, None, None, None, None, None, None, None)
            block:
              var imm5 : TBinary = insn[10,6]
              var Rn : TEnt = Reg(b2int(insn[5,3]))
              var Rt : TEnt = Reg(b2int(insn[2,0]))
              
              nil
      else:
        if bit(insn, 12):
          if bit(insn, 11):
            if bit(insn, 10):
              if bit(insn, 9):
                #i: ((0, 1, 0, 1, 1, 1, 1, None, None, None, None, None, None, None, None, None), [('Rm', 8, 6), ('Rn', 5, 3), ('Rt', 2, 0)], 'LDRSH<c> <Rt>,[<Rn>,<Rm>]', False)
                #LDRSH<c> <Rt>,[<Rn>,<Rm>]
                #(0, 1, 0, 1, 1, 1, 1, None, None, None, None, None, None, None, None, None)
                block:
                  var Rm : TEnt = Reg(b2int(insn[8,6]))
                  var Rn : TEnt = Reg(b2int(insn[5,3]))
                  var Rt : TEnt = Reg(b2int(insn[2,0]))
                  
                  nil
              else:
                #i: ((0, 1, 0, 1, 1, 1, 0, None, None, None, None, None, None, None, None, None), [('Rm', 8, 6), ('Rn', 5, 3), ('Rt', 2, 0)], 'LDRB<c> <Rt>,[<Rn>,<Rm>]', False)
                #LDRB<c> <Rt>,[<Rn>,<Rm>]
                #(0, 1, 0, 1, 1, 1, 0, None, None, None, None, None, None, None, None, None)
                block:
                  var Rm : TEnt = Reg(b2int(insn[8,6]))
                  var Rn : TEnt = Reg(b2int(insn[5,3]))
                  var Rt : TEnt = Reg(b2int(insn[2,0]))
                  
                  nil
            else:
              if bit(insn, 9):
                #i: ((0, 1, 0, 1, 1, 0, 1, None, None, None, None, None, None, None, None, None), [('Rm', 8, 6), ('Rn', 5, 3), ('Rt', 2, 0)], 'LDRH<c> <Rt>,[<Rn>,<Rm>]', False)
                #LDRH<c> <Rt>,[<Rn>,<Rm>]
                #(0, 1, 0, 1, 1, 0, 1, None, None, None, None, None, None, None, None, None)
                block:
                  var Rm : TEnt = Reg(b2int(insn[8,6]))
                  var Rn : TEnt = Reg(b2int(insn[5,3]))
                  var Rt : TEnt = Reg(b2int(insn[2,0]))
                  
                  nil
              else:
                #i: ((0, 1, 0, 1, 1, 0, 0, None, None, None, None, None, None, None, None, None), [('Rm', 8, 6), ('Rn', 5, 3), ('Rt', 2, 0)], 'LDR<c> <Rt>,[<Rn>,<Rm>]', False)
                #LDR<c> <Rt>,[<Rn>,<Rm>]
                #(0, 1, 0, 1, 1, 0, 0, None, None, None, None, None, None, None, None, None)
                block:
                  var Rm : TEnt = Reg(b2int(insn[8,6]))
                  var Rn : TEnt = Reg(b2int(insn[5,3]))
                  var Rt : TEnt = Reg(b2int(insn[2,0]))
                  return z(opLDR, 0, Rt, Deref(Rn, Rm))
                  nil
          else:
            if bit(insn, 10):
              if bit(insn, 9):
                #i: ((0, 1, 0, 1, 0, 1, 1, None, None, None, None, None, None, None, None, None), [('Rm', 8, 6), ('Rn', 5, 3), ('Rt', 2, 0)], 'LDRSB<c> <Rt>,[<Rn>,<Rm>]', False)
                #LDRSB<c> <Rt>,[<Rn>,<Rm>]
                #(0, 1, 0, 1, 0, 1, 1, None, None, None, None, None, None, None, None, None)
                block:
                  var Rm : TEnt = Reg(b2int(insn[8,6]))
                  var Rn : TEnt = Reg(b2int(insn[5,3]))
                  var Rt : TEnt = Reg(b2int(insn[2,0]))
                  
                  nil
              else:
                #i: ((0, 1, 0, 1, 0, 1, 0, None, None, None, None, None, None, None, None, None), [('Rm', 8, 6), ('Rn', 5, 3), ('Rt', 2, 0)], 'STRB<c> <Rt>,[<Rn>,<Rm>]', False)
                #STRB<c> <Rt>,[<Rn>,<Rm>]
                #(0, 1, 0, 1, 0, 1, 0, None, None, None, None, None, None, None, None, None)
                block:
                  var Rm : TEnt = Reg(b2int(insn[8,6]))
                  var Rn : TEnt = Reg(b2int(insn[5,3]))
                  var Rt : TEnt = Reg(b2int(insn[2,0]))
                  
                  nil
            else:
              if bit(insn, 9):
                #i: ((0, 1, 0, 1, 0, 0, 1, None, None, None, None, None, None, None, None, None), [('Rm', 8, 6), ('Rn', 5, 3), ('Rt', 2, 0)], 'STRH<c> <Rt>,[<Rn>,<Rm>]', False)
                #STRH<c> <Rt>,[<Rn>,<Rm>]
                #(0, 1, 0, 1, 0, 0, 1, None, None, None, None, None, None, None, None, None)
                block:
                  var Rm : TEnt = Reg(b2int(insn[8,6]))
                  var Rn : TEnt = Reg(b2int(insn[5,3]))
                  var Rt : TEnt = Reg(b2int(insn[2,0]))
                  
                  nil
              else:
                #i: ((0, 1, 0, 1, 0, 0, 0, None, None, None, None, None, None, None, None, None), [('Rm', 8, 6), ('Rn', 5, 3), ('Rt', 2, 0)], 'STR<c> <Rt>,[<Rn>,<Rm>]', False)
                #STR<c> <Rt>,[<Rn>,<Rm>]
                #(0, 1, 0, 1, 0, 0, 0, None, None, None, None, None, None, None, None, None)
                block:
                  var Rm : TEnt = Reg(b2int(insn[8,6]))
                  var Rn : TEnt = Reg(b2int(insn[5,3]))
                  var Rt : TEnt = Reg(b2int(insn[2,0]))
                  
                  nil
        else:
          if not bit(insn, 11):
            if bit(insn, 10):
              if bit(insn, 9):
                if bit(insn, 8):
                  if bit(insn, 7):
                    if not bit(insn, 2):
                      if not bit(insn, 1):
                        if not bit(insn, 0):
                          #i: ((0, 1, 0, 0, 0, 1, 1, 1, 1, None, None, None, None, 0, 0, 0), [('Rm', 6, 3)], 'BLX<c> <Rm>', False)
                          #BLX<c> <Rm>
                          #(0, 1, 0, 0, 0, 1, 1, 1, 1, None, None, None, None, 0, 0, 0)
                          block:
                            var Rm : TEnt = Reg(b2int(insn[6,3]))
                            return z(opBLX, 0, Rm)
                            nil
                  else:
                    if not bit(insn, 2):
                      if not bit(insn, 1):
                        if not bit(insn, 0):
                          #i: ((0, 1, 0, 0, 0, 1, 1, 1, 0, None, None, None, None, 0, 0, 0), [('Rm', 6, 3)], 'BX<c> <Rm>', False)
                          #BX<c> <Rm>
                          #(0, 1, 0, 0, 0, 1, 1, 1, 0, None, None, None, None, 0, 0, 0)
                          block:
                            var Rm : TEnt = Reg(b2int(insn[6,3]))
                            return z(opBX, 0, Rm)
                            nil
                else:
                  #i: ((0, 1, 0, 0, 0, 1, 1, 0, None, None, None, None, None, None, None, None), [('D', 7, 7), ('Rm', 6, 3), ('Rd', 2, 0)], 'MOV<c> <Rd>,<Rm>', False)
                  #MOV<c> <Rd>,<Rm>
                  #(0, 1, 0, 0, 0, 1, 1, 0, None, None, None, None, None, None, None, None)
                  block:
                    var D : TBinary = insn[7,7]
                    var Rm : TEnt = Reg(b2int(insn[6,3]))
                    var Rd : TEnt = Reg(b2int(insn[2,0]))
                    
                    nil
              else:
                if bit(insn, 8):
                  #i: ((0, 1, 0, 0, 0, 1, 0, 1, None, None, None, None, None, None, None, None), [('N', 7, 7), ('Rm', 6, 3), ('Rn', 2, 0)], 'CMP<c> <Rn>,<Rm>', False)
                  #CMP<c> <Rn>,<Rm>
                  #(0, 1, 0, 0, 0, 1, 0, 1, None, None, None, None, None, None, None, None)
                  block:
                    var N : TBinary = insn[7,7]
                    var Rm : TEnt = Reg(b2int(insn[6,3]))
                    var Rn : TEnt = Reg(b2int(insn[2,0]))
                    if N.bit: Rn = shift(Rn)
                    return z(opCMP, 0, Rn, Rm)
                    nil
                else:
                  if bit(insn, 7):
                    if bit(insn, 2):
                      if not bit(insn, 1):
                        if bit(insn, 0):
                          #i: ((0, 1, 0, 0, 0, 1, 0, 0, 1, None, None, None, None, 1, 0, 1), [('Rm', 6, 3)], 'ADD<c> SP,<Rm>', True)
                          #ADD<c> SP,<Rm>
                          #(0, 1, 0, 0, 0, 1, 0, 0, 1, None, None, None, None, 1, 0, 1)
                          block:
                            var Rm : TEnt = Reg(b2int(insn[6,3]))
                            return z(opADD, 0, SP, SP, Rm)
                            nil
                  if bit(insn, 6):
                    if bit(insn, 5):
                      if not bit(insn, 4):
                        if bit(insn, 3):
                          #i: ((0, 1, 0, 0, 0, 1, 0, 0, None, 1, 1, 0, 1, None, None, None), [('DM', 7, 7), ('Rdm', 2, 0)], 'ADD<c> <Rdm>, SP, <Rdm>', True)
                          #ADD<c> <Rdm>, SP, <Rdm>
                          #(0, 1, 0, 0, 0, 1, 0, 0, None, 1, 1, 0, 1, None, None, None)
                          block:
                            var DM : TBinary = insn[7,7]
                            var Rdm : TEnt = Reg(b2int(insn[2,0]))
                            if DM.bit: Rdm = shift(Rdm)
                            return z(opADD, 0, Rdm, SP, Rdm)
                            nil
                  #i: ((0, 1, 0, 0, 0, 1, 0, 0, None, None, None, None, None, None, None, None), [('DN', 7, 7), ('Rm', 6, 3), ('Rdn', 2, 0)], 'ADD<c> <Rdn>,<Rm>', False)
                  #ADD<c> <Rdn>,<Rm>
                  #(0, 1, 0, 0, 0, 1, 0, 0, None, None, None, None, None, None, None, None)
                  block:
                    var DN : TBinary = insn[7,7]
                    var Rm : TEnt = Reg(b2int(insn[6,3]))
                    var Rdn : TEnt = Reg(b2int(insn[2,0]))
                    if DN.bit: Rdn = shift(Rdn)
                    if Rdn == SP or Rm == SP: break
                    return z(opADD, 0, Rdn, Rdn, Rm)
                    nil
            else:
              if bit(insn, 9):
                if bit(insn, 8):
                  if bit(insn, 7):
                    if bit(insn, 6):
                      #i: ((0, 1, 0, 0, 0, 0, 1, 1, 1, 1, None, None, None, None, None, None), [('Rm', 5, 3), ('Rd', 2, 0)], 'MVN<c> <Rd>,<Rm>', False)
                      #MVN<c> <Rd>,<Rm>
                      #(0, 1, 0, 0, 0, 0, 1, 1, 1, 1, None, None, None, None, None, None)
                      block:
                        var Rm : TEnt = Reg(b2int(insn[5,3]))
                        var Rd : TEnt = Reg(b2int(insn[2,0]))
                        
                        nil
                    else:
                      #i: ((0, 1, 0, 0, 0, 0, 1, 1, 1, 0, None, None, None, None, None, None), [('Rm', 5, 3), ('Rdn', 2, 0)], 'BIC<c> <Rdn>,<Rm>', False)
                      #BIC<c> <Rdn>,<Rm>
                      #(0, 1, 0, 0, 0, 0, 1, 1, 1, 0, None, None, None, None, None, None)
                      block:
                        var Rm : TEnt = Reg(b2int(insn[5,3]))
                        var Rdn : TEnt = Reg(b2int(insn[2,0]))
                        return z(opBIC, 0, Rdn, Rdn, Rm)
                        nil
                  else:
                    if bit(insn, 6):
                      #i: ((0, 1, 0, 0, 0, 0, 1, 1, 0, 1, None, None, None, None, None, None), [('Rn', 5, 3), ('Rdm', 2, 0)], 'MUL<c> <Rdm>,<Rn>,<Rdm>', False)
                      #MUL<c> <Rdm>,<Rn>,<Rdm>
                      #(0, 1, 0, 0, 0, 0, 1, 1, 0, 1, None, None, None, None, None, None)
                      block:
                        var Rn : TEnt = Reg(b2int(insn[5,3]))
                        var Rdm : TEnt = Reg(b2int(insn[2,0]))
                        
                        nil
                    else:
                      #i: ((0, 1, 0, 0, 0, 0, 1, 1, 0, 0, None, None, None, None, None, None), [('Rm', 5, 3), ('Rdn', 2, 0)], 'ORR<c> <Rdn>,<Rm>', False)
                      #ORR<c> <Rdn>,<Rm>
                      #(0, 1, 0, 0, 0, 0, 1, 1, 0, 0, None, None, None, None, None, None)
                      block:
                        var Rm : TEnt = Reg(b2int(insn[5,3]))
                        var Rdn : TEnt = Reg(b2int(insn[2,0]))
                        
                        nil
                else:
                  if bit(insn, 7):
                    if bit(insn, 6):
                      #i: ((0, 1, 0, 0, 0, 0, 1, 0, 1, 1, None, None, None, None, None, None), [('Rm', 5, 3), ('Rn', 2, 0)], 'CMN<c> <Rn>,<Rm>', False)
                      #CMN<c> <Rn>,<Rm>
                      #(0, 1, 0, 0, 0, 0, 1, 0, 1, 1, None, None, None, None, None, None)
                      block:
                        var Rm : TEnt = Reg(b2int(insn[5,3]))
                        var Rn : TEnt = Reg(b2int(insn[2,0]))
                        return z(opCMN, 1, Rn, Rm)
                        nil
                    else:
                      #i: ((0, 1, 0, 0, 0, 0, 1, 0, 1, 0, None, None, None, None, None, None), [('Rm', 5, 3), ('Rn', 2, 0)], 'CMP<c> <Rn>,<Rm>', False)
                      #CMP<c> <Rn>,<Rm>
                      #(0, 1, 0, 0, 0, 0, 1, 0, 1, 0, None, None, None, None, None, None)
                      block:
                        var Rm : TEnt = Reg(b2int(insn[5,3]))
                        var Rn : TEnt = Reg(b2int(insn[2,0]))
                        return z(opCMP, 1, Rn, Rm)
                        nil
                  else:
                    if bit(insn, 6):
                      #i: ((0, 1, 0, 0, 0, 0, 1, 0, 0, 1, None, None, None, None, None, None), [('Rn', 5, 3), ('Rd', 2, 0)], 'RSB<c> <Rd>,<Rn>,#0', False)
                      #RSB<c> <Rd>,<Rn>,#0
                      #(0, 1, 0, 0, 0, 0, 1, 0, 0, 1, None, None, None, None, None, None)
                      block:
                        var Rn : TEnt = Reg(b2int(insn[5,3]))
                        var Rd : TEnt = Reg(b2int(insn[2,0]))
                        
                        nil
                    else:
                      #i: ((0, 1, 0, 0, 0, 0, 1, 0, 0, 0, None, None, None, None, None, None), [('Rm', 5, 3), ('Rn', 2, 0)], 'TST<c> <Rn>,<Rm>', False)
                      #TST<c> <Rn>,<Rm>
                      #(0, 1, 0, 0, 0, 0, 1, 0, 0, 0, None, None, None, None, None, None)
                      block:
                        var Rm : TEnt = Reg(b2int(insn[5,3]))
                        var Rn : TEnt = Reg(b2int(insn[2,0]))
                        
                        nil
              else:
                if bit(insn, 8):
                  if bit(insn, 7):
                    if bit(insn, 6):
                      #i: ((0, 1, 0, 0, 0, 0, 0, 1, 1, 1, None, None, None, None, None, None), [('Rm', 5, 3), ('Rdn', 2, 0)], 'ROR<c> <Rdn>,<Rm>', False)
                      #ROR<c> <Rdn>,<Rm>
                      #(0, 1, 0, 0, 0, 0, 0, 1, 1, 1, None, None, None, None, None, None)
                      block:
                        var Rm : TEnt = Reg(b2int(insn[5,3]))
                        var Rdn : TEnt = Reg(b2int(insn[2,0]))
                        
                        nil
                    else:
                      #i: ((0, 1, 0, 0, 0, 0, 0, 1, 1, 0, None, None, None, None, None, None), [('Rm', 5, 3), ('Rdn', 2, 0)], 'SBC<c> <Rdn>,<Rm>', False)
                      #SBC<c> <Rdn>,<Rm>
                      #(0, 1, 0, 0, 0, 0, 0, 1, 1, 0, None, None, None, None, None, None)
                      block:
                        var Rm : TEnt = Reg(b2int(insn[5,3]))
                        var Rdn : TEnt = Reg(b2int(insn[2,0]))
                        
                        nil
                  else:
                    if bit(insn, 6):
                      #i: ((0, 1, 0, 0, 0, 0, 0, 1, 0, 1, None, None, None, None, None, None), [('Rm', 5, 3), ('Rdn', 2, 0)], 'ADC<c> <Rdn>,<Rm>', False)
                      #ADC<c> <Rdn>,<Rm>
                      #(0, 1, 0, 0, 0, 0, 0, 1, 0, 1, None, None, None, None, None, None)
                      block:
                        var Rm : TEnt = Reg(b2int(insn[5,3]))
                        var Rdn : TEnt = Reg(b2int(insn[2,0]))
                        return z(opADC, t, Rdn, Rdn, Rm)
                        nil
                    else:
                      #i: ((0, 1, 0, 0, 0, 0, 0, 1, 0, 0, None, None, None, None, None, None), [('Rm', 5, 3), ('Rdn', 2, 0)], 'ASR<c> <Rdn>,<Rm>', False)
                      #ASR<c> <Rdn>,<Rm>
                      #(0, 1, 0, 0, 0, 0, 0, 1, 0, 0, None, None, None, None, None, None)
                      block:
                        var Rm : TEnt = Reg(b2int(insn[5,3]))
                        var Rdn : TEnt = Reg(b2int(insn[2,0]))
                        return z(opASR, 0, Rdn, Rdn, Rm)
                        nil
                else:
                  if bit(insn, 7):
                    if bit(insn, 6):
                      #i: ((0, 1, 0, 0, 0, 0, 0, 0, 1, 1, None, None, None, None, None, None), [('Rm', 5, 3), ('Rdn', 2, 0)], 'LSR<c> <Rdn>,<Rm>', False)
                      #LSR<c> <Rdn>,<Rm>
                      #(0, 1, 0, 0, 0, 0, 0, 0, 1, 1, None, None, None, None, None, None)
                      block:
                        var Rm : TEnt = Reg(b2int(insn[5,3]))
                        var Rdn : TEnt = Reg(b2int(insn[2,0]))
                        
                        nil
                    else:
                      #i: ((0, 1, 0, 0, 0, 0, 0, 0, 1, 0, None, None, None, None, None, None), [('Rm', 5, 3), ('Rdn', 2, 0)], 'LSL<c> <Rdn>,<Rm>', False)
                      #LSL<c> <Rdn>,<Rm>
                      #(0, 1, 0, 0, 0, 0, 0, 0, 1, 0, None, None, None, None, None, None)
                      block:
                        var Rm : TEnt = Reg(b2int(insn[5,3]))
                        var Rdn : TEnt = Reg(b2int(insn[2,0]))
                        
                        nil
                  else:
                    if bit(insn, 6):
                      #i: ((0, 1, 0, 0, 0, 0, 0, 0, 0, 1, None, None, None, None, None, None), [('Rm', 5, 3), ('Rdn', 2, 0)], 'EOR<c> <Rdn>,<Rm>', False)
                      #EOR<c> <Rdn>,<Rm>
                      #(0, 1, 0, 0, 0, 0, 0, 0, 0, 1, None, None, None, None, None, None)
                      block:
                        var Rm : TEnt = Reg(b2int(insn[5,3]))
                        var Rdn : TEnt = Reg(b2int(insn[2,0]))
                        return z(opEOR, t, Rdn, Rdn, Rm)
                        nil
                    else:
                      #i: ((0, 1, 0, 0, 0, 0, 0, 0, 0, 0, None, None, None, None, None, None), [('Rm', 5, 3), ('Rdn', 2, 0)], 'AND<c> <Rdn>,<Rm>', False)
                      #AND<c> <Rdn>,<Rm>
                      #(0, 1, 0, 0, 0, 0, 0, 0, 0, 0, None, None, None, None, None, None)
                      block:
                        var Rm : TEnt = Reg(b2int(insn[5,3]))
                        var Rdn : TEnt = Reg(b2int(insn[2,0]))
                        return z(opAND, t, Rdn, Rdn, Rm)
                        nil
    else:
      if bit(insn, 13):
        if bit(insn, 12):
          if bit(insn, 11):
            #i: ((0, 0, 1, 1, 1, None, None, None, None, None, None, None, None, None, None, None), [('Rdn', 10, 8), ('imm8', 7, 0)], 'SUB<c> <Rdn>,#<imm8>', False)
            #SUB<c> <Rdn>,#<imm8>
            #(0, 0, 1, 1, 1, None, None, None, None, None, None, None, None, None, None, None)
            block:
              var Rdn : TEnt = Reg(b2int(insn[10,8]))
              var imm8 : TBinary = insn[7,0]
              
              nil
          else:
            #i: ((0, 0, 1, 1, 0, None, None, None, None, None, None, None, None, None, None, None), [('Rdn', 10, 8), ('imm8', 7, 0)], 'ADD<c> <Rdn>,#<imm8>', False)
            #ADD<c> <Rdn>,#<imm8>
            #(0, 0, 1, 1, 0, None, None, None, None, None, None, None, None, None, None, None)
            block:
              var Rdn : TEnt = Reg(b2int(insn[10,8]))
              var imm8 : TBinary = insn[7,0]
              return z(opADD, t, Rdn, Rdn, imm8)
              nil
        else:
          if bit(insn, 11):
            #i: ((0, 0, 1, 0, 1, None, None, None, None, None, None, None, None, None, None, None), [('Rn', 10, 8), ('imm8', 7, 0)], 'CMP<c> <Rn>,#<imm8>', False)
            #CMP<c> <Rn>,#<imm8>
            #(0, 0, 1, 0, 1, None, None, None, None, None, None, None, None, None, None, None)
            block:
              var Rn : TEnt = Reg(b2int(insn[10,8]))
              var imm8 : TBinary = insn[7,0]
              return z(opCMP, 1, Rn, imm8)
              nil
          else:
            #i: ((0, 0, 1, 0, 0, None, None, None, None, None, None, None, None, None, None, None), [('Rd', 10, 8), ('imm8', 7, 0)], 'MOV<c> <Rd>,#<imm8>', False)
            #MOV<c> <Rd>,#<imm8>
            #(0, 0, 1, 0, 0, None, None, None, None, None, None, None, None, None, None, None)
            block:
              var Rd : TEnt = Reg(b2int(insn[10,8]))
              var imm8 : TBinary = insn[7,0]
              
              nil
      else:
        if bit(insn, 12):
          if bit(insn, 11):
            if bit(insn, 10):
              if bit(insn, 9):
                #i: ((0, 0, 0, 1, 1, 1, 1, None, None, None, None, None, None, None, None, None), [('imm3', 8, 6), ('Rn', 5, 3), ('Rd', 2, 0)], 'SUB<c> <Rd>,<Rn>,#<imm3>', False)
                #SUB<c> <Rd>,<Rn>,#<imm3>
                #(0, 0, 0, 1, 1, 1, 1, None, None, None, None, None, None, None, None, None)
                block:
                  var imm3 : TBinary = insn[8,6]
                  var Rn : TEnt = Reg(b2int(insn[5,3]))
                  var Rd : TEnt = Reg(b2int(insn[2,0]))
                  
                  nil
              else:
                #i: ((0, 0, 0, 1, 1, 1, 0, None, None, None, None, None, None, None, None, None), [('imm3', 8, 6), ('Rn', 5, 3), ('Rd', 2, 0)], 'ADD<c> <Rd>,<Rn>,#<imm3>', False)
                #ADD<c> <Rd>,<Rn>,#<imm3>
                #(0, 0, 0, 1, 1, 1, 0, None, None, None, None, None, None, None, None, None)
                block:
                  var imm3 : TBinary = insn[8,6]
                  var Rn : TEnt = Reg(b2int(insn[5,3]))
                  var Rd : TEnt = Reg(b2int(insn[2,0]))
                  return z(opADD, t, Rd, Rn, imm3)
                  nil
            else:
              if bit(insn, 9):
                #i: ((0, 0, 0, 1, 1, 0, 1, None, None, None, None, None, None, None, None, None), [('Rm', 8, 6), ('Rn', 5, 3), ('Rd', 2, 0)], 'SUB<c> <Rd>,<Rn>,<Rm>', False)
                #SUB<c> <Rd>,<Rn>,<Rm>
                #(0, 0, 0, 1, 1, 0, 1, None, None, None, None, None, None, None, None, None)
                block:
                  var Rm : TEnt = Reg(b2int(insn[8,6]))
                  var Rn : TEnt = Reg(b2int(insn[5,3]))
                  var Rd : TEnt = Reg(b2int(insn[2,0]))
                  
                  nil
              else:
                #i: ((0, 0, 0, 1, 1, 0, 0, None, None, None, None, None, None, None, None, None), [('Rm', 8, 6), ('Rn', 5, 3), ('Rd', 2, 0)], 'ADD<c> <Rd>,<Rn>,<Rm>', False)
                #ADD<c> <Rd>,<Rn>,<Rm>
                #(0, 0, 0, 1, 1, 0, 0, None, None, None, None, None, None, None, None, None)
                block:
                  var Rm : TEnt = Reg(b2int(insn[8,6]))
                  var Rn : TEnt = Reg(b2int(insn[5,3]))
                  var Rd : TEnt = Reg(b2int(insn[2,0]))
                  return z(opADD, t, Rd, Rn, Rm)
                  nil
          else:
            #i: ((0, 0, 0, 1, 0, None, None, None, None, None, None, None, None, None, None, None), [('imm5', 10, 6), ('Rm', 5, 3), ('Rd', 2, 0)], 'ASR<c> <Rd>,<Rm>,#<imm5>', False)
            #ASR<c> <Rd>,<Rm>,#<imm5>
            #(0, 0, 0, 1, 0, None, None, None, None, None, None, None, None, None, None, None)
            block:
              var imm5 : TBinary = insn[10,6]
              var Rm : TEnt = Reg(b2int(insn[5,3]))
              var Rd : TEnt = Reg(b2int(insn[2,0]))
              return z(opASR, t, Rd, Rd, DIShift(Rm, b"10", imm5))
              nil
        else:
          if bit(insn, 11):
            #i: ((0, 0, 0, 0, 1, None, None, None, None, None, None, None, None, None, None, None), [('imm5', 10, 6), ('Rm', 5, 3), ('Rd', 2, 0)], 'LSR<c> <Rd>,<Rm>,#<imm5>', False)
            #LSR<c> <Rd>,<Rm>,#<imm5>
            #(0, 0, 0, 0, 1, None, None, None, None, None, None, None, None, None, None, None)
            block:
              var imm5 : TBinary = insn[10,6]
              var Rm : TEnt = Reg(b2int(insn[5,3]))
              var Rd : TEnt = Reg(b2int(insn[2,0]))
              
              nil
          else:
            if not bit(insn, 10):
              if not bit(insn, 9):
                if not bit(insn, 8):
                  if not bit(insn, 7):
                    if not bit(insn, 6):
                      #i: ((0, 0, 0, 0, 0, 0, 0, 0, 0, 0, None, None, None, None, None, None), [('Rm', 5, 3), ('Rd', 2, 0)], 'MOVS <Rd>,<Rm> (formerly LSL <Rd>,<Rm>,#0)', True)
                      #MOVS <Rd>,<Rm> (formerly LSL <Rd>,<Rm>,#0)
                      #(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, None, None, None, None, None, None)
                      block:
                        var Rm : TEnt = Reg(b2int(insn[5,3]))
                        var Rd : TEnt = Reg(b2int(insn[2,0]))
                        
                        nil
            #i: ((0, 0, 0, 0, 0, None, None, None, None, None, None, None, None, None, None, None), [('imm5', 10, 6), ('Rm', 5, 3), ('Rd', 2, 0)], 'LSL<c> <Rd>,<Rm>,#<imm5>', False)
            #LSL<c> <Rd>,<Rm>,#<imm5>
            #(0, 0, 0, 0, 0, None, None, None, None, None, None, None, None, None, None, None)
            block:
              var imm5 : TBinary = insn[10,6]
              var Rm : TEnt = Reg(b2int(insn[5,3]))
              var Rd : TEnt = Reg(b2int(insn[2,0]))
              
              nil
  return nil

proc processInsn32*(insn : TBinary, t : int) : PInsn =
  if bit(insn, 28):
    if bit(insn, 27):
      if bit(insn, 26):
        if bit(insn, 25):
          if not bit(insn, 24):
            if bit(insn, 20):
              if bit(insn, 4):
                #i: ((1, 1, 1, 1, 1, 1, 1, 0, None, None, None, 1, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, 1, None, None, None, None), [('opc1', 23, 21), ('CRn', 19, 16), ('Rt', 15, 12), ('coproc', 11, 8), ('opc2', 7, 5), ('CRm', 3, 0)], 'MRC2<c> <coproc>,<opc1>,<Rt>,<CRn>,<CRm>{,<opc2>}', False)
                #MRC2<c> <coproc>,<opc1>,<Rt>,<CRn>,<CRm>{,<opc2>}
                #(1, 1, 1, 1, 1, 1, 1, 0, None, None, None, 1, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, 1, None, None, None, None)
                block:
                  var opc1 : TBinary = insn[23,21]
                  var CRn : TBinary = insn[19,16]
                  var Rt : TEnt = Reg(b2int(insn[15,12]))
                  var coproc : TBinary = insn[11,8]
                  var opc2 : TBinary = insn[7,5]
                  var CRm : TBinary = insn[3,0]
                  
                  nil
            else:
              if bit(insn, 4):
                #i: ((1, 1, 1, 1, 1, 1, 1, 0, None, None, None, 0, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, 1, None, None, None, None), [('opc1', 23, 21), ('CRn', 19, 16), ('Rt', 15, 12), ('coproc', 11, 8), ('opc2', 7, 5), ('CRm', 3, 0)], 'MCR2<c> <coproc>,<opc1>,<Rt>,<CRn>,<CRm>{,<opc2>}', False)
                #MCR2<c> <coproc>,<opc1>,<Rt>,<CRn>,<CRm>{,<opc2>}
                #(1, 1, 1, 1, 1, 1, 1, 0, None, None, None, 0, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, 1, None, None, None, None)
                block:
                  var opc1 : TBinary = insn[23,21]
                  var CRn : TBinary = insn[19,16]
                  var Rt : TEnt = Reg(b2int(insn[15,12]))
                  var coproc : TBinary = insn[11,8]
                  var opc2 : TBinary = insn[7,5]
                  var CRm : TBinary = insn[3,0]
                  
                  nil
            if not bit(insn, 4):
              #i: ((1, 1, 1, 1, 1, 1, 1, 0, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, 0, None, None, None, None), [('opc1', 23, 20), ('CRn', 19, 16), ('CRd', 15, 12), ('coproc', 11, 8), ('opc2', 7, 5), ('CRm', 3, 0)], 'CDP2<c> <coproc>,<opc1>,<CRd>,<CRn>,<CRm>,<opc2>', False)
              #CDP2<c> <coproc>,<opc1>,<CRd>,<CRn>,<CRm>,<opc2>
              #(1, 1, 1, 1, 1, 1, 1, 0, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, 0, None, None, None, None)
              block:
                var opc1 : TBinary = insn[23,20]
                var CRn : TBinary = insn[19,16]
                var CRd : TBinary = insn[15,12]
                var coproc : TBinary = insn[11,8]
                var opc2 : TBinary = insn[7,5]
                var CRm : TBinary = insn[3,0]
                return z(opCDP2, 0, coproc, opc1, CRd, CRn, CRm, opc2)
                nil
        else:
          if not bit(insn, 24):
            if not bit(insn, 23):
              if bit(insn, 22):
                if not bit(insn, 21):
                  if bit(insn, 20):
                    #i: ((1, 1, 1, 1, 1, 1, 0, 0, 0, 1, 0, 1, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None), [('Rt2', 19, 16), ('Rt', 15, 12), ('coproc', 11, 8), ('opc1', 7, 4), ('CRm', 3, 0)], 'MRRC2<c> <coproc>,<opc>,<Rt>,<Rt2>,<CRm>', True)
                    #MRRC2<c> <coproc>,<opc>,<Rt>,<Rt2>,<CRm>
                    #(1, 1, 1, 1, 1, 1, 0, 0, 0, 1, 0, 1, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None)
                    block:
                      var Rt2 : TBinary = insn[19,16]
                      var Rt : TEnt = Reg(b2int(insn[15,12]))
                      var coproc : TBinary = insn[11,8]
                      var opc1 : TBinary = insn[7,4]
                      var CRm : TBinary = insn[3,0]
                      
                      nil
                  else:
                    #i: ((1, 1, 1, 1, 1, 1, 0, 0, 0, 1, 0, 0, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None), [('Rt2', 19, 16), ('Rt', 15, 12), ('coproc', 11, 8), ('opc1', 7, 4), ('CRm', 3, 0)], 'MCRR2<c> <coproc>,<opc1>,<Rt>,<Rt2>,<CRm>', True)
                    #MCRR2<c> <coproc>,<opc1>,<Rt>,<Rt2>,<CRm>
                    #(1, 1, 1, 1, 1, 1, 0, 0, 0, 1, 0, 0, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None)
                    block:
                      var Rt2 : TBinary = insn[19,16]
                      var Rt : TEnt = Reg(b2int(insn[15,12]))
                      var coproc : TBinary = insn[11,8]
                      var opc1 : TBinary = insn[7,4]
                      var CRm : TBinary = insn[3,0]
                      
                      nil
          if bit(insn, 20):
            #i: ((1, 1, 1, 1, 1, 1, 0, None, None, None, None, 1, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None), [('P', 24, 24), ('U', 23, 23), ('D', 22, 22), ('W', 21, 21), ('Rn', 19, 16), ('CRd', 15, 12), ('coproc', 11, 8), ('imm8', 7, 0)], 'LDC2{L}<c> <coproc>,<CRd>,[<Rn>],<option>', False)
            #LDC2{L}<c> <coproc>,<CRd>,[<Rn>],<option>
            #(1, 1, 1, 1, 1, 1, 0, None, None, None, None, 1, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None)
            block:
              var P : TBinary = insn[24,24]
              var U : TBinary = insn[23,23]
              var D : TBinary = insn[22,22]
              var W : TBinary = insn[21,21]
              var Rn : TEnt = Reg(b2int(insn[19,16]))
              var CRd : TBinary = insn[15,12]
              var coproc : TBinary = insn[11,8]
              var imm8 : TBinary = insn[7,0]
              if P == b"0" and W == b"0": break
              return z(opLDC2, 0, coproc, Deref(Rn, @cat(imm8, b"00"), P.bit, W.bit, U.bit))
              nil
          else:
            #i: ((1, 1, 1, 1, 1, 1, 0, None, None, None, None, 0, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None), [('P', 24, 24), ('U', 23, 23), ('N', 22, 22), ('W', 21, 21), ('Rn', 19, 16), ('CRd', 15, 12), ('coproc', 11, 8), ('imm8', 7, 0)], 'STC2{L}<c> <coproc>,<CRd>,[<Rn>],<option>', False)
            #STC2{L}<c> <coproc>,<CRd>,[<Rn>],<option>
            #(1, 1, 1, 1, 1, 1, 0, None, None, None, None, 0, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None)
            block:
              var P : TBinary = insn[24,24]
              var U : TBinary = insn[23,23]
              var N : TBinary = insn[22,22]
              var W : TBinary = insn[21,21]
              var Rn : TEnt = Reg(b2int(insn[19,16]))
              var CRd : TBinary = insn[15,12]
              var coproc : TBinary = insn[11,8]
              var imm8 : TBinary = insn[7,0]
              
              nil
      else:
        if bit(insn, 25):
          if bit(insn, 24):
            if bit(insn, 23):
              if bit(insn, 22):
                if bit(insn, 21):
                  if not bit(insn, 20):
                    if not bit(insn, 7):
                      if not bit(insn, 6):
                        if not bit(insn, 5):
                          if not bit(insn, 4):
                            #i: ((1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, None, None, None, None, None, None, None, None, None, None, None, None, 0, 0, 0, 0, None, None, None, None), [('Rn', 19, 16), ('RdLo', 15, 12), ('RdHi', 11, 8), ('Rm', 3, 0)], 'UMLAL<c> <RdLo>,<RdHi>,<Rn>,<Rm>', False)
                            #UMLAL<c> <RdLo>,<RdHi>,<Rn>,<Rm>
                            #(1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, None, None, None, None, None, None, None, None, None, None, None, None, 0, 0, 0, 0, None, None, None, None)
                            block:
                              var Rn : TEnt = Reg(b2int(insn[19,16]))
                              var RdLo : TBinary = insn[15,12]
                              var RdHi : TBinary = insn[11,8]
                              var Rm : TEnt = Reg(b2int(insn[3,0]))
                              
                              nil
                else:
                  if not bit(insn, 20):
                    if not bit(insn, 7):
                      if not bit(insn, 6):
                        if not bit(insn, 5):
                          if not bit(insn, 4):
                            #i: ((1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0, 0, None, None, None, None, None, None, None, None, None, None, None, None, 0, 0, 0, 0, None, None, None, None), [('Rn', 19, 16), ('RdLo', 15, 12), ('RdHi', 11, 8), ('Rm', 3, 0)], 'SMLAL<c> <RdLo>,<RdHi>,<Rn>,<Rm>', False)
                            #SMLAL<c> <RdLo>,<RdHi>,<Rn>,<Rm>
                            #(1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0, 0, None, None, None, None, None, None, None, None, None, None, None, None, 0, 0, 0, 0, None, None, None, None)
                            block:
                              var Rn : TEnt = Reg(b2int(insn[19,16]))
                              var RdLo : TBinary = insn[15,12]
                              var RdHi : TBinary = insn[11,8]
                              var Rm : TEnt = Reg(b2int(insn[3,0]))
                              
                              nil
              else:
                if bit(insn, 21):
                  if bit(insn, 20):
                    if bit(insn, 15):
                      if bit(insn, 14):
                        if bit(insn, 13):
                          if bit(insn, 12):
                            if bit(insn, 7):
                              if bit(insn, 6):
                                if bit(insn, 5):
                                  if bit(insn, 4):
                                    #i: ((1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 1, 1, None, None, None, None, 1, 1, 1, 1, None, None, None, None, 1, 1, 1, 1, None, None, None, None), [('Rn', 19, 16), ('Rd', 11, 8), ('Rm', 3, 0)], 'UDIV<c> <Rd>,<Rn>,<Rm>', False)
                                    #UDIV<c> <Rd>,<Rn>,<Rm>
                                    #(1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 1, 1, None, None, None, None, 1, 1, 1, 1, None, None, None, None, 1, 1, 1, 1, None, None, None, None)
                                    block:
                                      var Rn : TEnt = Reg(b2int(insn[19,16]))
                                      var Rd : TEnt = Reg(b2int(insn[11,8]))
                                      var Rm : TEnt = Reg(b2int(insn[3,0]))
                                      
                                      nil
                  else:
                    if not bit(insn, 7):
                      if not bit(insn, 6):
                        if not bit(insn, 5):
                          if not bit(insn, 4):
                            #i: ((1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 1, 0, None, None, None, None, None, None, None, None, None, None, None, None, 0, 0, 0, 0, None, None, None, None), [('Rn', 19, 16), ('RdLo', 15, 12), ('RdHi', 11, 8), ('Rm', 3, 0)], 'UMULL<c> <RdLo>,<RdHi>,<Rn>,<Rm>', False)
                            #UMULL<c> <RdLo>,<RdHi>,<Rn>,<Rm>
                            #(1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 1, 0, None, None, None, None, None, None, None, None, None, None, None, None, 0, 0, 0, 0, None, None, None, None)
                            block:
                              var Rn : TEnt = Reg(b2int(insn[19,16]))
                              var RdLo : TBinary = insn[15,12]
                              var RdHi : TBinary = insn[11,8]
                              var Rm : TEnt = Reg(b2int(insn[3,0]))
                              
                              nil
                else:
                  if bit(insn, 20):
                    if bit(insn, 15):
                      if bit(insn, 14):
                        if bit(insn, 13):
                          if bit(insn, 12):
                            if bit(insn, 7):
                              if bit(insn, 6):
                                if bit(insn, 5):
                                  if bit(insn, 4):
                                    #i: ((1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 0, 1, None, None, None, None, 1, 1, 1, 1, None, None, None, None, 1, 1, 1, 1, None, None, None, None), [('Rn', 19, 16), ('Rd', 11, 8), ('Rm', 3, 0)], 'SDIV<c> <Rd>,<Rn>,<Rm>', False)
                                    #SDIV<c> <Rd>,<Rn>,<Rm>
                                    #(1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 0, 1, None, None, None, None, 1, 1, 1, 1, None, None, None, None, 1, 1, 1, 1, None, None, None, None)
                                    block:
                                      var Rn : TEnt = Reg(b2int(insn[19,16]))
                                      var Rd : TEnt = Reg(b2int(insn[11,8]))
                                      var Rm : TEnt = Reg(b2int(insn[3,0]))
                                      
                                      nil
                  else:
                    if not bit(insn, 7):
                      if not bit(insn, 6):
                        if not bit(insn, 5):
                          if not bit(insn, 4):
                            #i: ((1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 0, 0, None, None, None, None, None, None, None, None, None, None, None, None, 0, 0, 0, 0, None, None, None, None), [('Rn', 19, 16), ('RdLo', 15, 12), ('RdHi', 11, 8), ('Rm', 3, 0)], 'SMULL<c> <RdLo>,<RdHi>,<Rn>,<Rm>', False)
                            #SMULL<c> <RdLo>,<RdHi>,<Rn>,<Rm>
                            #(1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 0, 0, None, None, None, None, None, None, None, None, None, None, None, None, 0, 0, 0, 0, None, None, None, None)
                            block:
                              var Rn : TEnt = Reg(b2int(insn[19,16]))
                              var RdLo : TBinary = insn[15,12]
                              var RdHi : TBinary = insn[11,8]
                              var Rm : TEnt = Reg(b2int(insn[3,0]))
                              
                              nil
            else:
              if not bit(insn, 22):
                if not bit(insn, 21):
                  if not bit(insn, 20):
                    if bit(insn, 15):
                      if bit(insn, 14):
                        if bit(insn, 13):
                          if bit(insn, 12):
                            if not bit(insn, 7):
                              if not bit(insn, 6):
                                if not bit(insn, 5):
                                  if not bit(insn, 4):
                                    #i: ((1, 1, 1, 1, 1, 0, 1, 1, 0, 0, 0, 0, None, None, None, None, 1, 1, 1, 1, None, None, None, None, 0, 0, 0, 0, None, None, None, None), [('Rn', 19, 16), ('Rd', 11, 8), ('Rm', 3, 0)], 'MUL<c> <Rd>,<Rn>,<Rm>', True)
                                    #MUL<c> <Rd>,<Rn>,<Rm>
                                    #(1, 1, 1, 1, 1, 0, 1, 1, 0, 0, 0, 0, None, None, None, None, 1, 1, 1, 1, None, None, None, None, 0, 0, 0, 0, None, None, None, None)
                                    block:
                                      var Rn : TEnt = Reg(b2int(insn[19,16]))
                                      var Rd : TEnt = Reg(b2int(insn[11,8]))
                                      var Rm : TEnt = Reg(b2int(insn[3,0]))
                                      
                                      nil
                    if not bit(insn, 7):
                      if not bit(insn, 6):
                        if not bit(insn, 5):
                          if bit(insn, 4):
                            #i: ((1, 1, 1, 1, 1, 0, 1, 1, 0, 0, 0, 0, None, None, None, None, None, None, None, None, None, None, None, None, 0, 0, 0, 1, None, None, None, None), [('Rn', 19, 16), ('Ra', 15, 12), ('Rd', 11, 8), ('Rm', 3, 0)], 'MLS<c> <Rd>,<Rn>,<Rm>,<Ra>', False)
                            #MLS<c> <Rd>,<Rn>,<Rm>,<Ra>
                            #(1, 1, 1, 1, 1, 0, 1, 1, 0, 0, 0, 0, None, None, None, None, None, None, None, None, None, None, None, None, 0, 0, 0, 1, None, None, None, None)
                            block:
                              var Rn : TEnt = Reg(b2int(insn[19,16]))
                              var Ra : TEnt = Reg(b2int(insn[15,12]))
                              var Rd : TEnt = Reg(b2int(insn[11,8]))
                              var Rm : TEnt = Reg(b2int(insn[3,0]))
                              
                              nil
                          else:
                            #i: ((1, 1, 1, 1, 1, 0, 1, 1, 0, 0, 0, 0, None, None, None, None, None, None, None, None, None, None, None, None, 0, 0, 0, 0, None, None, None, None), [('Rn', 19, 16), ('Ra', 15, 12), ('Rd', 11, 8), ('Rm', 3, 0)], 'MLA<c> <Rd>,<Rn>,<Rm>,<Ra>', False)
                            #MLA<c> <Rd>,<Rn>,<Rm>,<Ra>
                            #(1, 1, 1, 1, 1, 0, 1, 1, 0, 0, 0, 0, None, None, None, None, None, None, None, None, None, None, None, None, 0, 0, 0, 0, None, None, None, None)
                            block:
                              var Rn : TEnt = Reg(b2int(insn[19,16]))
                              var Ra : TEnt = Reg(b2int(insn[15,12]))
                              var Rd : TEnt = Reg(b2int(insn[11,8]))
                              var Rm : TEnt = Reg(b2int(insn[3,0]))
                              
                              nil
          else:
            if bit(insn, 23):
              if not bit(insn, 22):
                if bit(insn, 21):
                  if bit(insn, 20):
                    if bit(insn, 15):
                      if bit(insn, 14):
                        if bit(insn, 13):
                          if bit(insn, 12):
                            if bit(insn, 7):
                              if not bit(insn, 6):
                                if not bit(insn, 5):
                                  if not bit(insn, 4):
                                    #i: ((1, 1, 1, 1, 1, 0, 1, 0, 1, 0, 1, 1, None, None, None, None, 1, 1, 1, 1, None, None, None, None, 1, 0, 0, 0, None, None, None, None), [('Rm', 19, 16), ('Rd', 11, 8), ('Rm_P', 3, 0)], 'CLZ<c> <Rd>,<Rm>', False)
                                    #CLZ<c> <Rd>,<Rm>
                                    #(1, 1, 1, 1, 1, 0, 1, 0, 1, 0, 1, 1, None, None, None, None, 1, 1, 1, 1, None, None, None, None, 1, 0, 0, 0, None, None, None, None)
                                    block:
                                      var Rm : TEnt = Reg(b2int(insn[19,16]))
                                      var Rd : TEnt = Reg(b2int(insn[11,8]))
                                      var Rm_P : TBinary = insn[3,0]
                                      return z(opCLZ, 0, Rd, Rm)
                                      nil
                else:
                  if bit(insn, 20):
                    if bit(insn, 15):
                      if bit(insn, 14):
                        if bit(insn, 13):
                          if bit(insn, 12):
                            if bit(insn, 7):
                              if not bit(insn, 6):
                                if bit(insn, 5):
                                  if bit(insn, 4):
                                    #i: ((1, 1, 1, 1, 1, 0, 1, 0, 1, 0, 0, 1, None, None, None, None, 1, 1, 1, 1, None, None, None, None, 1, 0, 1, 1, None, None, None, None), [('Rm', 19, 16), ('Rd', 11, 8), ('Rm_P', 3, 0)], 'REVSH<c>.W <Rd>,<Rm>', False)
                                    #REVSH<c>.W <Rd>,<Rm>
                                    #(1, 1, 1, 1, 1, 0, 1, 0, 1, 0, 0, 1, None, None, None, None, 1, 1, 1, 1, None, None, None, None, 1, 0, 1, 1, None, None, None, None)
                                    block:
                                      var Rm : TEnt = Reg(b2int(insn[19,16]))
                                      var Rd : TEnt = Reg(b2int(insn[11,8]))
                                      var Rm_P : TBinary = insn[3,0]
                                      
                                      nil
                                  else:
                                    #i: ((1, 1, 1, 1, 1, 0, 1, 0, 1, 0, 0, 1, None, None, None, None, 1, 1, 1, 1, None, None, None, None, 1, 0, 1, 0, None, None, None, None), [('Rm', 19, 16), ('Rd', 11, 8), ('Rm_P', 3, 0)], 'RBIT<c> <Rd>,<Rm>', False)
                                    #RBIT<c> <Rd>,<Rm>
                                    #(1, 1, 1, 1, 1, 0, 1, 0, 1, 0, 0, 1, None, None, None, None, 1, 1, 1, 1, None, None, None, None, 1, 0, 1, 0, None, None, None, None)
                                    block:
                                      var Rm : TEnt = Reg(b2int(insn[19,16]))
                                      var Rd : TEnt = Reg(b2int(insn[11,8]))
                                      var Rm_P : TBinary = insn[3,0]
                                      
                                      nil
                                else:
                                  if bit(insn, 4):
                                    #i: ((1, 1, 1, 1, 1, 0, 1, 0, 1, 0, 0, 1, None, None, None, None, 1, 1, 1, 1, None, None, None, None, 1, 0, 0, 1, None, None, None, None), [('Rm', 19, 16), ('Rd', 11, 8), ('Rm_P', 3, 0)], 'REV16<c>.W <Rd>,<Rm>', False)
                                    #REV16<c>.W <Rd>,<Rm>
                                    #(1, 1, 1, 1, 1, 0, 1, 0, 1, 0, 0, 1, None, None, None, None, 1, 1, 1, 1, None, None, None, None, 1, 0, 0, 1, None, None, None, None)
                                    block:
                                      var Rm : TEnt = Reg(b2int(insn[19,16]))
                                      var Rd : TEnt = Reg(b2int(insn[11,8]))
                                      var Rm_P : TBinary = insn[3,0]
                                      
                                      nil
                                  else:
                                    #i: ((1, 1, 1, 1, 1, 0, 1, 0, 1, 0, 0, 1, None, None, None, None, 1, 1, 1, 1, None, None, None, None, 1, 0, 0, 0, None, None, None, None), [('Rm', 19, 16), ('Rd', 11, 8), ('Rm_P', 3, 0)], 'REV<c>.W <Rd>,<Rm>', False)
                                    #REV<c>.W <Rd>,<Rm>
                                    #(1, 1, 1, 1, 1, 0, 1, 0, 1, 0, 0, 1, None, None, None, None, 1, 1, 1, 1, None, None, None, None, 1, 0, 0, 0, None, None, None, None)
                                    block:
                                      var Rm : TEnt = Reg(b2int(insn[19,16]))
                                      var Rd : TEnt = Reg(b2int(insn[11,8]))
                                      var Rm_P : TBinary = insn[3,0]
                                      
                                      nil
            else:
              if bit(insn, 22):
                if bit(insn, 21):
                  if bit(insn, 15):
                    if bit(insn, 14):
                      if bit(insn, 13):
                        if bit(insn, 12):
                          if not bit(insn, 7):
                            if not bit(insn, 6):
                              if not bit(insn, 5):
                                if not bit(insn, 4):
                                  #i: ((1, 1, 1, 1, 1, 0, 1, 0, 0, 1, 1, None, None, None, None, None, 1, 1, 1, 1, None, None, None, None, 0, 0, 0, 0, None, None, None, None), [('S', 20, 20), ('Rn', 19, 16), ('Rd', 11, 8), ('Rm', 3, 0)], 'ROR{S}<c>.W <Rd>,<Rn>,<Rm>', False)
                                  #ROR{S}<c>.W <Rd>,<Rn>,<Rm>
                                  #(1, 1, 1, 1, 1, 0, 1, 0, 0, 1, 1, None, None, None, None, None, 1, 1, 1, 1, None, None, None, None, 0, 0, 0, 0, None, None, None, None)
                                  block:
                                    var S : int = b2int(insn[20,20])
                                    var Rn : TEnt = Reg(b2int(insn[19,16]))
                                    var Rd : TEnt = Reg(b2int(insn[11,8]))
                                    var Rm : TEnt = Reg(b2int(insn[3,0]))
                                    
                                    nil
                else:
                  if bit(insn, 20):
                    if bit(insn, 19):
                      if bit(insn, 18):
                        if bit(insn, 17):
                          if bit(insn, 16):
                            if bit(insn, 15):
                              if bit(insn, 14):
                                if bit(insn, 13):
                                  if bit(insn, 12):
                                    if bit(insn, 7):
                                      if not bit(insn, 6):
                                        #i: ((1, 1, 1, 1, 1, 0, 1, 0, 0, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, None, None, None, None, 1, 0, None, None, None, None, None, None), [('Rd', 11, 8), ('rotate', 5, 4), ('Rm', 3, 0)], 'UXTB<c>.W <Rd>,<Rm>{,<rotation>}', False)
                                        #UXTB<c>.W <Rd>,<Rm>{,<rotation>}
                                        #(1, 1, 1, 1, 1, 0, 1, 0, 0, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, None, None, None, None, 1, 0, None, None, None, None, None, None)
                                        block:
                                          var Rd : TEnt = Reg(b2int(insn[11,8]))
                                          var rotate : TBinary = insn[5,4]
                                          var Rm : TEnt = Reg(b2int(insn[3,0]))
                                          return z(opUXTB, 0, Rd, Shift(Rm, ROR, @cat(rotate, b"000")))
                                          nil
                  else:
                    if bit(insn, 19):
                      if bit(insn, 18):
                        if bit(insn, 17):
                          if bit(insn, 16):
                            if bit(insn, 15):
                              if bit(insn, 14):
                                if bit(insn, 13):
                                  if bit(insn, 12):
                                    if bit(insn, 7):
                                      if not bit(insn, 6):
                                        #i: ((1, 1, 1, 1, 1, 0, 1, 0, 0, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, None, None, None, None, 1, 0, None, None, None, None, None, None), [('Rd', 11, 8), ('rotate', 5, 4), ('Rm', 3, 0)], 'SXTB<c>.W <Rd>,<Rm>{,<rotation>}', False)
                                        #SXTB<c>.W <Rd>,<Rm>{,<rotation>}
                                        #(1, 1, 1, 1, 1, 0, 1, 0, 0, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, None, None, None, None, 1, 0, None, None, None, None, None, None)
                                        block:
                                          var Rd : TEnt = Reg(b2int(insn[11,8]))
                                          var rotate : TBinary = insn[5,4]
                                          var Rm : TEnt = Reg(b2int(insn[3,0]))
                                          
                                          nil
                  if bit(insn, 15):
                    if bit(insn, 14):
                      if bit(insn, 13):
                        if bit(insn, 12):
                          if not bit(insn, 7):
                            if not bit(insn, 6):
                              if not bit(insn, 5):
                                if not bit(insn, 4):
                                  #i: ((1, 1, 1, 1, 1, 0, 1, 0, 0, 1, 0, None, None, None, None, None, 1, 1, 1, 1, None, None, None, None, 0, 0, 0, 0, None, None, None, None), [('S', 20, 20), ('Rn', 19, 16), ('Rd', 11, 8), ('Rm', 3, 0)], 'ASR{S}<c>.W <Rd>,<Rn>,<Rm>', False)
                                  #ASR{S}<c>.W <Rd>,<Rn>,<Rm>
                                  #(1, 1, 1, 1, 1, 0, 1, 0, 0, 1, 0, None, None, None, None, None, 1, 1, 1, 1, None, None, None, None, 0, 0, 0, 0, None, None, None, None)
                                  block:
                                    var S : int = b2int(insn[20,20])
                                    var Rn : TEnt = Reg(b2int(insn[19,16]))
                                    var Rd : TEnt = Reg(b2int(insn[11,8]))
                                    var Rm : TEnt = Reg(b2int(insn[3,0]))
                                    return z(opASR, S, Rd, Rn, Rm)
                                    nil
              else:
                if bit(insn, 21):
                  if bit(insn, 15):
                    if bit(insn, 14):
                      if bit(insn, 13):
                        if bit(insn, 12):
                          if not bit(insn, 7):
                            if not bit(insn, 6):
                              if not bit(insn, 5):
                                if not bit(insn, 4):
                                  #i: ((1, 1, 1, 1, 1, 0, 1, 0, 0, 0, 1, None, None, None, None, None, 1, 1, 1, 1, None, None, None, None, 0, 0, 0, 0, None, None, None, None), [('S', 20, 20), ('Rn', 19, 16), ('Rd', 11, 8), ('Rm', 3, 0)], 'LSR{S}<c>.W <Rd>,<Rn>,<Rm>', False)
                                  #LSR{S}<c>.W <Rd>,<Rn>,<Rm>
                                  #(1, 1, 1, 1, 1, 0, 1, 0, 0, 0, 1, None, None, None, None, None, 1, 1, 1, 1, None, None, None, None, 0, 0, 0, 0, None, None, None, None)
                                  block:
                                    var S : int = b2int(insn[20,20])
                                    var Rn : TEnt = Reg(b2int(insn[19,16]))
                                    var Rd : TEnt = Reg(b2int(insn[11,8]))
                                    var Rm : TEnt = Reg(b2int(insn[3,0]))
                                    
                                    nil
                else:
                  if bit(insn, 20):
                    if bit(insn, 19):
                      if bit(insn, 18):
                        if bit(insn, 17):
                          if bit(insn, 16):
                            if bit(insn, 15):
                              if bit(insn, 14):
                                if bit(insn, 13):
                                  if bit(insn, 12):
                                    if bit(insn, 7):
                                      if not bit(insn, 6):
                                        #i: ((1, 1, 1, 1, 1, 0, 1, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, None, None, None, None, 1, 0, None, None, None, None, None, None), [('Rd', 11, 8), ('rotate', 5, 4), ('Rm', 3, 0)], 'UXTH<c>.W <Rd>,<Rm>{,<rotation>}', False)
                                        #UXTH<c>.W <Rd>,<Rm>{,<rotation>}
                                        #(1, 1, 1, 1, 1, 0, 1, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, None, None, None, None, 1, 0, None, None, None, None, None, None)
                                        block:
                                          var Rd : TEnt = Reg(b2int(insn[11,8]))
                                          var rotate : TBinary = insn[5,4]
                                          var Rm : TEnt = Reg(b2int(insn[3,0]))
                                          return z(opUXTH, 0, Rd, Shift(Rm, ROR, @cat(rotate, b"000")))
                                          nil
                  else:
                    if bit(insn, 19):
                      if bit(insn, 18):
                        if bit(insn, 17):
                          if bit(insn, 16):
                            if bit(insn, 15):
                              if bit(insn, 14):
                                if bit(insn, 13):
                                  if bit(insn, 12):
                                    if bit(insn, 7):
                                      if not bit(insn, 6):
                                        #i: ((1, 1, 1, 1, 1, 0, 1, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, None, None, None, None, 1, 0, None, None, None, None, None, None), [('Rd', 11, 8), ('rotate', 5, 4), ('Rm', 3, 0)], 'SXTH<c>.W <Rd>,<Rm>{,<rotation>}', False)
                                        #SXTH<c>.W <Rd>,<Rm>{,<rotation>}
                                        #(1, 1, 1, 1, 1, 0, 1, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, None, None, None, None, 1, 0, None, None, None, None, None, None)
                                        block:
                                          var Rd : TEnt = Reg(b2int(insn[11,8]))
                                          var rotate : TBinary = insn[5,4]
                                          var Rm : TEnt = Reg(b2int(insn[3,0]))
                                          
                                          nil
                  if bit(insn, 15):
                    if bit(insn, 14):
                      if bit(insn, 13):
                        if bit(insn, 12):
                          if not bit(insn, 7):
                            if not bit(insn, 6):
                              if not bit(insn, 5):
                                if not bit(insn, 4):
                                  #i: ((1, 1, 1, 1, 1, 0, 1, 0, 0, 0, 0, None, None, None, None, None, 1, 1, 1, 1, None, None, None, None, 0, 0, 0, 0, None, None, None, None), [('S', 20, 20), ('Rn', 19, 16), ('Rd', 11, 8), ('Rm', 3, 0)], 'LSL{S}<c>.W <Rd>,<Rn>,<Rm>', False)
                                  #LSL{S}<c>.W <Rd>,<Rn>,<Rm>
                                  #(1, 1, 1, 1, 1, 0, 1, 0, 0, 0, 0, None, None, None, None, None, 1, 1, 1, 1, None, None, None, None, 0, 0, 0, 0, None, None, None, None)
                                  block:
                                    var S : int = b2int(insn[20,20])
                                    var Rn : TEnt = Reg(b2int(insn[19,16]))
                                    var Rd : TEnt = Reg(b2int(insn[11,8]))
                                    var Rm : TEnt = Reg(b2int(insn[3,0]))
                                    
                                    nil
        else:
          if bit(insn, 24):
            if bit(insn, 23):
              if not bit(insn, 22):
                if bit(insn, 21):
                  if bit(insn, 20):
                    #i: ((1, 1, 1, 1, 1, 0, 0, 1, 1, 0, 1, 1, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None), [('Rn', 19, 16), ('Rt', 15, 12), ('imm12', 11, 0)], 'LDRSH<c> <Rt>,[<Rn>,#<imm12>]', False)
                    #LDRSH<c> <Rt>,[<Rn>,#<imm12>]
                    #(1, 1, 1, 1, 1, 0, 0, 1, 1, 0, 1, 1, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None)
                    block:
                      var Rn : TEnt = Reg(b2int(insn[19,16]))
                      var Rt : TEnt = Reg(b2int(insn[15,12]))
                      var imm12 : TBinary = insn[11,0]
                      
                      nil
                else:
                  if bit(insn, 20):
                    if bit(insn, 15):
                      if bit(insn, 14):
                        if bit(insn, 13):
                          if bit(insn, 12):
                            #i: ((1, 1, 1, 1, 1, 0, 0, 1, 1, 0, 0, 1, None, None, None, None, 1, 1, 1, 1, None, None, None, None, None, None, None, None, None, None, None, None), [('Rn', 19, 16), ('imm12', 11, 0)], 'PLI<c> [<Rn>,#<imm12>]', True)
                            #PLI<c> [<Rn>,#<imm12>]
                            #(1, 1, 1, 1, 1, 0, 0, 1, 1, 0, 0, 1, None, None, None, None, 1, 1, 1, 1, None, None, None, None, None, None, None, None, None, None, None, None)
                            block:
                              var Rn : TEnt = Reg(b2int(insn[19,16]))
                              var imm12 : TBinary = insn[11,0]
                              
                              nil
                    #i: ((1, 1, 1, 1, 1, 0, 0, 1, 1, 0, 0, 1, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None), [('Rn', 19, 16), ('Rt', 15, 12), ('imm12', 11, 0)], 'LDRSB<c> <Rt>,[<Rn>,#<imm12>]', False)
                    #LDRSB<c> <Rt>,[<Rn>,#<imm12>]
                    #(1, 1, 1, 1, 1, 0, 0, 1, 1, 0, 0, 1, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None)
                    block:
                      var Rn : TEnt = Reg(b2int(insn[19,16]))
                      var Rt : TEnt = Reg(b2int(insn[15,12]))
                      var imm12 : TBinary = insn[11,0]
                      
                      nil
            else:
              if not bit(insn, 22):
                if bit(insn, 21):
                  if bit(insn, 20):
                    if bit(insn, 11):
                      if bit(insn, 10):
                        if bit(insn, 9):
                          if not bit(insn, 8):
                            #i: ((1, 1, 1, 1, 1, 0, 0, 1, 0, 0, 1, 1, None, None, None, None, None, None, None, None, 1, 1, 1, 0, None, None, None, None, None, None, None, None), [('Rn', 19, 16), ('Rt', 15, 12), ('imm8', 7, 0)], 'LDRSHT<c> <Rt>,[<Rn>,#<imm8>]', True)
                            #LDRSHT<c> <Rt>,[<Rn>,#<imm8>]
                            #(1, 1, 1, 1, 1, 0, 0, 1, 0, 0, 1, 1, None, None, None, None, None, None, None, None, 1, 1, 1, 0, None, None, None, None, None, None, None, None)
                            block:
                              var Rn : TEnt = Reg(b2int(insn[19,16]))
                              var Rt : TEnt = Reg(b2int(insn[15,12]))
                              var imm8 : TBinary = insn[7,0]
                              
                              nil
                      #i: ((1, 1, 1, 1, 1, 0, 0, 1, 0, 0, 1, 1, None, None, None, None, None, None, None, None, 1, None, None, None, None, None, None, None, None, None, None, None), [('Rn', 19, 16), ('Rt', 15, 12), ('P', 10, 10), ('U', 9, 9), ('W', 8, 8), ('imm8', 7, 0)], 'LDRSH<c> <Rt>,[<Rn>,#+/-<imm8>]!', False)
                      #LDRSH<c> <Rt>,[<Rn>,#+/-<imm8>]!
                      #(1, 1, 1, 1, 1, 0, 0, 1, 0, 0, 1, 1, None, None, None, None, None, None, None, None, 1, None, None, None, None, None, None, None, None, None, None, None)
                      block:
                        var Rn : TEnt = Reg(b2int(insn[19,16]))
                        var Rt : TEnt = Reg(b2int(insn[15,12]))
                        var P : TBinary = insn[10,10]
                        var U : TBinary = insn[9,9]
                        var W : TBinary = insn[8,8]
                        var imm8 : TBinary = insn[7,0]
                        
                        nil
                    else:
                      if not bit(insn, 10):
                        if not bit(insn, 9):
                          if not bit(insn, 8):
                            if not bit(insn, 7):
                              if not bit(insn, 6):
                                #i: ((1, 1, 1, 1, 1, 0, 0, 1, 0, 0, 1, 1, None, None, None, None, None, None, None, None, 0, 0, 0, 0, 0, 0, None, None, None, None, None, None), [('Rn', 19, 16), ('Rt', 15, 12), ('imm2', 5, 4), ('Rm', 3, 0)], 'LDRSH<c>.W <Rt>,[<Rn>,<Rm>{,LSL #<imm2>}]', False)
                                #LDRSH<c>.W <Rt>,[<Rn>,<Rm>{,LSL #<imm2>}]
                                #(1, 1, 1, 1, 1, 0, 0, 1, 0, 0, 1, 1, None, None, None, None, None, None, None, None, 0, 0, 0, 0, 0, 0, None, None, None, None, None, None)
                                block:
                                  var Rn : TEnt = Reg(b2int(insn[19,16]))
                                  var Rt : TEnt = Reg(b2int(insn[15,12]))
                                  var imm2 : TBinary = insn[5,4]
                                  var Rm : TEnt = Reg(b2int(insn[3,0]))
                                  
                                  nil
                else:
                  if bit(insn, 20):
                    if bit(insn, 15):
                      if bit(insn, 14):
                        if bit(insn, 13):
                          if bit(insn, 12):
                            if bit(insn, 11):
                              if bit(insn, 10):
                                if not bit(insn, 9):
                                  if not bit(insn, 8):
                                    #i: ((1, 1, 1, 1, 1, 0, 0, 1, 0, 0, 0, 1, None, None, None, None, 1, 1, 1, 1, 1, 1, 0, 0, None, None, None, None, None, None, None, None), [('Rn', 19, 16), ('imm8', 7, 0)], 'PLI<c> [<Rn>,#-<imm8>]', True)
                                    #PLI<c> [<Rn>,#-<imm8>]
                                    #(1, 1, 1, 1, 1, 0, 0, 1, 0, 0, 0, 1, None, None, None, None, 1, 1, 1, 1, 1, 1, 0, 0, None, None, None, None, None, None, None, None)
                                    block:
                                      var Rn : TEnt = Reg(b2int(insn[19,16]))
                                      var imm8 : TBinary = insn[7,0]
                                      
                                      nil
                            else:
                              if not bit(insn, 10):
                                if not bit(insn, 9):
                                  if not bit(insn, 8):
                                    if not bit(insn, 7):
                                      if not bit(insn, 6):
                                        #i: ((1, 1, 1, 1, 1, 0, 0, 1, 0, 0, 0, 1, None, None, None, None, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, None, None, None, None, None, None), [('Rn', 19, 16), ('shift', 5, 4), ('Rm', 3, 0)], 'PLI<c> [<Rn>,<Rm>{,LSL #<imm2>}]', True)
                                        #PLI<c> [<Rn>,<Rm>{,LSL #<imm2>}]
                                        #(1, 1, 1, 1, 1, 0, 0, 1, 0, 0, 0, 1, None, None, None, None, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, None, None, None, None, None, None)
                                        block:
                                          var Rn : TEnt = Reg(b2int(insn[19,16]))
                                          var shift : TBinary = insn[5,4]
                                          var Rm : TEnt = Reg(b2int(insn[3,0]))
                                          
                                          nil
                    if bit(insn, 11):
                      if bit(insn, 10):
                        if bit(insn, 9):
                          if not bit(insn, 8):
                            #i: ((1, 1, 1, 1, 1, 0, 0, 1, 0, 0, 0, 1, None, None, None, None, None, None, None, None, 1, 1, 1, 0, None, None, None, None, None, None, None, None), [('Rn', 19, 16), ('Rt', 15, 12), ('imm8', 7, 0)], 'LDRSBT<c> <Rt>,[<Rn>,#<imm8>]', True)
                            #LDRSBT<c> <Rt>,[<Rn>,#<imm8>]
                            #(1, 1, 1, 1, 1, 0, 0, 1, 0, 0, 0, 1, None, None, None, None, None, None, None, None, 1, 1, 1, 0, None, None, None, None, None, None, None, None)
                            block:
                              var Rn : TEnt = Reg(b2int(insn[19,16]))
                              var Rt : TEnt = Reg(b2int(insn[15,12]))
                              var imm8 : TBinary = insn[7,0]
                              
                              nil
                      #i: ((1, 1, 1, 1, 1, 0, 0, 1, 0, 0, 0, 1, None, None, None, None, None, None, None, None, 1, None, None, None, None, None, None, None, None, None, None, None), [('Rn', 19, 16), ('Rt', 15, 12), ('P', 10, 10), ('U', 9, 9), ('W', 8, 8), ('imm8', 7, 0)], 'LDRSB<c> <Rt>,[<Rn>,#+/-<imm8>]!', False)
                      #LDRSB<c> <Rt>,[<Rn>,#+/-<imm8>]!
                      #(1, 1, 1, 1, 1, 0, 0, 1, 0, 0, 0, 1, None, None, None, None, None, None, None, None, 1, None, None, None, None, None, None, None, None, None, None, None)
                      block:
                        var Rn : TEnt = Reg(b2int(insn[19,16]))
                        var Rt : TEnt = Reg(b2int(insn[15,12]))
                        var P : TBinary = insn[10,10]
                        var U : TBinary = insn[9,9]
                        var W : TBinary = insn[8,8]
                        var imm8 : TBinary = insn[7,0]
                        
                        nil
                    else:
                      if not bit(insn, 10):
                        if not bit(insn, 9):
                          if not bit(insn, 8):
                            if not bit(insn, 7):
                              if not bit(insn, 6):
                                #i: ((1, 1, 1, 1, 1, 0, 0, 1, 0, 0, 0, 1, None, None, None, None, None, None, None, None, 0, 0, 0, 0, 0, 0, None, None, None, None, None, None), [('Rn', 19, 16), ('Rt', 15, 12), ('imm2', 5, 4), ('Rm', 3, 0)], 'LDRSB<c>.W <Rt>,[<Rn>,<Rm>{,LSL #<imm2>}]', False)
                                #LDRSB<c>.W <Rt>,[<Rn>,<Rm>{,LSL #<imm2>}]
                                #(1, 1, 1, 1, 1, 0, 0, 1, 0, 0, 0, 1, None, None, None, None, None, None, None, None, 0, 0, 0, 0, 0, 0, None, None, None, None, None, None)
                                block:
                                  var Rn : TEnt = Reg(b2int(insn[19,16]))
                                  var Rt : TEnt = Reg(b2int(insn[15,12]))
                                  var imm2 : TBinary = insn[5,4]
                                  var Rm : TEnt = Reg(b2int(insn[3,0]))
                                  
                                  nil
            if not bit(insn, 22):
              if bit(insn, 21):
                if bit(insn, 20):
                  if bit(insn, 19):
                    if bit(insn, 18):
                      if bit(insn, 17):
                        if bit(insn, 16):
                          #i: ((1, 1, 1, 1, 1, 0, 0, 1, None, 0, 1, 1, 1, 1, 1, 1, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None), [('U', 23, 23), ('Rt', 15, 12), ('imm12', 11, 0)], 'LDRSH<c> <Rt>,[PC,#-0] Special case', False)
                          #LDRSH<c> <Rt>,[PC,#-0] Special case
                          #(1, 1, 1, 1, 1, 0, 0, 1, None, 0, 1, 1, 1, 1, 1, 1, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None)
                          block:
                            var U : TBinary = insn[23,23]
                            var Rt : TEnt = Reg(b2int(insn[15,12]))
                            var imm12 : TBinary = insn[11,0]
                            
                            nil
              else:
                if bit(insn, 20):
                  if bit(insn, 19):
                    if bit(insn, 18):
                      if bit(insn, 17):
                        if bit(insn, 16):
                          if bit(insn, 15):
                            if bit(insn, 14):
                              if bit(insn, 13):
                                if bit(insn, 12):
                                  #i: ((1, 1, 1, 1, 1, 0, 0, 1, None, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, None, None, None, None, None, None, None, None, None, None, None, None), [('U', 23, 23), ('imm12', 11, 0)], 'PLI<c> <label>', True)
                                  #PLI<c> <label>
                                  #(1, 1, 1, 1, 1, 0, 0, 1, None, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, None, None, None, None, None, None, None, None, None, None, None, None)
                                  block:
                                    var U : TBinary = insn[23,23]
                                    var imm12 : TBinary = insn[11,0]
                                    
                                    nil
                          #i: ((1, 1, 1, 1, 1, 0, 0, 1, None, 0, 0, 1, 1, 1, 1, 1, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None), [('U', 23, 23), ('Rt', 15, 12), ('imm12', 11, 0)], 'LDRSB<c> <Rt>,[PC,#-0] Special case', False)
                          #LDRSB<c> <Rt>,[PC,#-0] Special case
                          #(1, 1, 1, 1, 1, 0, 0, 1, None, 0, 0, 1, 1, 1, 1, 1, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None)
                          block:
                            var U : TBinary = insn[23,23]
                            var Rt : TEnt = Reg(b2int(insn[15,12]))
                            var imm12 : TBinary = insn[11,0]
                            
                            nil
          else:
            if bit(insn, 23):
              if bit(insn, 22):
                if not bit(insn, 21):
                  if bit(insn, 20):
                    #i: ((1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 0, 1, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None), [('Rn', 19, 16), ('Rt', 15, 12), ('imm12', 11, 0)], 'LDR<c>.W <Rt>,[<Rn>{,#<imm12>}]', False)
                    #LDR<c>.W <Rt>,[<Rn>{,#<imm12>}]
                    #(1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 0, 1, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None)
                    block:
                      var Rn : TEnt = Reg(b2int(insn[19,16]))
                      var Rt : TEnt = Reg(b2int(insn[15,12]))
                      var imm12 : TBinary = insn[11,0]
                      return z(opLDR, 0, Rt, Deref(Rn, @imm12))
                      nil
                  else:
                    #i: ((1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 0, 0, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None), [('Rn', 19, 16), ('Rt', 15, 12), ('imm12', 11, 0)], 'STR<c>.W <Rt>,[<Rn>,#<imm12>]', False)
                    #STR<c>.W <Rt>,[<Rn>,#<imm12>]
                    #(1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 0, 0, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None)
                    block:
                      var Rn : TEnt = Reg(b2int(insn[19,16]))
                      var Rt : TEnt = Reg(b2int(insn[15,12]))
                      var imm12 : TBinary = insn[11,0]
                      
                      nil
              else:
                if bit(insn, 21):
                  if bit(insn, 20):
                    #i: ((1, 1, 1, 1, 1, 0, 0, 0, 1, 0, 1, 1, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None), [('Rn', 19, 16), ('Rt', 15, 12), ('imm12', 11, 0)], 'LDRH<c>.W <Rt>,[<Rn>{,#<imm12>}]', False)
                    #LDRH<c>.W <Rt>,[<Rn>{,#<imm12>}]
                    #(1, 1, 1, 1, 1, 0, 0, 0, 1, 0, 1, 1, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None)
                    block:
                      var Rn : TEnt = Reg(b2int(insn[19,16]))
                      var Rt : TEnt = Reg(b2int(insn[15,12]))
                      var imm12 : TBinary = insn[11,0]
                      
                      nil
                  else:
                    #i: ((1, 1, 1, 1, 1, 0, 0, 0, 1, 0, 1, 0, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None), [('Rn', 19, 16), ('Rt', 15, 12), ('imm12', 11, 0)], 'STRH<c>.W <Rt>,[<Rn>{,#<imm12>}]', False)
                    #STRH<c>.W <Rt>,[<Rn>{,#<imm12>}]
                    #(1, 1, 1, 1, 1, 0, 0, 0, 1, 0, 1, 0, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None)
                    block:
                      var Rn : TEnt = Reg(b2int(insn[19,16]))
                      var Rt : TEnt = Reg(b2int(insn[15,12]))
                      var imm12 : TBinary = insn[11,0]
                      
                      nil
                else:
                  if bit(insn, 20):
                    #i: ((1, 1, 1, 1, 1, 0, 0, 0, 1, 0, 0, 1, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None), [('Rn', 19, 16), ('Rt', 15, 12), ('imm12', 11, 0)], 'LDRB<c>.W <Rt>,[<Rn>{,#<imm12>}]', False)
                    #LDRB<c>.W <Rt>,[<Rn>{,#<imm12>}]
                    #(1, 1, 1, 1, 1, 0, 0, 0, 1, 0, 0, 1, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None)
                    block:
                      var Rn : TEnt = Reg(b2int(insn[19,16]))
                      var Rt : TEnt = Reg(b2int(insn[15,12]))
                      var imm12 : TBinary = insn[11,0]
                      
                      nil
                  else:
                    #i: ((1, 1, 1, 1, 1, 0, 0, 0, 1, 0, 0, 0, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None), [('Rn', 19, 16), ('Rt', 15, 12), ('imm12', 11, 0)], 'STRB<c>.W <Rt>,[<Rn>,#<imm12>]', False)
                    #STRB<c>.W <Rt>,[<Rn>,#<imm12>]
                    #(1, 1, 1, 1, 1, 0, 0, 0, 1, 0, 0, 0, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None)
                    block:
                      var Rn : TEnt = Reg(b2int(insn[19,16]))
                      var Rt : TEnt = Reg(b2int(insn[15,12]))
                      var imm12 : TBinary = insn[11,0]
                      
                      nil
                if bit(insn, 20):
                  if bit(insn, 15):
                    if bit(insn, 14):
                      if bit(insn, 13):
                        if bit(insn, 12):
                          #i: ((1, 1, 1, 1, 1, 0, 0, 0, 1, 0, None, 1, None, None, None, None, 1, 1, 1, 1, None, None, None, None, None, None, None, None, None, None, None, None), [('W', 21, 21), ('Rn', 19, 16), ('imm12', 11, 0)], 'PLD{W}<c> [<Rn>,#<imm12>]', False)
                          #PLD{W}<c> [<Rn>,#<imm12>]
                          #(1, 1, 1, 1, 1, 0, 0, 0, 1, 0, None, 1, None, None, None, None, 1, 1, 1, 1, None, None, None, None, None, None, None, None, None, None, None, None)
                          block:
                            var W : TBinary = insn[21,21]
                            var Rn : TEnt = Reg(b2int(insn[19,16]))
                            var imm12 : TBinary = insn[11,0]
                            
                            nil
            else:
              if bit(insn, 22):
                if not bit(insn, 21):
                  if bit(insn, 20):
                    if bit(insn, 11):
                      if bit(insn, 10):
                        if bit(insn, 9):
                          if not bit(insn, 8):
                            #i: ((1, 1, 1, 1, 1, 0, 0, 0, 0, 1, 0, 1, None, None, None, None, None, None, None, None, 1, 1, 1, 0, None, None, None, None, None, None, None, None), [('Rn', 19, 16), ('Rt', 15, 12), ('imm8', 7, 0)], 'LDRT<c> <Rt>,[<Rn>,#<imm8>]', True)
                            #LDRT<c> <Rt>,[<Rn>,#<imm8>]
                            #(1, 1, 1, 1, 1, 0, 0, 0, 0, 1, 0, 1, None, None, None, None, None, None, None, None, 1, 1, 1, 0, None, None, None, None, None, None, None, None)
                            block:
                              var Rn : TEnt = Reg(b2int(insn[19,16]))
                              var Rt : TEnt = Reg(b2int(insn[15,12]))
                              var imm8 : TBinary = insn[7,0]
                              
                              nil
                      #i: ((1, 1, 1, 1, 1, 0, 0, 0, 0, 1, 0, 1, None, None, None, None, None, None, None, None, 1, None, None, None, None, None, None, None, None, None, None, None), [('Rn', 19, 16), ('Rt', 15, 12), ('P', 10, 10), ('U', 9, 9), ('W', 8, 8), ('imm8', 7, 0)], 'LDR<c> <Rt>,[<Rn>,#+/-<imm8>]!', False)
                      #LDR<c> <Rt>,[<Rn>,#+/-<imm8>]!
                      #(1, 1, 1, 1, 1, 0, 0, 0, 0, 1, 0, 1, None, None, None, None, None, None, None, None, 1, None, None, None, None, None, None, None, None, None, None, None)
                      block:
                        var Rn : TEnt = Reg(b2int(insn[19,16]))
                        var Rt : TEnt = Reg(b2int(insn[15,12]))
                        var P : TBinary = insn[10,10]
                        var U : TBinary = insn[9,9]
                        var W : TBinary = insn[8,8]
                        var imm8 : TBinary = insn[7,0]
                        if P.bit and U.bit and not W.bit: break
                        if Rn == SP and not P.bit and U.bit and W.bit: break
                        if not P.bit and not W.bit: break
                        return z(opLDR, 0, Rt, Deref(Rn, @imm8, P.bit, W.bit, U.bit))
                        nil
                    else:
                      if not bit(insn, 10):
                        if not bit(insn, 9):
                          if not bit(insn, 8):
                            if not bit(insn, 7):
                              if not bit(insn, 6):
                                #i: ((1, 1, 1, 1, 1, 0, 0, 0, 0, 1, 0, 1, None, None, None, None, None, None, None, None, 0, 0, 0, 0, 0, 0, None, None, None, None, None, None), [('Rn', 19, 16), ('Rt', 15, 12), ('imm2', 5, 4), ('Rm', 3, 0)], 'LDR<c>.W <Rt>,[<Rn>,<Rm>{,LSL #<imm2>}]', False)
                                #LDR<c>.W <Rt>,[<Rn>,<Rm>{,LSL #<imm2>}]
                                #(1, 1, 1, 1, 1, 0, 0, 0, 0, 1, 0, 1, None, None, None, None, None, None, None, None, 0, 0, 0, 0, 0, 0, None, None, None, None, None, None)
                                block:
                                  var Rn : TEnt = Reg(b2int(insn[19,16]))
                                  var Rt : TEnt = Reg(b2int(insn[15,12]))
                                  var imm2 : TBinary = insn[5,4]
                                  var Rm : TEnt = Reg(b2int(insn[3,0]))
                                  return z(opLDR, 0, Rt, Deref(Rn, Shift(Rm, LSL, @imm2)))
                                  nil
                  else:
                    if bit(insn, 11):
                      if bit(insn, 10):
                        if bit(insn, 9):
                          if not bit(insn, 8):
                            #i: ((1, 1, 1, 1, 1, 0, 0, 0, 0, 1, 0, 0, None, None, None, None, None, None, None, None, 1, 1, 1, 0, None, None, None, None, None, None, None, None), [('Rn', 19, 16), ('Rt', 15, 12), ('imm8', 7, 0)], 'STRT<c> <Rt>,[<Rn>,#<imm8>]', True)
                            #STRT<c> <Rt>,[<Rn>,#<imm8>]
                            #(1, 1, 1, 1, 1, 0, 0, 0, 0, 1, 0, 0, None, None, None, None, None, None, None, None, 1, 1, 1, 0, None, None, None, None, None, None, None, None)
                            block:
                              var Rn : TEnt = Reg(b2int(insn[19,16]))
                              var Rt : TEnt = Reg(b2int(insn[15,12]))
                              var imm8 : TBinary = insn[7,0]
                              
                              nil
                      #i: ((1, 1, 1, 1, 1, 0, 0, 0, 0, 1, 0, 0, None, None, None, None, None, None, None, None, 1, None, None, None, None, None, None, None, None, None, None, None), [('Rn', 19, 16), ('Rt', 15, 12), ('P', 10, 10), ('U', 9, 9), ('W', 8, 8), ('imm8', 7, 0)], 'STR<c> <Rt>,[<Rn>,#+/-<imm8>]!', False)
                      #STR<c> <Rt>,[<Rn>,#+/-<imm8>]!
                      #(1, 1, 1, 1, 1, 0, 0, 0, 0, 1, 0, 0, None, None, None, None, None, None, None, None, 1, None, None, None, None, None, None, None, None, None, None, None)
                      block:
                        var Rn : TEnt = Reg(b2int(insn[19,16]))
                        var Rt : TEnt = Reg(b2int(insn[15,12]))
                        var P : TBinary = insn[10,10]
                        var U : TBinary = insn[9,9]
                        var W : TBinary = insn[8,8]
                        var imm8 : TBinary = insn[7,0]
                        
                        nil
                    else:
                      if not bit(insn, 10):
                        if not bit(insn, 9):
                          if not bit(insn, 8):
                            if not bit(insn, 7):
                              if not bit(insn, 6):
                                #i: ((1, 1, 1, 1, 1, 0, 0, 0, 0, 1, 0, 0, None, None, None, None, None, None, None, None, 0, 0, 0, 0, 0, 0, None, None, None, None, None, None), [('Rn', 19, 16), ('Rt', 15, 12), ('imm2', 5, 4), ('Rm', 3, 0)], 'STR<c>.W <Rt>,[<Rn>,<Rm>{,LSL #<imm2>}]', False)
                                #STR<c>.W <Rt>,[<Rn>,<Rm>{,LSL #<imm2>}]
                                #(1, 1, 1, 1, 1, 0, 0, 0, 0, 1, 0, 0, None, None, None, None, None, None, None, None, 0, 0, 0, 0, 0, 0, None, None, None, None, None, None)
                                block:
                                  var Rn : TEnt = Reg(b2int(insn[19,16]))
                                  var Rt : TEnt = Reg(b2int(insn[15,12]))
                                  var imm2 : TBinary = insn[5,4]
                                  var Rm : TEnt = Reg(b2int(insn[3,0]))
                                  
                                  nil
              else:
                if bit(insn, 21):
                  if bit(insn, 20):
                    if bit(insn, 11):
                      if bit(insn, 10):
                        if bit(insn, 9):
                          if not bit(insn, 8):
                            #i: ((1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 1, 1, None, None, None, None, None, None, None, None, 1, 1, 1, 0, None, None, None, None, None, None, None, None), [('Rn', 19, 16), ('Rt', 15, 12), ('imm8', 7, 0)], 'LDRHT<c> <Rt>,[<Rn>,#<imm8>]', True)
                            #LDRHT<c> <Rt>,[<Rn>,#<imm8>]
                            #(1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 1, 1, None, None, None, None, None, None, None, None, 1, 1, 1, 0, None, None, None, None, None, None, None, None)
                            block:
                              var Rn : TEnt = Reg(b2int(insn[19,16]))
                              var Rt : TEnt = Reg(b2int(insn[15,12]))
                              var imm8 : TBinary = insn[7,0]
                              
                              nil
                      #i: ((1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 1, 1, None, None, None, None, None, None, None, None, 1, None, None, None, None, None, None, None, None, None, None, None), [('Rn', 19, 16), ('Rt', 15, 12), ('P', 10, 10), ('U', 9, 9), ('W', 8, 8), ('imm8', 7, 0)], 'LDRH<c> <Rt>,[<Rn>,#+/-<imm8>]!', False)
                      #LDRH<c> <Rt>,[<Rn>,#+/-<imm8>]!
                      #(1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 1, 1, None, None, None, None, None, None, None, None, 1, None, None, None, None, None, None, None, None, None, None, None)
                      block:
                        var Rn : TEnt = Reg(b2int(insn[19,16]))
                        var Rt : TEnt = Reg(b2int(insn[15,12]))
                        var P : TBinary = insn[10,10]
                        var U : TBinary = insn[9,9]
                        var W : TBinary = insn[8,8]
                        var imm8 : TBinary = insn[7,0]
                        
                        nil
                    else:
                      if not bit(insn, 10):
                        if not bit(insn, 9):
                          if not bit(insn, 8):
                            if not bit(insn, 7):
                              if not bit(insn, 6):
                                #i: ((1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 1, 1, None, None, None, None, None, None, None, None, 0, 0, 0, 0, 0, 0, None, None, None, None, None, None), [('Rn', 19, 16), ('Rt', 15, 12), ('imm2', 5, 4), ('Rm', 3, 0)], 'LDRH<c>.W <Rt>,[<Rn>,<Rm>{,LSL #<imm2>}]', False)
                                #LDRH<c>.W <Rt>,[<Rn>,<Rm>{,LSL #<imm2>}]
                                #(1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 1, 1, None, None, None, None, None, None, None, None, 0, 0, 0, 0, 0, 0, None, None, None, None, None, None)
                                block:
                                  var Rn : TEnt = Reg(b2int(insn[19,16]))
                                  var Rt : TEnt = Reg(b2int(insn[15,12]))
                                  var imm2 : TBinary = insn[5,4]
                                  var Rm : TEnt = Reg(b2int(insn[3,0]))
                                  
                                  nil
                  else:
                    if bit(insn, 11):
                      if bit(insn, 10):
                        if bit(insn, 9):
                          if not bit(insn, 8):
                            #i: ((1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 1, 0, None, None, None, None, None, None, None, None, 1, 1, 1, 0, None, None, None, None, None, None, None, None), [('Rn', 19, 16), ('Rt', 15, 12), ('imm8', 7, 0)], 'STRHT<c> <Rt>,[<Rn>,#<imm8>]', True)
                            #STRHT<c> <Rt>,[<Rn>,#<imm8>]
                            #(1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 1, 0, None, None, None, None, None, None, None, None, 1, 1, 1, 0, None, None, None, None, None, None, None, None)
                            block:
                              var Rn : TEnt = Reg(b2int(insn[19,16]))
                              var Rt : TEnt = Reg(b2int(insn[15,12]))
                              var imm8 : TBinary = insn[7,0]
                              
                              nil
                      #i: ((1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 1, 0, None, None, None, None, None, None, None, None, 1, None, None, None, None, None, None, None, None, None, None, None), [('Rn', 19, 16), ('Rt', 15, 12), ('P', 10, 10), ('U', 9, 9), ('W', 8, 8), ('imm8', 7, 0)], 'STRH<c> <Rt>,[<Rn>,#+/-<imm8>]!', False)
                      #STRH<c> <Rt>,[<Rn>,#+/-<imm8>]!
                      #(1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 1, 0, None, None, None, None, None, None, None, None, 1, None, None, None, None, None, None, None, None, None, None, None)
                      block:
                        var Rn : TEnt = Reg(b2int(insn[19,16]))
                        var Rt : TEnt = Reg(b2int(insn[15,12]))
                        var P : TBinary = insn[10,10]
                        var U : TBinary = insn[9,9]
                        var W : TBinary = insn[8,8]
                        var imm8 : TBinary = insn[7,0]
                        
                        nil
                    else:
                      if not bit(insn, 10):
                        if not bit(insn, 9):
                          if not bit(insn, 8):
                            if not bit(insn, 7):
                              if not bit(insn, 6):
                                #i: ((1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 1, 0, None, None, None, None, None, None, None, None, 0, 0, 0, 0, 0, 0, None, None, None, None, None, None), [('Rn', 19, 16), ('Rt', 15, 12), ('imm2', 5, 4), ('Rm', 3, 0)], 'STRH<c>.W <Rt>,[<Rn>,<Rm>{,LSL #<imm2>}]', False)
                                #STRH<c>.W <Rt>,[<Rn>,<Rm>{,LSL #<imm2>}]
                                #(1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 1, 0, None, None, None, None, None, None, None, None, 0, 0, 0, 0, 0, 0, None, None, None, None, None, None)
                                block:
                                  var Rn : TEnt = Reg(b2int(insn[19,16]))
                                  var Rt : TEnt = Reg(b2int(insn[15,12]))
                                  var imm2 : TBinary = insn[5,4]
                                  var Rm : TEnt = Reg(b2int(insn[3,0]))
                                  
                                  nil
                else:
                  if bit(insn, 20):
                    if bit(insn, 15):
                      if bit(insn, 14):
                        if bit(insn, 13):
                          if bit(insn, 12):
                            if not bit(insn, 11):
                              if not bit(insn, 10):
                                if not bit(insn, 9):
                                  if not bit(insn, 8):
                                    if not bit(insn, 7):
                                      if not bit(insn, 6):
                                        #i: ((1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, None, None, None, None, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, None, None, None, None, None, None), [('Rn', 19, 16), ('shift', 5, 4), ('Rm', 3, 0)], 'PLD<c> [<Rn>,<Rm>{,LSL #<imm2>}]', True)
                                        #PLD<c> [<Rn>,<Rm>{,LSL #<imm2>}]
                                        #(1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, None, None, None, None, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, None, None, None, None, None, None)
                                        block:
                                          var Rn : TEnt = Reg(b2int(insn[19,16]))
                                          var shift : TBinary = insn[5,4]
                                          var Rm : TEnt = Reg(b2int(insn[3,0]))
                                          
                                          nil
                    if bit(insn, 11):
                      if bit(insn, 10):
                        if bit(insn, 9):
                          if not bit(insn, 8):
                            #i: ((1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, None, None, None, None, None, None, None, None, 1, 1, 1, 0, None, None, None, None, None, None, None, None), [('Rn', 19, 16), ('Rt', 15, 12), ('imm8', 7, 0)], 'LDRBT<c> <Rt>,[<Rn>,#<imm8>]', True)
                            #LDRBT<c> <Rt>,[<Rn>,#<imm8>]
                            #(1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, None, None, None, None, None, None, None, None, 1, 1, 1, 0, None, None, None, None, None, None, None, None)
                            block:
                              var Rn : TEnt = Reg(b2int(insn[19,16]))
                              var Rt : TEnt = Reg(b2int(insn[15,12]))
                              var imm8 : TBinary = insn[7,0]
                              
                              nil
                      #i: ((1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, None, None, None, None, None, None, None, None, 1, None, None, None, None, None, None, None, None, None, None, None), [('Rn', 19, 16), ('Rt', 15, 12), ('P', 10, 10), ('U', 9, 9), ('W', 8, 8), ('imm8', 7, 0)], 'LDRB<c> <Rt>,[<Rn>,#+/-<imm8>]!', False)
                      #LDRB<c> <Rt>,[<Rn>,#+/-<imm8>]!
                      #(1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, None, None, None, None, None, None, None, None, 1, None, None, None, None, None, None, None, None, None, None, None)
                      block:
                        var Rn : TEnt = Reg(b2int(insn[19,16]))
                        var Rt : TEnt = Reg(b2int(insn[15,12]))
                        var P : TBinary = insn[10,10]
                        var U : TBinary = insn[9,9]
                        var W : TBinary = insn[8,8]
                        var imm8 : TBinary = insn[7,0]
                        
                        nil
                    else:
                      if not bit(insn, 10):
                        if not bit(insn, 9):
                          if not bit(insn, 8):
                            if not bit(insn, 7):
                              if not bit(insn, 6):
                                #i: ((1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, None, None, None, None, None, None, None, None, 0, 0, 0, 0, 0, 0, None, None, None, None, None, None), [('Rn', 19, 16), ('Rt', 15, 12), ('imm2', 5, 4), ('Rm', 3, 0)], 'LDRB<c>.W <Rt>,[<Rn>,<Rm>{,LSL #<imm2>}]', False)
                                #LDRB<c>.W <Rt>,[<Rn>,<Rm>{,LSL #<imm2>}]
                                #(1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, None, None, None, None, None, None, None, None, 0, 0, 0, 0, 0, 0, None, None, None, None, None, None)
                                block:
                                  var Rn : TEnt = Reg(b2int(insn[19,16]))
                                  var Rt : TEnt = Reg(b2int(insn[15,12]))
                                  var imm2 : TBinary = insn[5,4]
                                  var Rm : TEnt = Reg(b2int(insn[3,0]))
                                  
                                  nil
                  else:
                    if bit(insn, 11):
                      if bit(insn, 10):
                        if bit(insn, 9):
                          if not bit(insn, 8):
                            #i: ((1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, None, None, None, None, None, None, None, None, 1, 1, 1, 0, None, None, None, None, None, None, None, None), [('Rn', 19, 16), ('Rt', 15, 12), ('imm8', 7, 0)], 'STRBT<c> <Rt>,[<Rn>,#<imm8>]', True)
                            #STRBT<c> <Rt>,[<Rn>,#<imm8>]
                            #(1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, None, None, None, None, None, None, None, None, 1, 1, 1, 0, None, None, None, None, None, None, None, None)
                            block:
                              var Rn : TEnt = Reg(b2int(insn[19,16]))
                              var Rt : TEnt = Reg(b2int(insn[15,12]))
                              var imm8 : TBinary = insn[7,0]
                              
                              nil
                      #i: ((1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, None, None, None, None, None, None, None, None, 1, None, None, None, None, None, None, None, None, None, None, None), [('Rn', 19, 16), ('Rt', 15, 12), ('P', 10, 10), ('U', 9, 9), ('W', 8, 8), ('imm8', 7, 0)], 'STRB<c> <Rt>,[<Rn>,#+/-<imm8>]!', False)
                      #STRB<c> <Rt>,[<Rn>,#+/-<imm8>]!
                      #(1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, None, None, None, None, None, None, None, None, 1, None, None, None, None, None, None, None, None, None, None, None)
                      block:
                        var Rn : TEnt = Reg(b2int(insn[19,16]))
                        var Rt : TEnt = Reg(b2int(insn[15,12]))
                        var P : TBinary = insn[10,10]
                        var U : TBinary = insn[9,9]
                        var W : TBinary = insn[8,8]
                        var imm8 : TBinary = insn[7,0]
                        
                        nil
                    else:
                      if not bit(insn, 10):
                        if not bit(insn, 9):
                          if not bit(insn, 8):
                            if not bit(insn, 7):
                              if not bit(insn, 6):
                                #i: ((1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, None, None, None, None, None, None, None, None, 0, 0, 0, 0, 0, 0, None, None, None, None, None, None), [('Rn', 19, 16), ('Rt', 15, 12), ('imm2', 5, 4), ('Rm', 3, 0)], 'STRB<c>.W <Rt>,[<Rn>,<Rm>{,LSL #<imm2>}]', False)
                                #STRB<c>.W <Rt>,[<Rn>,<Rm>{,LSL #<imm2>}]
                                #(1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, None, None, None, None, None, None, None, None, 0, 0, 0, 0, 0, 0, None, None, None, None, None, None)
                                block:
                                  var Rn : TEnt = Reg(b2int(insn[19,16]))
                                  var Rt : TEnt = Reg(b2int(insn[15,12]))
                                  var imm2 : TBinary = insn[5,4]
                                  var Rm : TEnt = Reg(b2int(insn[3,0]))
                                  
                                  nil
                if bit(insn, 20):
                  if bit(insn, 15):
                    if bit(insn, 14):
                      if bit(insn, 13):
                        if bit(insn, 12):
                          if bit(insn, 11):
                            if bit(insn, 10):
                              if not bit(insn, 9):
                                if not bit(insn, 8):
                                  #i: ((1, 1, 1, 1, 1, 0, 0, 0, 0, 0, None, 1, None, None, None, None, 1, 1, 1, 1, 1, 1, 0, 0, None, None, None, None, None, None, None, None), [('W', 21, 21), ('Rn', 19, 16), ('imm8', 7, 0)], 'PLD{W}<c> [<Rn>,#-<imm8>]', False)
                                  #PLD{W}<c> [<Rn>,#-<imm8>]
                                  #(1, 1, 1, 1, 1, 0, 0, 0, 0, 0, None, 1, None, None, None, None, 1, 1, 1, 1, 1, 1, 0, 0, None, None, None, None, None, None, None, None)
                                  block:
                                    var W : TBinary = insn[21,21]
                                    var Rn : TEnt = Reg(b2int(insn[19,16]))
                                    var imm8 : TBinary = insn[7,0]
                                    
                                    nil
            if not bit(insn, 22):
              if bit(insn, 21):
                if bit(insn, 20):
                  if bit(insn, 19):
                    if bit(insn, 18):
                      if bit(insn, 17):
                        if bit(insn, 16):
                          #i: ((1, 1, 1, 1, 1, 0, 0, 0, None, 0, 1, 1, 1, 1, 1, 1, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None), [('U', 23, 23), ('Rt', 15, 12), ('imm12', 11, 0)], 'LDRH<c> <Rt>,[PC,#-0] Special case', False)
                          #LDRH<c> <Rt>,[PC,#-0] Special case
                          #(1, 1, 1, 1, 1, 0, 0, 0, None, 0, 1, 1, 1, 1, 1, 1, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None)
                          block:
                            var U : TBinary = insn[23,23]
                            var Rt : TEnt = Reg(b2int(insn[15,12]))
                            var imm12 : TBinary = insn[11,0]
                            
                            nil
              else:
                if bit(insn, 20):
                  if bit(insn, 19):
                    if bit(insn, 18):
                      if bit(insn, 17):
                        if bit(insn, 16):
                          if bit(insn, 15):
                            if bit(insn, 14):
                              if bit(insn, 13):
                                if bit(insn, 12):
                                  #i: ((1, 1, 1, 1, 1, 0, 0, 0, None, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, None, None, None, None, None, None, None, None, None, None, None, None), [('U', 23, 23), ('imm12', 11, 0)], 'PLD<c> <label>', True)
                                  #PLD<c> <label>
                                  #(1, 1, 1, 1, 1, 0, 0, 0, None, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, None, None, None, None, None, None, None, None, None, None, None, None)
                                  block:
                                    var U : TBinary = insn[23,23]
                                    var imm12 : TBinary = insn[11,0]
                                    
                                    nil
                          #i: ((1, 1, 1, 1, 1, 0, 0, 0, None, 0, 0, 1, 1, 1, 1, 1, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None), [('U', 23, 23), ('Rt', 15, 12), ('imm12', 11, 0)], 'LDRB<c> <Rt>,[PC,#-0] Special case', False)
                          #LDRB<c> <Rt>,[PC,#-0] Special case
                          #(1, 1, 1, 1, 1, 0, 0, 0, None, 0, 0, 1, 1, 1, 1, 1, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None)
                          block:
                            var U : TBinary = insn[23,23]
                            var Rt : TEnt = Reg(b2int(insn[15,12]))
                            var imm12 : TBinary = insn[11,0]
                            
                            nil
    else:
      if not bit(insn, 26):
        if bit(insn, 25):
          if bit(insn, 24):
            if bit(insn, 23):
              if bit(insn, 22):
                if bit(insn, 21):
                  if not bit(insn, 20):
                    if bit(insn, 19):
                      if bit(insn, 18):
                        if bit(insn, 17):
                          if bit(insn, 16):
                            if bit(insn, 15):
                              if not bit(insn, 14):
                                if not bit(insn, 13):
                                  if not bit(insn, 12):
                                    #i: ((1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 0, 0, None, None, None, None, None, None, None, None, None, None, None, None), [('Rd', 11, 8), ('SYSm', 7, 0)], 'MRS<c> <Rd>,<spec_reg>', True)
                                    #MRS<c> <Rd>,<spec_reg>
                                    #(1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 0, 0, None, None, None, None, None, None, None, None, None, None, None, None)
                                    block:
                                      var Rd : TEnt = Reg(b2int(insn[11,8]))
                                      var SYSm : TBinary = insn[7,0]
                                      
                                      nil
                else:
                  if not bit(insn, 20):
                    if not bit(insn, 15):
                      if not bit(insn, 5):
                        #i: ((1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 0, 0, None, None, None, None, 0, None, None, None, None, None, None, None, None, None, 0, None, None, None, None, None), [('Rn', 19, 16), ('imm3', 14, 12), ('Rd', 11, 8), ('imm2', 7, 6), ('widthm1', 4, 0)], 'UBFX<c> <Rd>,<Rn>,#<lsb>,#<width>', False)
                        #UBFX<c> <Rd>,<Rn>,#<lsb>,#<width>
                        #(1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 0, 0, None, None, None, None, 0, None, None, None, None, None, None, None, None, None, 0, None, None, None, None, None)
                        block:
                          var Rn : TEnt = Reg(b2int(insn[19,16]))
                          var imm3 : TBinary = insn[14,12]
                          var Rd : TEnt = Reg(b2int(insn[11,8]))
                          var imm2 : TBinary = insn[7,6]
                          var widthm1 : TBinary = insn[4,0]
                          
                          nil
              else:
                if bit(insn, 21):
                  if bit(insn, 20):
                    if bit(insn, 19):
                      if bit(insn, 18):
                        if bit(insn, 17):
                          if bit(insn, 16):
                            if bit(insn, 15):
                              if not bit(insn, 14):
                                if not bit(insn, 13):
                                  if not bit(insn, 12):
                                    if bit(insn, 11):
                                      if bit(insn, 10):
                                        if bit(insn, 9):
                                          if bit(insn, 8):
                                            if not bit(insn, 7):
                                              if bit(insn, 6):
                                                if bit(insn, 5):
                                                  if not bit(insn, 4):
                                                    #i: ((1, 1, 1, 1, 0, 0, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 0, 1, 1, 0, None, None, None, None), [('option', 3, 0)], 'ISB<c> #<option>', True)
                                                    #ISB<c> #<option>
                                                    #(1, 1, 1, 1, 0, 0, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 0, 1, 1, 0, None, None, None, None)
                                                    block:
                                                      var option : TBinary = insn[3,0]
                                                      return z(opISB, 0, option)
                                                      nil
                                                else:
                                                  if bit(insn, 4):
                                                    #i: ((1, 1, 1, 1, 0, 0, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 0, 1, 0, 1, None, None, None, None), [('option', 3, 0)], 'DMB<c> #<option>', True)
                                                    #DMB<c> #<option>
                                                    #(1, 1, 1, 1, 0, 0, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 0, 1, 0, 1, None, None, None, None)
                                                    block:
                                                      var option : TBinary = insn[3,0]
                                                      return z(opDMB, 0, option)
                                                      nil
                                                  else:
                                                    #i: ((1, 1, 1, 1, 0, 0, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 0, 1, 0, 0, None, None, None, None), [('option', 3, 0)], 'DSB<c> #<option>', True)
                                                    #DSB<c> #<option>
                                                    #(1, 1, 1, 1, 0, 0, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 0, 1, 0, 0, None, None, None, None)
                                                    block:
                                                      var option : TBinary = insn[3,0]
                                                      return z(opDSB, 0, option)
                                                      nil
                                              else:
                                                if bit(insn, 5):
                                                  if not bit(insn, 4):
                                                    if bit(insn, 3):
                                                      if bit(insn, 2):
                                                        if bit(insn, 1):
                                                          if bit(insn, 0):
                                                            #i: ((1, 1, 1, 1, 0, 0, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 0, 0, 1, 0, 1, 1, 1, 1), [], 'CLREX<c>', True)
                                                            #CLREX<c>
                                                            #(1, 1, 1, 1, 0, 0, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 0, 0, 1, 0, 1, 1, 1, 1)
                                                            block:
                                                              return z(opCLREX, 0)
                                                              nil
                  else:
                    if bit(insn, 19):
                      if bit(insn, 18):
                        if bit(insn, 17):
                          if bit(insn, 16):
                            if bit(insn, 15):
                              if not bit(insn, 14):
                                if not bit(insn, 13):
                                  if not bit(insn, 12):
                                    if not bit(insn, 11):
                                      if not bit(insn, 10):
                                        if not bit(insn, 9):
                                          if not bit(insn, 8):
                                            if bit(insn, 7):
                                              if bit(insn, 6):
                                                if bit(insn, 5):
                                                  if bit(insn, 4):
                                                    #i: ((1, 1, 1, 1, 0, 0, 1, 1, 1, 0, 1, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, None, None, None, None), [('option', 3, 0)], 'DBG<c> #<option>', True)
                                                    #DBG<c> #<option>
                                                    #(1, 1, 1, 1, 0, 0, 1, 1, 1, 0, 1, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, None, None, None, None)
                                                    block:
                                                      var option : TBinary = insn[3,0]
                                                      return z(opDBG, 0, option)
                                                      nil
                                            else:
                                              if not bit(insn, 6):
                                                if not bit(insn, 5):
                                                  if not bit(insn, 4):
                                                    if not bit(insn, 3):
                                                      if bit(insn, 2):
                                                        if not bit(insn, 1):
                                                          if not bit(insn, 0):
                                                            #i: ((1, 1, 1, 1, 0, 0, 1, 1, 1, 0, 1, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0), [], 'SEV<c>.W', True)
                                                            #SEV<c>.W
                                                            #(1, 1, 1, 1, 0, 0, 1, 1, 1, 0, 1, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0)
                                                            block:
                                                              
                                                              nil
                                                      else:
                                                        if bit(insn, 1):
                                                          if bit(insn, 0):
                                                            #i: ((1, 1, 1, 1, 0, 0, 1, 1, 1, 0, 1, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1), [], 'WFI<c>.W', True)
                                                            #WFI<c>.W
                                                            #(1, 1, 1, 1, 0, 0, 1, 1, 1, 0, 1, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1)
                                                            block:
                                                              return z(opWFI, 0)
                                                              nil
                                                          else:
                                                            #i: ((1, 1, 1, 1, 0, 0, 1, 1, 1, 0, 1, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0), [], 'WFE<c>.W', True)
                                                            #WFE<c>.W
                                                            #(1, 1, 1, 1, 0, 0, 1, 1, 1, 0, 1, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0)
                                                            block:
                                                              return z(opWFE, 0)
                                                              nil
                                                        else:
                                                          if bit(insn, 0):
                                                            #i: ((1, 1, 1, 1, 0, 0, 1, 1, 1, 0, 1, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1), [], 'YIELD<c>.W', True)
                                                            #YIELD<c>.W
                                                            #(1, 1, 1, 1, 0, 0, 1, 1, 1, 0, 1, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1)
                                                            block:
                                                              return z(opYIELD, 0)
                                                              nil
                                                          else:
                                                            #i: ((1, 1, 1, 1, 0, 0, 1, 1, 1, 0, 1, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0), [], 'NOP<c>.W', True)
                                                            #NOP<c>.W
                                                            #(1, 1, 1, 1, 0, 0, 1, 1, 1, 0, 1, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
                                                            block:
                                                              
                                                              nil
                else:
                  if not bit(insn, 20):
                    if bit(insn, 15):
                      if not bit(insn, 14):
                        if not bit(insn, 13):
                          if not bit(insn, 12):
                            if bit(insn, 11):
                              if not bit(insn, 10):
                                if not bit(insn, 9):
                                  if not bit(insn, 8):
                                    #i: ((1, 1, 1, 1, 0, 0, 1, 1, 1, 0, 0, 0, None, None, None, None, 1, 0, 0, 0, 1, 0, 0, 0, None, None, None, None, None, None, None, None), [('Rn', 19, 16), ('SYSm', 7, 0)], 'MSR<c> <spec_reg>,<Rn>', True)
                                    #MSR<c> <spec_reg>,<Rn>
                                    #(1, 1, 1, 1, 0, 0, 1, 1, 1, 0, 0, 0, None, None, None, None, 1, 0, 0, 0, 1, 0, 0, 0, None, None, None, None, None, None, None, None)
                                    block:
                                      var Rn : TEnt = Reg(b2int(insn[19,16]))
                                      var SYSm : TBinary = insn[7,0]
                                      
                                      nil
                if not bit(insn, 20):
                  if not bit(insn, 15):
                    if not bit(insn, 5):
                      #i: ((1, 1, 1, 1, 0, 0, 1, 1, 1, 0, None, 0, None, None, None, None, 0, None, None, None, None, None, None, None, None, None, 0, None, None, None, None, None), [('sh', 21, 21), ('Rn', 19, 16), ('imm3', 14, 12), ('Rd', 11, 8), ('imm2', 7, 6), ('sat_imm', 4, 0)], 'USAT<c> <Rd>,#<imm5>,<Rn>{,<shift>}', False)
                      #USAT<c> <Rd>,#<imm5>,<Rn>{,<shift>}
                      #(1, 1, 1, 1, 0, 0, 1, 1, 1, 0, None, 0, None, None, None, None, 0, None, None, None, None, None, None, None, None, None, 0, None, None, None, None, None)
                      block:
                        var sh : TBinary = insn[21,21]
                        var Rn : TEnt = Reg(b2int(insn[19,16]))
                        var imm3 : TBinary = insn[14,12]
                        var Rd : TEnt = Reg(b2int(insn[11,8]))
                        var imm2 : TBinary = insn[7,6]
                        var sat_imm : TBinary = insn[4,0]
                        
                        nil
            else:
              if bit(insn, 22):
                if bit(insn, 21):
                  if not bit(insn, 20):
                    if bit(insn, 19):
                      if bit(insn, 18):
                        if bit(insn, 17):
                          if bit(insn, 16):
                            if not bit(insn, 15):
                              if not bit(insn, 5):
                                #i: ((1, 1, 1, 1, 0, 0, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 0, None, None, None, None, None, None, None, None, None, 0, None, None, None, None, None), [('imm3', 14, 12), ('Rd', 11, 8), ('imm2', 7, 6), ('msb', 4, 0)], 'BFC<c> <Rd>,#<lsb>,#<width>', True)
                                #BFC<c> <Rd>,#<lsb>,#<width>
                                #(1, 1, 1, 1, 0, 0, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 0, None, None, None, None, None, None, None, None, None, 0, None, None, None, None, None)
                                block:
                                  var imm3 : TBinary = insn[14,12]
                                  var Rd : TEnt = Reg(b2int(insn[11,8]))
                                  var imm2 : TBinary = insn[7,6]
                                  var msb : TBinary = insn[4,0]
                                  var lsb = cat(imm3, imm2)
                                  return z(opBFC, 0, Rd, lsb, msb.num - lsb.num + 1)
                                  nil
                    if not bit(insn, 15):
                      if not bit(insn, 5):
                        #i: ((1, 1, 1, 1, 0, 0, 1, 1, 0, 1, 1, 0, None, None, None, None, 0, None, None, None, None, None, None, None, None, None, 0, None, None, None, None, None), [('Rn', 19, 16), ('imm3', 14, 12), ('Rd', 11, 8), ('imm2', 7, 6), ('msb', 4, 0)], 'BFI<c> <Rd>,<Rn>,#<lsb>,#<width>', False)
                        #BFI<c> <Rd>,<Rn>,#<lsb>,#<width>
                        #(1, 1, 1, 1, 0, 0, 1, 1, 0, 1, 1, 0, None, None, None, None, 0, None, None, None, None, None, None, None, None, None, 0, None, None, None, None, None)
                        block:
                          var Rn : TEnt = Reg(b2int(insn[19,16]))
                          var imm3 : TBinary = insn[14,12]
                          var Rd : TEnt = Reg(b2int(insn[11,8]))
                          var imm2 : TBinary = insn[7,6]
                          var msb : TBinary = insn[4,0]
                          var lsb = cat(imm3, imm2)
                          return z(opBFI, 0, Rd, Rn, lsb, msb.num - lsb.num + 1)
                          nil
                else:
                  if not bit(insn, 20):
                    if not bit(insn, 15):
                      if not bit(insn, 5):
                        #i: ((1, 1, 1, 1, 0, 0, 1, 1, 0, 1, 0, 0, None, None, None, None, 0, None, None, None, None, None, None, None, None, None, 0, None, None, None, None, None), [('Rn', 19, 16), ('imm3', 14, 12), ('Rd', 11, 8), ('imm2', 7, 6), ('widthm1', 4, 0)], 'SBFX<c> <Rd>,<Rn>,#<lsb>,#<width>', False)
                        #SBFX<c> <Rd>,<Rn>,#<lsb>,#<width>
                        #(1, 1, 1, 1, 0, 0, 1, 1, 0, 1, 0, 0, None, None, None, None, 0, None, None, None, None, None, None, None, None, None, 0, None, None, None, None, None)
                        block:
                          var Rn : TEnt = Reg(b2int(insn[19,16]))
                          var imm3 : TBinary = insn[14,12]
                          var Rd : TEnt = Reg(b2int(insn[11,8]))
                          var imm2 : TBinary = insn[7,6]
                          var widthm1 : TBinary = insn[4,0]
                          
                          nil
              else:
                if not bit(insn, 20):
                  if not bit(insn, 15):
                    if not bit(insn, 5):
                      #i: ((1, 1, 1, 1, 0, 0, 1, 1, 0, 0, None, 0, None, None, None, None, 0, None, None, None, None, None, None, None, None, None, 0, None, None, None, None, None), [('sh', 21, 21), ('Rn', 19, 16), ('imm3', 14, 12), ('Rd', 11, 8), ('imm2', 7, 6), ('sat_imm', 4, 0)], 'SSAT<c> <Rd>,#<imm5>,<Rn>{,<shift>}', False)
                      #SSAT<c> <Rd>,#<imm5>,<Rn>{,<shift>}
                      #(1, 1, 1, 1, 0, 0, 1, 1, 0, 0, None, 0, None, None, None, None, 0, None, None, None, None, None, None, None, None, None, 0, None, None, None, None, None)
                      block:
                        var sh : TBinary = insn[21,21]
                        var Rn : TEnt = Reg(b2int(insn[19,16]))
                        var imm3 : TBinary = insn[14,12]
                        var Rd : TEnt = Reg(b2int(insn[11,8]))
                        var imm2 : TBinary = insn[7,6]
                        var sat_imm : TBinary = insn[4,0]
                        
                        nil
      if bit(insn, 25):
        if not bit(insn, 24):
          if bit(insn, 23):
            if bit(insn, 22):
              if not bit(insn, 21):
                if not bit(insn, 20):
                  if not bit(insn, 15):
                    #i: ((1, 1, 1, 1, 0, None, 1, 0, 1, 1, 0, 0, None, None, None, None, 0, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None), [('i', 26, 26), ('imm4', 19, 16), ('imm3', 14, 12), ('Rd', 11, 8), ('imm8', 7, 0)], 'MOVT<c> <Rd>,#<imm16>', False)
                    #MOVT<c> <Rd>,#<imm16>
                    #(1, 1, 1, 1, 0, None, 1, 0, 1, 1, 0, 0, None, None, None, None, 0, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None)
                    block:
                      var i : TBinary = insn[26,26]
                      var imm4 : TBinary = insn[19,16]
                      var imm3 : TBinary = insn[14,12]
                      var Rd : TEnt = Reg(b2int(insn[11,8]))
                      var imm8 : TBinary = insn[7,0]
                      
                      nil
            else:
              if bit(insn, 21):
                if not bit(insn, 20):
                  if bit(insn, 19):
                    if bit(insn, 18):
                      if bit(insn, 17):
                        if bit(insn, 16):
                          if not bit(insn, 15):
                            #i: ((1, 1, 1, 1, 0, None, 1, 0, 1, 0, 1, 0, 1, 1, 1, 1, 0, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None), [('i', 26, 26), ('imm3', 14, 12), ('Rd', 11, 8), ('imm8', 7, 0)], 'SUB <Rd>,PC,#0 Special case for zero offset', True)
                            #SUB <Rd>,PC,#0 Special case for zero offset
                            #(1, 1, 1, 1, 0, None, 1, 0, 1, 0, 1, 0, 1, 1, 1, 1, 0, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None)
                            block:
                              var i : TBinary = insn[26,26]
                              var imm3 : TBinary = insn[14,12]
                              var Rd : TEnt = Reg(b2int(insn[11,8]))
                              var imm8 : TBinary = insn[7,0]
                              return z(opADR, 0, Rd, PC, PCRel(-(!cat(i, imm3, imm8))))
                              nil
                      else:
                        if bit(insn, 16):
                          if not bit(insn, 15):
                            #i: ((1, 1, 1, 1, 0, None, 1, 0, 1, 0, 1, 0, 1, 1, 0, 1, 0, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None), [('i', 26, 26), ('imm3', 14, 12), ('Rd', 11, 8), ('imm8', 7, 0)], 'SUBW<c> <Rd>,SP,#<imm12>', True)
                            #SUBW<c> <Rd>,SP,#<imm12>
                            #(1, 1, 1, 1, 0, None, 1, 0, 1, 0, 1, 0, 1, 1, 0, 1, 0, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None)
                            block:
                              var i : TBinary = insn[26,26]
                              var imm3 : TBinary = insn[14,12]
                              var Rd : TEnt = Reg(b2int(insn[11,8]))
                              var imm8 : TBinary = insn[7,0]
                              
                              nil
                  if not bit(insn, 15):
                    #i: ((1, 1, 1, 1, 0, None, 1, 0, 1, 0, 1, 0, None, None, None, None, 0, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None), [('i', 26, 26), ('Rn', 19, 16), ('imm3', 14, 12), ('Rd', 11, 8), ('imm8', 7, 0)], 'SUBW<c> <Rd>,<Rn>,#<imm12>', False)
                    #SUBW<c> <Rd>,<Rn>,#<imm12>
                    #(1, 1, 1, 1, 0, None, 1, 0, 1, 0, 1, 0, None, None, None, None, 0, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None)
                    block:
                      var i : TBinary = insn[26,26]
                      var Rn : TEnt = Reg(b2int(insn[19,16]))
                      var imm3 : TBinary = insn[14,12]
                      var Rd : TEnt = Reg(b2int(insn[11,8]))
                      var imm8 : TBinary = insn[7,0]
                      
                      nil
          else:
            if bit(insn, 22):
              if not bit(insn, 21):
                if not bit(insn, 20):
                  if not bit(insn, 15):
                    #i: ((1, 1, 1, 1, 0, None, 1, 0, 0, 1, 0, 0, None, None, None, None, 0, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None), [('i', 26, 26), ('imm4', 19, 16), ('imm3', 14, 12), ('Rd', 11, 8), ('imm8', 7, 0)], 'MOVW<c> <Rd>,#<imm16>', False)
                    #MOVW<c> <Rd>,#<imm16>
                    #(1, 1, 1, 1, 0, None, 1, 0, 0, 1, 0, 0, None, None, None, None, 0, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None)
                    block:
                      var i : TBinary = insn[26,26]
                      var imm4 : TBinary = insn[19,16]
                      var imm3 : TBinary = insn[14,12]
                      var Rd : TEnt = Reg(b2int(insn[11,8]))
                      var imm8 : TBinary = insn[7,0]
                      
                      nil
            else:
              if not bit(insn, 21):
                if not bit(insn, 20):
                  if bit(insn, 19):
                    if bit(insn, 18):
                      if bit(insn, 17):
                        if bit(insn, 16):
                          if not bit(insn, 15):
                            #i: ((1, 1, 1, 1, 0, None, 1, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None), [('i', 26, 26), ('imm3', 14, 12), ('Rd', 11, 8), ('imm8', 7, 0)], 'ADR<c>.W <Rd>,<label> <label> after current instruction', True)
                            #ADR<c>.W <Rd>,<label> <label> after current instruction
                            #(1, 1, 1, 1, 0, None, 1, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None)
                            block:
                              var i : TBinary = insn[26,26]
                              var imm3 : TBinary = insn[14,12]
                              var Rd : TEnt = Reg(b2int(insn[11,8]))
                              var imm8 : TBinary = insn[7,0]
                              return z(opADR, 0, Rd, PC, PCRel(!cat(i, imm3, imm8)))
                              nil
                      else:
                        if bit(insn, 16):
                          if not bit(insn, 15):
                            #i: ((1, 1, 1, 1, 0, None, 1, 0, 0, 0, 0, 0, 1, 1, 0, 1, 0, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None), [('i', 26, 26), ('imm3', 14, 12), ('Rd', 11, 8), ('imm8', 7, 0)], 'ADDW<c> <Rd>,SP,#<imm12>', True)
                            #ADDW<c> <Rd>,SP,#<imm12>
                            #(1, 1, 1, 1, 0, None, 1, 0, 0, 0, 0, 0, 1, 1, 0, 1, 0, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None)
                            block:
                              var i : TBinary = insn[26,26]
                              var imm3 : TBinary = insn[14,12]
                              var Rd : TEnt = Reg(b2int(insn[11,8]))
                              var imm8 : TBinary = insn[7,0]
                              return z(opADD, 0, Rd, SP, cat(i, imm3, imm8))
                              nil
                  if not bit(insn, 15):
                    #i: ((1, 1, 1, 1, 0, None, 1, 0, 0, 0, 0, 0, None, None, None, None, 0, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None), [('i', 26, 26), ('Rn', 19, 16), ('imm3', 14, 12), ('Rd', 11, 8), ('imm8', 7, 0)], 'ADDW<c> <Rd>,<Rn>,#<imm12>', False)
                    #ADDW<c> <Rd>,<Rn>,#<imm12>
                    #(1, 1, 1, 1, 0, None, 1, 0, 0, 0, 0, 0, None, None, None, None, 0, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None)
                    block:
                      var i : TBinary = insn[26,26]
                      var Rn : TEnt = Reg(b2int(insn[19,16]))
                      var imm3 : TBinary = insn[14,12]
                      var Rd : TEnt = Reg(b2int(insn[11,8]))
                      var imm8 : TBinary = insn[7,0]
                      return z(opADD, 0, Rd, Rn, cat(i, imm3, imm8))
                      nil
      else:
        if bit(insn, 24):
          if bit(insn, 23):
            if bit(insn, 22):
              if not bit(insn, 21):
                if not bit(insn, 15):
                  #i: ((1, 1, 1, 1, 0, None, 0, 1, 1, 1, 0, None, None, None, None, None, 0, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None), [('i', 26, 26), ('S', 20, 20), ('Rn', 19, 16), ('imm3', 14, 12), ('Rd', 11, 8), ('imm8', 7, 0)], 'RSB{S}<c>.W <Rd>,<Rn>,#<const>', False)
                  #RSB{S}<c>.W <Rd>,<Rn>,#<const>
                  #(1, 1, 1, 1, 0, None, 0, 1, 1, 1, 0, None, None, None, None, None, 0, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None)
                  block:
                    var i : TBinary = insn[26,26]
                    var S : int = b2int(insn[20,20])
                    var Rn : TEnt = Reg(b2int(insn[19,16]))
                    var imm3 : TBinary = insn[14,12]
                    var Rd : TEnt = Reg(b2int(insn[11,8]))
                    var imm8 : TBinary = insn[7,0]
                    
                    nil
            else:
              if bit(insn, 21):
                if bit(insn, 20):
                  if not bit(insn, 15):
                    if bit(insn, 11):
                      if bit(insn, 10):
                        if bit(insn, 9):
                          if bit(insn, 8):
                            #i: ((1, 1, 1, 1, 0, None, 0, 1, 1, 0, 1, 1, None, None, None, None, 0, None, None, None, 1, 1, 1, 1, None, None, None, None, None, None, None, None), [('i', 26, 26), ('Rn', 19, 16), ('imm3', 14, 12), ('imm8', 7, 0)], 'CMP<c>.W <Rn>,#<const>', True)
                            #CMP<c>.W <Rn>,#<const>
                            #(1, 1, 1, 1, 0, None, 0, 1, 1, 0, 1, 1, None, None, None, None, 0, None, None, None, 1, 1, 1, 1, None, None, None, None, None, None, None, None)
                            block:
                              var i : TBinary = insn[26,26]
                              var Rn : TEnt = Reg(b2int(insn[19,16]))
                              var imm3 : TBinary = insn[14,12]
                              var imm8 : TBinary = insn[7,0]
                              return z(opCMP, 1, Rn, TEImm(cat(i, imm3, imm8)))
                              nil
                if bit(insn, 19):
                  if bit(insn, 18):
                    if not bit(insn, 17):
                      if bit(insn, 16):
                        if not bit(insn, 15):
                          #i: ((1, 1, 1, 1, 0, None, 0, 1, 1, 0, 1, None, 1, 1, 0, 1, 0, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None), [('i', 26, 26), ('S', 20, 20), ('imm3', 14, 12), ('Rd', 11, 8), ('imm8', 7, 0)], 'SUB{S}<c>.W <Rd>,SP,#<const>', True)
                          #SUB{S}<c>.W <Rd>,SP,#<const>
                          #(1, 1, 1, 1, 0, None, 0, 1, 1, 0, 1, None, 1, 1, 0, 1, 0, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None)
                          block:
                            var i : TBinary = insn[26,26]
                            var S : int = b2int(insn[20,20])
                            var imm3 : TBinary = insn[14,12]
                            var Rd : TEnt = Reg(b2int(insn[11,8]))
                            var imm8 : TBinary = insn[7,0]
                            
                            nil
                if not bit(insn, 15):
                  #i: ((1, 1, 1, 1, 0, None, 0, 1, 1, 0, 1, None, None, None, None, None, 0, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None), [('i', 26, 26), ('S', 20, 20), ('Rn', 19, 16), ('imm3', 14, 12), ('Rd', 11, 8), ('imm8', 7, 0)], 'SUB{S}<c>.W <Rd>,<Rn>,#<const>', False)
                  #SUB{S}<c>.W <Rd>,<Rn>,#<const>
                  #(1, 1, 1, 1, 0, None, 0, 1, 1, 0, 1, None, None, None, None, None, 0, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None)
                  block:
                    var i : TBinary = insn[26,26]
                    var S : int = b2int(insn[20,20])
                    var Rn : TEnt = Reg(b2int(insn[19,16]))
                    var imm3 : TBinary = insn[14,12]
                    var Rd : TEnt = Reg(b2int(insn[11,8]))
                    var imm8 : TBinary = insn[7,0]
                    
                    nil
          else:
            if bit(insn, 22):
              if bit(insn, 21):
                if not bit(insn, 15):
                  #i: ((1, 1, 1, 1, 0, None, 0, 1, 0, 1, 1, None, None, None, None, None, 0, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None), [('i', 26, 26), ('S', 20, 20), ('Rn', 19, 16), ('imm3', 14, 12), ('Rd', 11, 8), ('imm8', 7, 0)], 'SBC{S}<c> <Rd>,<Rn>,#<const>', False)
                  #SBC{S}<c> <Rd>,<Rn>,#<const>
                  #(1, 1, 1, 1, 0, None, 0, 1, 0, 1, 1, None, None, None, None, None, 0, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None)
                  block:
                    var i : TBinary = insn[26,26]
                    var S : int = b2int(insn[20,20])
                    var Rn : TEnt = Reg(b2int(insn[19,16]))
                    var imm3 : TBinary = insn[14,12]
                    var Rd : TEnt = Reg(b2int(insn[11,8]))
                    var imm8 : TBinary = insn[7,0]
                    
                    nil
              else:
                if not bit(insn, 15):
                  #i: ((1, 1, 1, 1, 0, None, 0, 1, 0, 1, 0, None, None, None, None, None, 0, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None), [('i', 26, 26), ('S', 20, 20), ('Rn', 19, 16), ('imm3', 14, 12), ('Rd', 11, 8), ('imm8', 7, 0)], 'ADC{S}<c> <Rd>,<Rn>,#<const>', False)
                  #ADC{S}<c> <Rd>,<Rn>,#<const>
                  #(1, 1, 1, 1, 0, None, 0, 1, 0, 1, 0, None, None, None, None, None, 0, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None)
                  block:
                    var i : TBinary = insn[26,26]
                    var S : int = b2int(insn[20,20])
                    var Rn : TEnt = Reg(b2int(insn[19,16]))
                    var imm3 : TBinary = insn[14,12]
                    var Rd : TEnt = Reg(b2int(insn[11,8]))
                    var imm8 : TBinary = insn[7,0]
                    return z(opADC, S, @Rd, @Rn, @TEImm(cat(i, imm3, imm8)))
                    nil
            else:
              if not bit(insn, 21):
                if bit(insn, 20):
                  if not bit(insn, 15):
                    if bit(insn, 11):
                      if bit(insn, 10):
                        if bit(insn, 9):
                          if bit(insn, 8):
                            #i: ((1, 1, 1, 1, 0, None, 0, 1, 0, 0, 0, 1, None, None, None, None, 0, None, None, None, 1, 1, 1, 1, None, None, None, None, None, None, None, None), [('i', 26, 26), ('Rn', 19, 16), ('imm3', 14, 12), ('imm8', 7, 0)], 'CMN<c> <Rn>,#<const>', True)
                            #CMN<c> <Rn>,#<const>
                            #(1, 1, 1, 1, 0, None, 0, 1, 0, 0, 0, 1, None, None, None, None, 0, None, None, None, 1, 1, 1, 1, None, None, None, None, None, None, None, None)
                            block:
                              var i : TBinary = insn[26,26]
                              var Rn : TEnt = Reg(b2int(insn[19,16]))
                              var imm3 : TBinary = insn[14,12]
                              var imm8 : TBinary = insn[7,0]
                              return z(opCMN, 1, Rn, TEImm(cat(i, imm3, imm8)))
                              nil
                if bit(insn, 19):
                  if bit(insn, 18):
                    if not bit(insn, 17):
                      if bit(insn, 16):
                        if not bit(insn, 15):
                          #i: ((1, 1, 1, 1, 0, None, 0, 1, 0, 0, 0, None, 1, 1, 0, 1, 0, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None), [('i', 26, 26), ('S', 20, 20), ('imm3', 14, 12), ('Rd', 11, 8), ('imm8', 7, 0)], 'ADD{S}<c>.W <Rd>,SP,#<const>', True)
                          #ADD{S}<c>.W <Rd>,SP,#<const>
                          #(1, 1, 1, 1, 0, None, 0, 1, 0, 0, 0, None, 1, 1, 0, 1, 0, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None)
                          block:
                            var i : TBinary = insn[26,26]
                            var S : int = b2int(insn[20,20])
                            var imm3 : TBinary = insn[14,12]
                            var Rd : TEnt = Reg(b2int(insn[11,8]))
                            var imm8 : TBinary = insn[7,0]
                            if Rd == PC and S.bit: break
                            return z(opADD, S, Rd, Sp, TEImm(cat(i, imm3, imm8)))
                            nil
                if not bit(insn, 15):
                  #i: ((1, 1, 1, 1, 0, None, 0, 1, 0, 0, 0, None, None, None, None, None, 0, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None), [('i', 26, 26), ('S', 20, 20), ('Rn', 19, 16), ('imm3', 14, 12), ('Rd', 11, 8), ('imm8', 7, 0)], 'ADD{S}<c>.W <Rd>,<Rn>,#<const>', False)
                  #ADD{S}<c>.W <Rd>,<Rn>,#<const>
                  #(1, 1, 1, 1, 0, None, 0, 1, 0, 0, 0, None, None, None, None, None, 0, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None)
                  block:
                    var i : TBinary = insn[26,26]
                    var S : int = b2int(insn[20,20])
                    var Rn : TEnt = Reg(b2int(insn[19,16]))
                    var imm3 : TBinary = insn[14,12]
                    var Rd : TEnt = Reg(b2int(insn[11,8]))
                    var imm8 : TBinary = insn[7,0]
                    return z(opADD, S, Rd, Rn, TEImm(cat(i, imm3, imm8)))
                    nil
        else:
          if bit(insn, 23):
            if not bit(insn, 22):
              if not bit(insn, 21):
                if bit(insn, 20):
                  if not bit(insn, 15):
                    if bit(insn, 11):
                      if bit(insn, 10):
                        if bit(insn, 9):
                          if bit(insn, 8):
                            #i: ((1, 1, 1, 1, 0, None, 0, 0, 1, 0, 0, 1, None, None, None, None, 0, None, None, None, 1, 1, 1, 1, None, None, None, None, None, None, None, None), [('i', 26, 26), ('Rn', 19, 16), ('imm3', 14, 12), ('imm8', 7, 0)], 'TEQ<c> <Rn>,#<const>', True)
                            #TEQ<c> <Rn>,#<const>
                            #(1, 1, 1, 1, 0, None, 0, 0, 1, 0, 0, 1, None, None, None, None, 0, None, None, None, 1, 1, 1, 1, None, None, None, None, None, None, None, None)
                            block:
                              var i : TBinary = insn[26,26]
                              var Rn : TEnt = Reg(b2int(insn[19,16]))
                              var imm3 : TBinary = insn[14,12]
                              var imm8 : TBinary = insn[7,0]
                              
                              nil
                if not bit(insn, 15):
                  #i: ((1, 1, 1, 1, 0, None, 0, 0, 1, 0, 0, None, None, None, None, None, 0, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None), [('i', 26, 26), ('S', 20, 20), ('Rn', 19, 16), ('imm3', 14, 12), ('Rd', 11, 8), ('imm8', 7, 0)], 'EOR{S}<c> <Rd>,<Rn>,#<const>', False)
                  #EOR{S}<c> <Rd>,<Rn>,#<const>
                  #(1, 1, 1, 1, 0, None, 0, 0, 1, 0, 0, None, None, None, None, None, 0, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None)
                  block:
                    var i : TBinary = insn[26,26]
                    var S : int = b2int(insn[20,20])
                    var Rn : TEnt = Reg(b2int(insn[19,16]))
                    var imm3 : TBinary = insn[14,12]
                    var Rd : TEnt = Reg(b2int(insn[11,8]))
                    var imm8 : TBinary = insn[7,0]
                    return z(opEOR, S, Rd, Rn, TEImm(cat(i, imm3, imm8)))
                    nil
          else:
            if bit(insn, 22):
              if bit(insn, 21):
                if bit(insn, 19):
                  if bit(insn, 18):
                    if bit(insn, 17):
                      if bit(insn, 16):
                        if not bit(insn, 15):
                          #i: ((1, 1, 1, 1, 0, None, 0, 0, 0, 1, 1, None, 1, 1, 1, 1, 0, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None), [('i', 26, 26), ('S', 20, 20), ('imm3', 14, 12), ('Rd', 11, 8), ('imm8', 7, 0)], 'MVN{S}<c> <Rd>,#<const>', True)
                          #MVN{S}<c> <Rd>,#<const>
                          #(1, 1, 1, 1, 0, None, 0, 0, 0, 1, 1, None, 1, 1, 1, 1, 0, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None)
                          block:
                            var i : TBinary = insn[26,26]
                            var S : int = b2int(insn[20,20])
                            var imm3 : TBinary = insn[14,12]
                            var Rd : TEnt = Reg(b2int(insn[11,8]))
                            var imm8 : TBinary = insn[7,0]
                            
                            nil
                if not bit(insn, 15):
                  #i: ((1, 1, 1, 1, 0, None, 0, 0, 0, 1, 1, None, None, None, None, None, 0, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None), [('i', 26, 26), ('S', 20, 20), ('Rn', 19, 16), ('imm3', 14, 12), ('Rd', 11, 8), ('imm8', 7, 0)], 'ORN{S}<c> <Rd>,<Rn>,#<const>', False)
                  #ORN{S}<c> <Rd>,<Rn>,#<const>
                  #(1, 1, 1, 1, 0, None, 0, 0, 0, 1, 1, None, None, None, None, None, 0, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None)
                  block:
                    var i : TBinary = insn[26,26]
                    var S : int = b2int(insn[20,20])
                    var Rn : TEnt = Reg(b2int(insn[19,16]))
                    var imm3 : TBinary = insn[14,12]
                    var Rd : TEnt = Reg(b2int(insn[11,8]))
                    var imm8 : TBinary = insn[7,0]
                    
                    nil
              else:
                if bit(insn, 19):
                  if bit(insn, 18):
                    if bit(insn, 17):
                      if bit(insn, 16):
                        if not bit(insn, 15):
                          #i: ((1, 1, 1, 1, 0, None, 0, 0, 0, 1, 0, None, 1, 1, 1, 1, 0, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None), [('i', 26, 26), ('S', 20, 20), ('imm3', 14, 12), ('Rd', 11, 8), ('imm8', 7, 0)], 'MOV{S}<c>.W <Rd>,#<const>', True)
                          #MOV{S}<c>.W <Rd>,#<const>
                          #(1, 1, 1, 1, 0, None, 0, 0, 0, 1, 0, None, 1, 1, 1, 1, 0, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None)
                          block:
                            var i : TBinary = insn[26,26]
                            var S : int = b2int(insn[20,20])
                            var imm3 : TBinary = insn[14,12]
                            var Rd : TEnt = Reg(b2int(insn[11,8]))
                            var imm8 : TBinary = insn[7,0]
                            
                            nil
                if not bit(insn, 15):
                  #i: ((1, 1, 1, 1, 0, None, 0, 0, 0, 1, 0, None, None, None, None, None, 0, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None), [('i', 26, 26), ('S', 20, 20), ('Rn', 19, 16), ('imm3', 14, 12), ('Rd', 11, 8), ('imm8', 7, 0)], 'ORR{S}<c> <Rd>,<Rn>,#<const>', False)
                  #ORR{S}<c> <Rd>,<Rn>,#<const>
                  #(1, 1, 1, 1, 0, None, 0, 0, 0, 1, 0, None, None, None, None, None, 0, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None)
                  block:
                    var i : TBinary = insn[26,26]
                    var S : int = b2int(insn[20,20])
                    var Rn : TEnt = Reg(b2int(insn[19,16]))
                    var imm3 : TBinary = insn[14,12]
                    var Rd : TEnt = Reg(b2int(insn[11,8]))
                    var imm8 : TBinary = insn[7,0]
                    
                    nil
            else:
              if bit(insn, 21):
                if not bit(insn, 15):
                  #i: ((1, 1, 1, 1, 0, None, 0, 0, 0, 0, 1, None, None, None, None, None, 0, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None), [('i', 26, 26), ('S', 20, 20), ('Rn', 19, 16), ('imm3', 14, 12), ('Rd', 11, 8), ('imm8', 7, 0)], 'BIC{S}<c> <Rd>,<Rn>,#<const>', False)
                  #BIC{S}<c> <Rd>,<Rn>,#<const>
                  #(1, 1, 1, 1, 0, None, 0, 0, 0, 0, 1, None, None, None, None, None, 0, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None)
                  block:
                    var i : TBinary = insn[26,26]
                    var S : int = b2int(insn[20,20])
                    var Rn : TEnt = Reg(b2int(insn[19,16]))
                    var imm3 : TBinary = insn[14,12]
                    var Rd : TEnt = Reg(b2int(insn[11,8]))
                    var imm8 : TBinary = insn[7,0]
                    var r = TEImm_C(cat(i, imm3, imm8))
                    return z(opBIC, S or r.setCarry, Rd, Rn, r.ent)
                    nil
              else:
                if bit(insn, 20):
                  if not bit(insn, 15):
                    if bit(insn, 11):
                      if bit(insn, 10):
                        if bit(insn, 9):
                          if bit(insn, 8):
                            #i: ((1, 1, 1, 1, 0, None, 0, 0, 0, 0, 0, 1, None, None, None, None, 0, None, None, None, 1, 1, 1, 1, None, None, None, None, None, None, None, None), [('i', 26, 26), ('Rn', 19, 16), ('imm3', 14, 12), ('imm8', 7, 0)], 'TST<c> <Rn>,#<const>', True)
                            #TST<c> <Rn>,#<const>
                            #(1, 1, 1, 1, 0, None, 0, 0, 0, 0, 0, 1, None, None, None, None, 0, None, None, None, 1, 1, 1, 1, None, None, None, None, None, None, None, None)
                            block:
                              var i : TBinary = insn[26,26]
                              var Rn : TEnt = Reg(b2int(insn[19,16]))
                              var imm3 : TBinary = insn[14,12]
                              var imm8 : TBinary = insn[7,0]
                              
                              nil
                if not bit(insn, 15):
                  #i: ((1, 1, 1, 1, 0, None, 0, 0, 0, 0, 0, None, None, None, None, None, 0, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None), [('i', 26, 26), ('S', 20, 20), ('Rn', 19, 16), ('imm3', 14, 12), ('Rd', 11, 8), ('imm8', 7, 0)], 'AND{S}<c> <Rd>,<Rn>,#<const>', False)
                  #AND{S}<c> <Rd>,<Rn>,#<const>
                  #(1, 1, 1, 1, 0, None, 0, 0, 0, 0, 0, None, None, None, None, None, 0, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None)
                  block:
                    var i : TBinary = insn[26,26]
                    var S : int = b2int(insn[20,20])
                    var Rn : TEnt = Reg(b2int(insn[19,16]))
                    var imm3 : TBinary = insn[14,12]
                    var Rd : TEnt = Reg(b2int(insn[11,8]))
                    var imm8 : TBinary = insn[7,0]
                    if Rd == PC and S.bit: break
                    var r = TEImm_C(cat(i, imm3, imm8))
                    return z(opAND, S or r.setCarry, Rd, Rn, r.ent)
                    nil
      if bit(insn, 15):
        if bit(insn, 14):
          if bit(insn, 12):
            #i: ((1, 1, 1, 1, 0, None, None, None, None, None, None, None, None, None, None, None, 1, 1, None, 1, None, None, None, None, None, None, None, None, None, None, None, None), [('S', 26, 26), ('imm10', 25, 16), ('J1', 13, 13), ('J2', 11, 11), ('imm11', 10, 0)], 'BL<c> <label>', False)
            #BL<c> <label>
            #(1, 1, 1, 1, 0, None, None, None, None, None, None, None, None, None, None, None, 1, 1, None, 1, None, None, None, None, None, None, None, None, None, None, None, None)
            block:
              var S : int = b2int(insn[26,26])
              var imm10 : TBinary = insn[25,16]
              var J1 : TBinary = insn[13,13]
              var J2 : TBinary = insn[11,11]
              var imm11 : TBinary = insn[10,0]
              return z(opBL, 0, PCRel(!sxt(cat(Binary(s, 1), J1, J2, imm10, imm11, b"0"))))
              nil
        else:
          if bit(insn, 12):
            #i: ((1, 1, 1, 1, 0, None, None, None, None, None, None, None, None, None, None, None, 1, 0, None, 1, None, None, None, None, None, None, None, None, None, None, None, None), [('S', 26, 26), ('imm10', 25, 16), ('J1', 13, 13), ('J2', 11, 11), ('imm11', 10, 0)], 'B<c>.W <label>', False)
            #B<c>.W <label>
            #(1, 1, 1, 1, 0, None, None, None, None, None, None, None, None, None, None, None, 1, 0, None, 1, None, None, None, None, None, None, None, None, None, None, None, None)
            block:
              var S : int = b2int(insn[26,26])
              var imm10 : TBinary = insn[25,16]
              var J1 : TBinary = insn[13,13]
              var J2 : TBinary = insn[11,11]
              var imm11 : TBinary = insn[10,0]
              return z(opB, S, PCRel(!sxt(cat(Binary(s, 1), J1, J2, imm10, imm11, b"0"))))
              nil
          else:
            #i: ((1, 1, 1, 1, 0, None, None, None, None, None, None, None, None, None, None, None, 1, 0, None, 0, None, None, None, None, None, None, None, None, None, None, None, None), [('S', 26, 26), ('cond', 25, 22), ('imm6', 21, 16), ('J1', 13, 13), ('J2', 11, 11), ('imm11', 10, 0)], 'B<c>.W <label>', False)
            #B<c>.W <label>
            #(1, 1, 1, 1, 0, None, None, None, None, None, None, None, None, None, None, None, 1, 0, None, 0, None, None, None, None, None, None, None, None, None, None, None, None)
            block:
              var S : int = b2int(insn[26,26])
              var cond : TBinary = insn[25,22]
              var imm6 : TBinary = insn[21,16]
              var J1 : TBinary = insn[13,13]
              var J2 : TBinary = insn[11,11]
              var imm11 : TBinary = insn[10,0]
              break # why is this not documented@? page a6-40
              nil
  else:
    if bit(insn, 27):
      if bit(insn, 26):
        if bit(insn, 25):
          if not bit(insn, 24):
            if bit(insn, 20):
              if bit(insn, 4):
                #i: ((1, 1, 1, 0, 1, 1, 1, 0, None, None, None, 1, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, 1, None, None, None, None), [('opc1', 23, 21), ('CRn', 19, 16), ('Rt', 15, 12), ('coproc', 11, 8), ('opc2', 7, 5), ('CRm', 3, 0)], 'MRC<c> <coproc>,<opc1>,<Rt>,<CRn>,<CRm>{,<opc2>}', False)
                #MRC<c> <coproc>,<opc1>,<Rt>,<CRn>,<CRm>{,<opc2>}
                #(1, 1, 1, 0, 1, 1, 1, 0, None, None, None, 1, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, 1, None, None, None, None)
                block:
                  var opc1 : TBinary = insn[23,21]
                  var CRn : TBinary = insn[19,16]
                  var Rt : TEnt = Reg(b2int(insn[15,12]))
                  var coproc : TBinary = insn[11,8]
                  var opc2 : TBinary = insn[7,5]
                  var CRm : TBinary = insn[3,0]
                  
                  nil
            else:
              if bit(insn, 4):
                #i: ((1, 1, 1, 0, 1, 1, 1, 0, None, None, None, 0, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, 1, None, None, None, None), [('opc1', 23, 21), ('CRn', 19, 16), ('Rt', 15, 12), ('coproc', 11, 8), ('opc2', 7, 5), ('CRm', 3, 0)], 'MCR<c> <coproc>,<opc1>,<Rt>,<CRn>,<CRm>{,<opc2>}', False)
                #MCR<c> <coproc>,<opc1>,<Rt>,<CRn>,<CRm>{,<opc2>}
                #(1, 1, 1, 0, 1, 1, 1, 0, None, None, None, 0, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, 1, None, None, None, None)
                block:
                  var opc1 : TBinary = insn[23,21]
                  var CRn : TBinary = insn[19,16]
                  var Rt : TEnt = Reg(b2int(insn[15,12]))
                  var coproc : TBinary = insn[11,8]
                  var opc2 : TBinary = insn[7,5]
                  var CRm : TBinary = insn[3,0]
                  
                  nil
            if not bit(insn, 4):
              #i: ((1, 1, 1, 0, 1, 1, 1, 0, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, 0, None, None, None, None), [('opc1', 23, 20), ('CRn', 19, 16), ('CRd', 15, 12), ('coproc', 11, 8), ('opc2', 7, 5), ('CRm', 3, 0)], 'CDP<c> <coproc>,<opc1>,<CRd>,<CRn>,<CRm>,<opc2>', False)
              #CDP<c> <coproc>,<opc1>,<CRd>,<CRn>,<CRm>,<opc2>
              #(1, 1, 1, 0, 1, 1, 1, 0, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, 0, None, None, None, None)
              block:
                var opc1 : TBinary = insn[23,20]
                var CRn : TBinary = insn[19,16]
                var CRd : TBinary = insn[15,12]
                var coproc : TBinary = insn[11,8]
                var opc2 : TBinary = insn[7,5]
                var CRm : TBinary = insn[3,0]
                return z(opCDP, 0, coproc, opc1, CRd, CRn, CRm, opc2)
                nil
        else:
          if not bit(insn, 24):
            if not bit(insn, 23):
              if bit(insn, 22):
                if not bit(insn, 21):
                  if bit(insn, 20):
                    #i: ((1, 1, 1, 0, 1, 1, 0, 0, 0, 1, 0, 1, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None), [('Rt2', 19, 16), ('Rt', 15, 12), ('coproc', 11, 8), ('opc1', 7, 4), ('CRm', 3, 0)], 'MRRC<c> <coproc>,<opc>,<Rt>,<Rt2>,<CRm>', True)
                    #MRRC<c> <coproc>,<opc>,<Rt>,<Rt2>,<CRm>
                    #(1, 1, 1, 0, 1, 1, 0, 0, 0, 1, 0, 1, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None)
                    block:
                      var Rt2 : TBinary = insn[19,16]
                      var Rt : TEnt = Reg(b2int(insn[15,12]))
                      var coproc : TBinary = insn[11,8]
                      var opc1 : TBinary = insn[7,4]
                      var CRm : TBinary = insn[3,0]
                      
                      nil
                  else:
                    #i: ((1, 1, 1, 0, 1, 1, 0, 0, 0, 1, 0, 0, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None), [('Rt2', 19, 16), ('Rt', 15, 12), ('coproc', 11, 8), ('opc1', 7, 4), ('CRm', 3, 0)], 'MCRR<c> <coproc>,<opc1>,<Rt>,<Rt2>,<CRm>', True)
                    #MCRR<c> <coproc>,<opc1>,<Rt>,<Rt2>,<CRm>
                    #(1, 1, 1, 0, 1, 1, 0, 0, 0, 1, 0, 0, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None)
                    block:
                      var Rt2 : TBinary = insn[19,16]
                      var Rt : TEnt = Reg(b2int(insn[15,12]))
                      var coproc : TBinary = insn[11,8]
                      var opc1 : TBinary = insn[7,4]
                      var CRm : TBinary = insn[3,0]
                      
                      nil
          if bit(insn, 20):
            #i: ((1, 1, 1, 0, 1, 1, 0, None, None, None, None, 1, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None), [('P', 24, 24), ('U', 23, 23), ('D', 22, 22), ('W', 21, 21), ('Rn', 19, 16), ('CRd', 15, 12), ('coproc', 11, 8), ('imm8', 7, 0)], 'LDC{L}<c> <coproc>,<CRd>,[<Rn>],<option>', False)
            #LDC{L}<c> <coproc>,<CRd>,[<Rn>],<option>
            #(1, 1, 1, 0, 1, 1, 0, None, None, None, None, 1, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None)
            block:
              var P : TBinary = insn[24,24]
              var U : TBinary = insn[23,23]
              var D : TBinary = insn[22,22]
              var W : TBinary = insn[21,21]
              var Rn : TEnt = Reg(b2int(insn[19,16]))
              var CRd : TBinary = insn[15,12]
              var coproc : TBinary = insn[11,8]
              var imm8 : TBinary = insn[7,0]
              if P == b"0" and W == b"0": break
              return z(opLDC, 0, coproc, Deref(Rn, @cat(imm8, b"00"), P.bit, W.bit, U.bit))
              nil
          else:
            #i: ((1, 1, 1, 0, 1, 1, 0, None, None, None, None, 0, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None), [('P', 24, 24), ('U', 23, 23), ('N', 22, 22), ('W', 21, 21), ('Rn', 19, 16), ('CRd', 15, 12), ('coproc', 11, 8), ('imm8', 7, 0)], 'STC{L}<c> <coproc>,<CRd>,[<Rn>],<option>', False)
            #STC{L}<c> <coproc>,<CRd>,[<Rn>],<option>
            #(1, 1, 1, 0, 1, 1, 0, None, None, None, None, 0, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None)
            block:
              var P : TBinary = insn[24,24]
              var U : TBinary = insn[23,23]
              var N : TBinary = insn[22,22]
              var W : TBinary = insn[21,21]
              var Rn : TEnt = Reg(b2int(insn[19,16]))
              var CRd : TBinary = insn[15,12]
              var coproc : TBinary = insn[11,8]
              var imm8 : TBinary = insn[7,0]
              
              nil
      else:
        if bit(insn, 25):
          if bit(insn, 24):
            if bit(insn, 23):
              if bit(insn, 22):
                if not bit(insn, 21):
                  if not bit(insn, 15):
                    #i: ((1, 1, 1, 0, 1, 0, 1, 1, 1, 1, 0, None, None, None, None, None, 0, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None), [('S', 20, 20), ('Rn', 19, 16), ('imm3', 14, 12), ('Rd', 11, 8), ('imm2', 7, 6), ('typ', 5, 4), ('Rm', 3, 0)], 'RSB{S}<c> <Rd>,<Rn>,<Rm>{,<shift>}', False)
                    #RSB{S}<c> <Rd>,<Rn>,<Rm>{,<shift>}
                    #(1, 1, 1, 0, 1, 0, 1, 1, 1, 1, 0, None, None, None, None, None, 0, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None)
                    block:
                      var S : int = b2int(insn[20,20])
                      var Rn : TEnt = Reg(b2int(insn[19,16]))
                      var imm3 : TBinary = insn[14,12]
                      var Rd : TEnt = Reg(b2int(insn[11,8]))
                      var imm2 : TBinary = insn[7,6]
                      var typ : TBinary = insn[5,4]
                      var Rm : TEnt = Reg(b2int(insn[3,0]))
                      
                      nil
              else:
                if bit(insn, 21):
                  if bit(insn, 20):
                    if not bit(insn, 15):
                      if bit(insn, 11):
                        if bit(insn, 10):
                          if bit(insn, 9):
                            if bit(insn, 8):
                              #i: ((1, 1, 1, 0, 1, 0, 1, 1, 1, 0, 1, 1, None, None, None, None, 0, None, None, None, 1, 1, 1, 1, None, None, None, None, None, None, None, None), [('Rn', 19, 16), ('imm3', 14, 12), ('imm2', 7, 6), ('typ', 5, 4), ('Rm', 3, 0)], 'CMP<c>.W <Rn>, <Rm> {,<shift>}', True)
                              #CMP<c>.W <Rn>, <Rm> {,<shift>}
                              #(1, 1, 1, 0, 1, 0, 1, 1, 1, 0, 1, 1, None, None, None, None, 0, None, None, None, 1, 1, 1, 1, None, None, None, None, None, None, None, None)
                              block:
                                var Rn : TEnt = Reg(b2int(insn[19,16]))
                                var imm3 : TBinary = insn[14,12]
                                var imm2 : TBinary = insn[7,6]
                                var typ : TBinary = insn[5,4]
                                var Rm : TEnt = Reg(b2int(insn[3,0]))
                                return z(opCMP, 0, Rn, DIShift(Rm, typ, cat(imm3, imm2)))
                                nil
                  if bit(insn, 19):
                    if bit(insn, 18):
                      if not bit(insn, 17):
                        if bit(insn, 16):
                          if not bit(insn, 15):
                            #i: ((1, 1, 1, 0, 1, 0, 1, 1, 1, 0, 1, None, 1, 1, 0, 1, 0, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None), [('S', 20, 20), ('imm3', 14, 12), ('Rd', 11, 8), ('imm2', 7, 6), ('typ', 5, 4), ('Rm', 3, 0)], 'SUB{S}<c> <Rd>,SP,<Rm>{,<shift>}', True)
                            #SUB{S}<c> <Rd>,SP,<Rm>{,<shift>}
                            #(1, 1, 1, 0, 1, 0, 1, 1, 1, 0, 1, None, 1, 1, 0, 1, 0, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None)
                            block:
                              var S : int = b2int(insn[20,20])
                              var imm3 : TBinary = insn[14,12]
                              var Rd : TEnt = Reg(b2int(insn[11,8]))
                              var imm2 : TBinary = insn[7,6]
                              var typ : TBinary = insn[5,4]
                              var Rm : TEnt = Reg(b2int(insn[3,0]))
                              
                              nil
                  if not bit(insn, 15):
                    #i: ((1, 1, 1, 0, 1, 0, 1, 1, 1, 0, 1, None, None, None, None, None, 0, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None), [('S', 20, 20), ('Rn', 19, 16), ('imm3', 14, 12), ('Rd', 11, 8), ('imm2', 7, 6), ('typ', 5, 4), ('Rm', 3, 0)], 'SUB{S}<c>.W <Rd>,<Rn>,<Rm>{,<shift>}', False)
                    #SUB{S}<c>.W <Rd>,<Rn>,<Rm>{,<shift>}
                    #(1, 1, 1, 0, 1, 0, 1, 1, 1, 0, 1, None, None, None, None, None, 0, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None)
                    block:
                      var S : int = b2int(insn[20,20])
                      var Rn : TEnt = Reg(b2int(insn[19,16]))
                      var imm3 : TBinary = insn[14,12]
                      var Rd : TEnt = Reg(b2int(insn[11,8]))
                      var imm2 : TBinary = insn[7,6]
                      var typ : TBinary = insn[5,4]
                      var Rm : TEnt = Reg(b2int(insn[3,0]))
                      
                      nil
            else:
              if bit(insn, 22):
                if bit(insn, 21):
                  if not bit(insn, 15):
                    #i: ((1, 1, 1, 0, 1, 0, 1, 1, 0, 1, 1, None, None, None, None, None, 0, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None), [('S', 20, 20), ('Rn', 19, 16), ('imm3', 14, 12), ('Rd', 11, 8), ('imm2', 7, 6), ('typ', 5, 4), ('Rm', 3, 0)], 'SBC{S}<c>.W <Rd>,<Rn>,<Rm>{,<shift>}', False)
                    #SBC{S}<c>.W <Rd>,<Rn>,<Rm>{,<shift>}
                    #(1, 1, 1, 0, 1, 0, 1, 1, 0, 1, 1, None, None, None, None, None, 0, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None)
                    block:
                      var S : int = b2int(insn[20,20])
                      var Rn : TEnt = Reg(b2int(insn[19,16]))
                      var imm3 : TBinary = insn[14,12]
                      var Rd : TEnt = Reg(b2int(insn[11,8]))
                      var imm2 : TBinary = insn[7,6]
                      var typ : TBinary = insn[5,4]
                      var Rm : TEnt = Reg(b2int(insn[3,0]))
                      
                      nil
                else:
                  if not bit(insn, 15):
                    #i: ((1, 1, 1, 0, 1, 0, 1, 1, 0, 1, 0, None, None, None, None, None, 0, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None), [('S', 20, 20), ('Rn', 19, 16), ('imm3', 14, 12), ('Rd', 11, 8), ('imm2', 7, 6), ('typ', 5, 4), ('Rm', 3, 0)], 'ADC{S}<c>.W <Rd>,<Rn>,<Rm>{,<shift>}', False)
                    #ADC{S}<c>.W <Rd>,<Rn>,<Rm>{,<shift>}
                    #(1, 1, 1, 0, 1, 0, 1, 1, 0, 1, 0, None, None, None, None, None, 0, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None)
                    block:
                      var S : int = b2int(insn[20,20])
                      var Rn : TEnt = Reg(b2int(insn[19,16]))
                      var imm3 : TBinary = insn[14,12]
                      var Rd : TEnt = Reg(b2int(insn[11,8]))
                      var imm2 : TBinary = insn[7,6]
                      var typ : TBinary = insn[5,4]
                      var Rm : TEnt = Reg(b2int(insn[3,0]))
                      return z(opADC, S, Rd, DIShift(Rm, typ, cat(imm3, imm2)))
                      nil
              else:
                if not bit(insn, 21):
                  if bit(insn, 20):
                    if not bit(insn, 15):
                      if bit(insn, 11):
                        if bit(insn, 10):
                          if bit(insn, 9):
                            if bit(insn, 8):
                              #i: ((1, 1, 1, 0, 1, 0, 1, 1, 0, 0, 0, 1, None, None, None, None, 0, None, None, None, 1, 1, 1, 1, None, None, None, None, None, None, None, None), [('Rn', 19, 16), ('imm3', 14, 12), ('imm2', 7, 6), ('typ', 5, 4), ('Rm', 3, 0)], 'CMN<c>.W <Rn>,<Rm>{,<shift>}', True)
                              #CMN<c>.W <Rn>,<Rm>{,<shift>}
                              #(1, 1, 1, 0, 1, 0, 1, 1, 0, 0, 0, 1, None, None, None, None, 0, None, None, None, 1, 1, 1, 1, None, None, None, None, None, None, None, None)
                              block:
                                var Rn : TEnt = Reg(b2int(insn[19,16]))
                                var imm3 : TBinary = insn[14,12]
                                var imm2 : TBinary = insn[7,6]
                                var typ : TBinary = insn[5,4]
                                var Rm : TEnt = Reg(b2int(insn[3,0]))
                                return z(opCMN, 1, Rn, DIShift(Rm, typ, cat(imm3, imm2)))
                                nil
                  if bit(insn, 19):
                    if bit(insn, 18):
                      if not bit(insn, 17):
                        if bit(insn, 16):
                          if not bit(insn, 15):
                            #i: ((1, 1, 1, 0, 1, 0, 1, 1, 0, 0, 0, None, 1, 1, 0, 1, 0, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None), [('S', 20, 20), ('imm3', 14, 12), ('Rd', 11, 8), ('imm2', 7, 6), ('typ', 5, 4), ('Rm', 3, 0)], 'ADD{S}<c>.W <Rd>,SP,<Rm>{,<shift>}', True)
                            #ADD{S}<c>.W <Rd>,SP,<Rm>{,<shift>}
                            #(1, 1, 1, 0, 1, 0, 1, 1, 0, 0, 0, None, 1, 1, 0, 1, 0, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None)
                            block:
                              var S : int = b2int(insn[20,20])
                              var imm3 : TBinary = insn[14,12]
                              var Rd : TEnt = Reg(b2int(insn[11,8]))
                              var imm2 : TBinary = insn[7,6]
                              var typ : TBinary = insn[5,4]
                              var Rm : TEnt = Reg(b2int(insn[3,0]))
                              return z(opADD, S, Rd, SP, DIShift(Rm, typ, cat(imm3, imm2)))
                              nil
                  if not bit(insn, 15):
                    #i: ((1, 1, 1, 0, 1, 0, 1, 1, 0, 0, 0, None, None, None, None, None, 0, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None), [('S', 20, 20), ('Rn', 19, 16), ('imm3', 14, 12), ('Rd', 11, 8), ('imm2', 7, 6), ('typ', 5, 4), ('Rm', 3, 0)], 'ADD{S}<c>.W <Rd>,<Rn>,<Rm>{,<shift>}', False)
                    #ADD{S}<c>.W <Rd>,<Rn>,<Rm>{,<shift>}
                    #(1, 1, 1, 0, 1, 0, 1, 1, 0, 0, 0, None, None, None, None, None, 0, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None)
                    block:
                      var S : int = b2int(insn[20,20])
                      var Rn : TEnt = Reg(b2int(insn[19,16]))
                      var imm3 : TBinary = insn[14,12]
                      var Rd : TEnt = Reg(b2int(insn[11,8]))
                      var imm2 : TBinary = insn[7,6]
                      var typ : TBinary = insn[5,4]
                      var Rm : TEnt = Reg(b2int(insn[3,0]))
                      if Rd == PC and S.bit: break
                      if Rn == SP: break
                      return z(opADD, S, Rd, Rn, DIShift(Rm, typ, cat(imm3, imm2)))
                      nil
          else:
            if bit(insn, 23):
              if not bit(insn, 22):
                if not bit(insn, 21):
                  if bit(insn, 20):
                    if not bit(insn, 15):
                      if bit(insn, 11):
                        if bit(insn, 10):
                          if bit(insn, 9):
                            if bit(insn, 8):
                              #i: ((1, 1, 1, 0, 1, 0, 1, 0, 1, 0, 0, 1, None, None, None, None, 0, None, None, None, 1, 1, 1, 1, None, None, None, None, None, None, None, None), [('Rn', 19, 16), ('imm3', 14, 12), ('imm2', 7, 6), ('typ', 5, 4), ('Rm', 3, 0)], 'TEQ<c> <Rn>,<Rm>{,<shift>}', True)
                              #TEQ<c> <Rn>,<Rm>{,<shift>}
                              #(1, 1, 1, 0, 1, 0, 1, 0, 1, 0, 0, 1, None, None, None, None, 0, None, None, None, 1, 1, 1, 1, None, None, None, None, None, None, None, None)
                              block:
                                var Rn : TEnt = Reg(b2int(insn[19,16]))
                                var imm3 : TBinary = insn[14,12]
                                var imm2 : TBinary = insn[7,6]
                                var typ : TBinary = insn[5,4]
                                var Rm : TEnt = Reg(b2int(insn[3,0]))
                                
                                nil
                  if not bit(insn, 15):
                    #i: ((1, 1, 1, 0, 1, 0, 1, 0, 1, 0, 0, None, None, None, None, None, 0, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None), [('S', 20, 20), ('Rn', 19, 16), ('imm3', 14, 12), ('Rd', 11, 8), ('imm2', 7, 6), ('typ', 5, 4), ('Rm', 3, 0)], 'EOR{S}<c>.W <Rd>,<Rn>,<Rm>{,<shift>}', False)
                    #EOR{S}<c>.W <Rd>,<Rn>,<Rm>{,<shift>}
                    #(1, 1, 1, 0, 1, 0, 1, 0, 1, 0, 0, None, None, None, None, None, 0, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None)
                    block:
                      var S : int = b2int(insn[20,20])
                      var Rn : TEnt = Reg(b2int(insn[19,16]))
                      var imm3 : TBinary = insn[14,12]
                      var Rd : TEnt = Reg(b2int(insn[11,8]))
                      var imm2 : TBinary = insn[7,6]
                      var typ : TBinary = insn[5,4]
                      var Rm : TEnt = Reg(b2int(insn[3,0]))
                      return z(opEOR, S, Rd, Rn, DIShift(Rm, typ, cat(imm3, imm2)))
                      nil
            else:
              if bit(insn, 22):
                if bit(insn, 21):
                  if bit(insn, 19):
                    if bit(insn, 18):
                      if bit(insn, 17):
                        if bit(insn, 16):
                          if not bit(insn, 15):
                            #i: ((1, 1, 1, 0, 1, 0, 1, 0, 0, 1, 1, None, 1, 1, 1, 1, 0, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None), [('S', 20, 20), ('imm3', 14, 12), ('Rd', 11, 8), ('imm2', 7, 6), ('typ', 5, 4), ('Rm', 3, 0)], 'MVN{S}<c>.W <Rd>,<Rm>{,shift>}', True)
                            #MVN{S}<c>.W <Rd>,<Rm>{,shift>}
                            #(1, 1, 1, 0, 1, 0, 1, 0, 0, 1, 1, None, 1, 1, 1, 1, 0, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None)
                            block:
                              var S : int = b2int(insn[20,20])
                              var imm3 : TBinary = insn[14,12]
                              var Rd : TEnt = Reg(b2int(insn[11,8]))
                              var imm2 : TBinary = insn[7,6]
                              var typ : TBinary = insn[5,4]
                              var Rm : TEnt = Reg(b2int(insn[3,0]))
                              
                              nil
                  if not bit(insn, 15):
                    #i: ((1, 1, 1, 0, 1, 0, 1, 0, 0, 1, 1, None, None, None, None, None, 0, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None), [('S', 20, 20), ('Rn', 19, 16), ('imm3', 14, 12), ('Rd', 11, 8), ('imm2', 7, 6), ('typ', 5, 4), ('Rm', 3, 0)], 'ORN{S}<c> <Rd>,<Rn>,<Rm>{,<shift>}', False)
                    #ORN{S}<c> <Rd>,<Rn>,<Rm>{,<shift>}
                    #(1, 1, 1, 0, 1, 0, 1, 0, 0, 1, 1, None, None, None, None, None, 0, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None)
                    block:
                      var S : int = b2int(insn[20,20])
                      var Rn : TEnt = Reg(b2int(insn[19,16]))
                      var imm3 : TBinary = insn[14,12]
                      var Rd : TEnt = Reg(b2int(insn[11,8]))
                      var imm2 : TBinary = insn[7,6]
                      var typ : TBinary = insn[5,4]
                      var Rm : TEnt = Reg(b2int(insn[3,0]))
                      
                      nil
                else:
                  if bit(insn, 19):
                    if bit(insn, 18):
                      if bit(insn, 17):
                        if bit(insn, 16):
                          if not bit(insn, 15):
                            if not bit(insn, 14):
                              if not bit(insn, 13):
                                if not bit(insn, 12):
                                  if not bit(insn, 7):
                                    if not bit(insn, 6):
                                      if bit(insn, 5):
                                        if bit(insn, 4):
                                          #i: ((1, 1, 1, 0, 1, 0, 1, 0, 0, 1, 0, None, 1, 1, 1, 1, 0, 0, 0, 0, None, None, None, None, 0, 0, 1, 1, None, None, None, None), [('S', 20, 20), ('Rd', 11, 8), ('Rm', 3, 0)], 'RRX{S}<c> <Rd>,<Rm>', True)
                                          #RRX{S}<c> <Rd>,<Rm>
                                          #(1, 1, 1, 0, 1, 0, 1, 0, 0, 1, 0, None, 1, 1, 1, 1, 0, 0, 0, 0, None, None, None, None, 0, 0, 1, 1, None, None, None, None)
                                          block:
                                            var S : int = b2int(insn[20,20])
                                            var Rd : TEnt = Reg(b2int(insn[11,8]))
                                            var Rm : TEnt = Reg(b2int(insn[3,0]))
                                            
                                            nil
                                      else:
                                        if not bit(insn, 4):
                                          #i: ((1, 1, 1, 0, 1, 0, 1, 0, 0, 1, 0, None, 1, 1, 1, 1, 0, 0, 0, 0, None, None, None, None, 0, 0, 0, 0, None, None, None, None), [('S', 20, 20), ('Rd', 11, 8), ('Rm', 3, 0)], 'MOV{S}<c>.W <Rd>,<Rm>', True)
                                          #MOV{S}<c>.W <Rd>,<Rm>
                                          #(1, 1, 1, 0, 1, 0, 1, 0, 0, 1, 0, None, 1, 1, 1, 1, 0, 0, 0, 0, None, None, None, None, 0, 0, 0, 0, None, None, None, None)
                                          block:
                                            var S : int = b2int(insn[20,20])
                                            var Rd : TEnt = Reg(b2int(insn[11,8]))
                                            var Rm : TEnt = Reg(b2int(insn[3,0]))
                                            
                                            nil
                            if bit(insn, 5):
                              if bit(insn, 4):
                                #i: ((1, 1, 1, 0, 1, 0, 1, 0, 0, 1, 0, None, 1, 1, 1, 1, 0, None, None, None, None, None, None, None, None, None, 1, 1, None, None, None, None), [('S', 20, 20), ('imm3', 14, 12), ('Rd', 11, 8), ('imm2', 7, 6), ('Rm', 3, 0)], 'ROR{S}<c> <Rd>,<Rm>,#<imm5>', True)
                                #ROR{S}<c> <Rd>,<Rm>,#<imm5>
                                #(1, 1, 1, 0, 1, 0, 1, 0, 0, 1, 0, None, 1, 1, 1, 1, 0, None, None, None, None, None, None, None, None, None, 1, 1, None, None, None, None)
                                block:
                                  var S : int = b2int(insn[20,20])
                                  var imm3 : TBinary = insn[14,12]
                                  var Rd : TEnt = Reg(b2int(insn[11,8]))
                                  var imm2 : TBinary = insn[7,6]
                                  var Rm : TEnt = Reg(b2int(insn[3,0]))
                                  
                                  nil
                              else:
                                #i: ((1, 1, 1, 0, 1, 0, 1, 0, 0, 1, 0, None, 1, 1, 1, 1, 0, None, None, None, None, None, None, None, None, None, 1, 0, None, None, None, None), [('S', 20, 20), ('imm3', 14, 12), ('Rd', 11, 8), ('imm2', 7, 6), ('Rm', 3, 0)], 'ASR{S}<c>.W <Rd>,<Rm>,#<imm5>', True)
                                #ASR{S}<c>.W <Rd>,<Rm>,#<imm5>
                                #(1, 1, 1, 0, 1, 0, 1, 0, 0, 1, 0, None, 1, 1, 1, 1, 0, None, None, None, None, None, None, None, None, None, 1, 0, None, None, None, None)
                                block:
                                  var S : int = b2int(insn[20,20])
                                  var imm3 : TBinary = insn[14,12]
                                  var Rd : TEnt = Reg(b2int(insn[11,8]))
                                  var imm2 : TBinary = insn[7,6]
                                  var Rm : TEnt = Reg(b2int(insn[3,0]))
                                  return z(opASR, S, Rd, Rm, cat(imm3, imm2))
                                  nil
                            else:
                              if bit(insn, 4):
                                #i: ((1, 1, 1, 0, 1, 0, 1, 0, 0, 1, 0, None, 1, 1, 1, 1, 0, None, None, None, None, None, None, None, None, None, 0, 1, None, None, None, None), [('S', 20, 20), ('imm3', 14, 12), ('Rd', 11, 8), ('imm2', 7, 6), ('Rm', 3, 0)], 'LSR{S}<c>.W <Rd>,<Rm>,#<imm5>', True)
                                #LSR{S}<c>.W <Rd>,<Rm>,#<imm5>
                                #(1, 1, 1, 0, 1, 0, 1, 0, 0, 1, 0, None, 1, 1, 1, 1, 0, None, None, None, None, None, None, None, None, None, 0, 1, None, None, None, None)
                                block:
                                  var S : int = b2int(insn[20,20])
                                  var imm3 : TBinary = insn[14,12]
                                  var Rd : TEnt = Reg(b2int(insn[11,8]))
                                  var imm2 : TBinary = insn[7,6]
                                  var Rm : TEnt = Reg(b2int(insn[3,0]))
                                  
                                  nil
                              else:
                                #i: ((1, 1, 1, 0, 1, 0, 1, 0, 0, 1, 0, None, 1, 1, 1, 1, 0, None, None, None, None, None, None, None, None, None, 0, 0, None, None, None, None), [('S', 20, 20), ('imm3', 14, 12), ('Rd', 11, 8), ('imm2', 7, 6), ('Rm', 3, 0)], 'LSL{S}<c>.W <Rd>,<Rm>,#<imm5>', True)
                                #LSL{S}<c>.W <Rd>,<Rm>,#<imm5>
                                #(1, 1, 1, 0, 1, 0, 1, 0, 0, 1, 0, None, 1, 1, 1, 1, 0, None, None, None, None, None, None, None, None, None, 0, 0, None, None, None, None)
                                block:
                                  var S : int = b2int(insn[20,20])
                                  var imm3 : TBinary = insn[14,12]
                                  var Rd : TEnt = Reg(b2int(insn[11,8]))
                                  var imm2 : TBinary = insn[7,6]
                                  var Rm : TEnt = Reg(b2int(insn[3,0]))
                                  
                                  nil
                  if not bit(insn, 15):
                    #i: ((1, 1, 1, 0, 1, 0, 1, 0, 0, 1, 0, None, None, None, None, None, 0, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None), [('S', 20, 20), ('Rn', 19, 16), ('imm3', 14, 12), ('Rd', 11, 8), ('imm2', 7, 6), ('typ', 5, 4), ('Rm', 3, 0)], 'ORR{S}<c>.W <Rd>,<Rn>,<Rm>{,<shift>}', False)
                    #ORR{S}<c>.W <Rd>,<Rn>,<Rm>{,<shift>}
                    #(1, 1, 1, 0, 1, 0, 1, 0, 0, 1, 0, None, None, None, None, None, 0, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None)
                    block:
                      var S : int = b2int(insn[20,20])
                      var Rn : TEnt = Reg(b2int(insn[19,16]))
                      var imm3 : TBinary = insn[14,12]
                      var Rd : TEnt = Reg(b2int(insn[11,8]))
                      var imm2 : TBinary = insn[7,6]
                      var typ : TBinary = insn[5,4]
                      var Rm : TEnt = Reg(b2int(insn[3,0]))
                      
                      nil
              else:
                if bit(insn, 21):
                  if not bit(insn, 15):
                    #i: ((1, 1, 1, 0, 1, 0, 1, 0, 0, 0, 1, None, None, None, None, None, 0, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None), [('S', 20, 20), ('Rn', 19, 16), ('imm3', 14, 12), ('Rd', 11, 8), ('imm2', 7, 6), ('typ', 5, 4), ('Rm', 3, 0)], 'BIC{S}<c>.W <Rd>,<Rn>,<Rm>{,<shift>}', False)
                    #BIC{S}<c>.W <Rd>,<Rn>,<Rm>{,<shift>}
                    #(1, 1, 1, 0, 1, 0, 1, 0, 0, 0, 1, None, None, None, None, None, 0, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None)
                    block:
                      var S : int = b2int(insn[20,20])
                      var Rn : TEnt = Reg(b2int(insn[19,16]))
                      var imm3 : TBinary = insn[14,12]
                      var Rd : TEnt = Reg(b2int(insn[11,8]))
                      var imm2 : TBinary = insn[7,6]
                      var typ : TBinary = insn[5,4]
                      var Rm : TEnt = Reg(b2int(insn[3,0]))
                      return z(opBIC, S, Rd, Rn, DIShift(Rm, typ, cat(imm3, imm2)))
                      nil
                else:
                  if bit(insn, 20):
                    if not bit(insn, 15):
                      if bit(insn, 11):
                        if bit(insn, 10):
                          if bit(insn, 9):
                            if bit(insn, 8):
                              #i: ((1, 1, 1, 0, 1, 0, 1, 0, 0, 0, 0, 1, None, None, None, None, 0, None, None, None, 1, 1, 1, 1, None, None, None, None, None, None, None, None), [('Rn', 19, 16), ('imm3', 14, 12), ('imm2', 7, 6), ('typ', 5, 4), ('Rm', 3, 0)], 'TST<c>.W <Rn>,<Rm>{,<shift>}', True)
                              #TST<c>.W <Rn>,<Rm>{,<shift>}
                              #(1, 1, 1, 0, 1, 0, 1, 0, 0, 0, 0, 1, None, None, None, None, 0, None, None, None, 1, 1, 1, 1, None, None, None, None, None, None, None, None)
                              block:
                                var Rn : TEnt = Reg(b2int(insn[19,16]))
                                var imm3 : TBinary = insn[14,12]
                                var imm2 : TBinary = insn[7,6]
                                var typ : TBinary = insn[5,4]
                                var Rm : TEnt = Reg(b2int(insn[3,0]))
                                
                                nil
                  if not bit(insn, 15):
                    #i: ((1, 1, 1, 0, 1, 0, 1, 0, 0, 0, 0, None, None, None, None, None, 0, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None), [('S', 20, 20), ('Rn', 19, 16), ('imm3', 14, 12), ('Rd', 11, 8), ('imm2', 7, 6), ('typ', 5, 4), ('Rm', 3, 0)], 'AND{S}<c>.W <Rd>,<Rn>,<Rm>{,<shift>}', False)
                    #AND{S}<c>.W <Rd>,<Rn>,<Rm>{,<shift>}
                    #(1, 1, 1, 0, 1, 0, 1, 0, 0, 0, 0, None, None, None, None, None, 0, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None)
                    block:
                      var S : int = b2int(insn[20,20])
                      var Rn : TEnt = Reg(b2int(insn[19,16]))
                      var imm3 : TBinary = insn[14,12]
                      var Rd : TEnt = Reg(b2int(insn[11,8]))
                      var imm2 : TBinary = insn[7,6]
                      var typ : TBinary = insn[5,4]
                      var Rm : TEnt = Reg(b2int(insn[3,0]))
                      return z(opASR, t, Rd, Rn, DIShift(Rm, b"10", cat(imm3, imm2)))
                      nil
        else:
          if bit(insn, 24):
            if not bit(insn, 23):
              if not bit(insn, 22):
                if bit(insn, 21):
                  if not bit(insn, 20):
                    if bit(insn, 19):
                      if bit(insn, 18):
                        if not bit(insn, 17):
                          if bit(insn, 16):
                            if not bit(insn, 15):
                              if not bit(insn, 13):
                                #i: ((1, 1, 1, 0, 1, 0, 0, 1, 0, 0, 1, 0, 1, 1, 0, 1, 0, None, 0, None, None, None, None, None, None, None, None, None, None, None, None, None), [('M', 14, 14), ('register_list', 12, 0)], 'PUSH<c>.W <registers>', True)
                                #PUSH<c>.W <registers>
                                #(1, 1, 1, 0, 1, 0, 0, 1, 0, 0, 1, 0, 1, 1, 0, 1, 0, None, 0, None, None, None, None, None, None, None, None, None, None, None, None, None)
                                block:
                                  var M : TBinary = insn[14,14]
                                  var register_list : TBinary = insn[12,0]
                                  
                                  nil
                if bit(insn, 20):
                  if not bit(insn, 13):
                    #i: ((1, 1, 1, 0, 1, 0, 0, 1, 0, 0, None, 1, None, None, None, None, None, None, 0, None, None, None, None, None, None, None, None, None, None, None, None, None), [('W', 21, 21), ('Rn', 19, 16), ('P', 15, 15), ('M', 14, 14), ('register_list', 12, 0)], 'LDMDB<c> <Rn>{!},<registers>', False)
                    #LDMDB<c> <Rn>{!},<registers>
                    #(1, 1, 1, 0, 1, 0, 0, 1, 0, 0, None, 1, None, None, None, None, None, None, 0, None, None, None, None, None, None, None, None, None, None, None, None, None)
                    block:
                      var W : TBinary = insn[21,21]
                      var Rn : TEnt = Reg(b2int(insn[19,16]))
                      var P : TBinary = insn[15,15]
                      var M : TBinary = insn[14,14]
                      var register_list : TBinary = insn[12,0]
                      return z(opLDMDB, 0, Rn, RegList(cat(P, M, b"0", register_list)))
                      nil
                else:
                  if not bit(insn, 15):
                    if not bit(insn, 13):
                      #i: ((1, 1, 1, 0, 1, 0, 0, 1, 0, 0, None, 0, None, None, None, None, 0, None, 0, None, None, None, None, None, None, None, None, None, None, None, None, None), [('W', 21, 21), ('Rn', 19, 16), ('M', 14, 14), ('register_list', 12, 0)], 'STMDB<c> <Rn>{!},<registers>', False)
                      #STMDB<c> <Rn>{!},<registers>
                      #(1, 1, 1, 0, 1, 0, 0, 1, 0, 0, None, 0, None, None, None, None, 0, None, 0, None, None, None, None, None, None, None, None, None, None, None, None, None)
                      block:
                        var W : TBinary = insn[21,21]
                        var Rn : TEnt = Reg(b2int(insn[19,16]))
                        var M : TBinary = insn[14,14]
                        var register_list : TBinary = insn[12,0]
                        
                        nil
          else:
            if bit(insn, 23):
              if bit(insn, 22):
                if not bit(insn, 21):
                  if bit(insn, 20):
                    if bit(insn, 15):
                      if bit(insn, 14):
                        if bit(insn, 13):
                          if bit(insn, 12):
                            if not bit(insn, 11):
                              if not bit(insn, 10):
                                if not bit(insn, 9):
                                  if not bit(insn, 8):
                                    if not bit(insn, 7):
                                      if not bit(insn, 6):
                                        if not bit(insn, 5):
                                          #i: ((1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 0, 1, None, None, None, None, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, None, None, None, None, None), [('Rn', 19, 16), ('H', 4, 4), ('Rm', 3, 0)], 'TBH<c> [<Rn>,<Rm>,LSL #1]', True)
                                          #TBH<c> [<Rn>,<Rm>,LSL #1]
                                          #(1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 0, 1, None, None, None, None, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, None, None, None, None, None)
                                          block:
                                            var Rn : TEnt = Reg(b2int(insn[19,16]))
                                            var H : TBinary = insn[4,4]
                                            var Rm : TEnt = Reg(b2int(insn[3,0]))
                                            
                                            nil
                    if bit(insn, 11):
                      if bit(insn, 10):
                        if bit(insn, 9):
                          if bit(insn, 8):
                            if not bit(insn, 7):
                              if bit(insn, 6):
                                if not bit(insn, 5):
                                  if bit(insn, 4):
                                    if bit(insn, 3):
                                      if bit(insn, 2):
                                        if bit(insn, 1):
                                          if bit(insn, 0):
                                            #i: ((1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 0, 1, None, None, None, None, None, None, None, None, 1, 1, 1, 1, 0, 1, 0, 1, 1, 1, 1, 1), [('Rn', 19, 16), ('Rt', 15, 12)], 'LDREXH<c> <Rt>, [<Rn>]', True)
                                            #LDREXH<c> <Rt>, [<Rn>]
                                            #(1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 0, 1, None, None, None, None, None, None, None, None, 1, 1, 1, 1, 0, 1, 0, 1, 1, 1, 1, 1)
                                            block:
                                              var Rn : TEnt = Reg(b2int(insn[19,16]))
                                              var Rt : TEnt = Reg(b2int(insn[15,12]))
                                              
                                              nil
                                  else:
                                    if bit(insn, 3):
                                      if bit(insn, 2):
                                        if bit(insn, 1):
                                          if bit(insn, 0):
                                            #i: ((1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 0, 1, None, None, None, None, None, None, None, None, 1, 1, 1, 1, 0, 1, 0, 0, 1, 1, 1, 1), [('Rn', 19, 16), ('Rt', 15, 12)], 'LDREXB<c> <Rt>, [<Rn>]', True)
                                            #LDREXB<c> <Rt>, [<Rn>]
                                            #(1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 0, 1, None, None, None, None, None, None, None, None, 1, 1, 1, 1, 0, 1, 0, 0, 1, 1, 1, 1)
                                            block:
                                              var Rn : TEnt = Reg(b2int(insn[19,16]))
                                              var Rt : TEnt = Reg(b2int(insn[15,12]))
                                              
                                              nil
                  else:
                    if bit(insn, 11):
                      if bit(insn, 10):
                        if bit(insn, 9):
                          if bit(insn, 8):
                            if not bit(insn, 7):
                              if bit(insn, 6):
                                if not bit(insn, 5):
                                  if bit(insn, 4):
                                    #i: ((1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 0, 0, None, None, None, None, None, None, None, None, 1, 1, 1, 1, 0, 1, 0, 1, None, None, None, None), [('Rn', 19, 16), ('Rt', 15, 12), ('Rd', 3, 0)], 'STREXH<c> <Rd>,<Rt>,[<Rn>]', True)
                                    #STREXH<c> <Rd>,<Rt>,[<Rn>]
                                    #(1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 0, 0, None, None, None, None, None, None, None, None, 1, 1, 1, 1, 0, 1, 0, 1, None, None, None, None)
                                    block:
                                      var Rn : TEnt = Reg(b2int(insn[19,16]))
                                      var Rt : TEnt = Reg(b2int(insn[15,12]))
                                      var Rd : TEnt = Reg(b2int(insn[3,0]))
                                      
                                      nil
                                  else:
                                    #i: ((1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 0, 0, None, None, None, None, None, None, None, None, 1, 1, 1, 1, 0, 1, 0, 0, None, None, None, None), [('Rn', 19, 16), ('Rt', 15, 12), ('Rd', 3, 0)], 'STREXB<c> <Rd>,<Rt>,[<Rn>]', True)
                                    #STREXB<c> <Rd>,<Rt>,[<Rn>]
                                    #(1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 0, 0, None, None, None, None, None, None, None, None, 1, 1, 1, 1, 0, 1, 0, 0, None, None, None, None)
                                    block:
                                      var Rn : TEnt = Reg(b2int(insn[19,16]))
                                      var Rt : TEnt = Reg(b2int(insn[15,12]))
                                      var Rd : TEnt = Reg(b2int(insn[3,0]))
                                      
                                      nil
              else:
                if bit(insn, 21):
                  if bit(insn, 20):
                    if bit(insn, 19):
                      if bit(insn, 18):
                        if not bit(insn, 17):
                          if bit(insn, 16):
                            if not bit(insn, 13):
                              #i: ((1, 1, 1, 0, 1, 0, 0, 0, 1, 0, 1, 1, 1, 1, 0, 1, None, None, 0, None, None, None, None, None, None, None, None, None, None, None, None, None), [('P', 15, 15), ('M', 14, 14), ('register_list', 12, 0)], 'POP<c>.W <registers>', True)
                              #POP<c>.W <registers>
                              #(1, 1, 1, 0, 1, 0, 0, 0, 1, 0, 1, 1, 1, 1, 0, 1, None, None, 0, None, None, None, None, None, None, None, None, None, None, None, None, None)
                              block:
                                var P : TBinary = insn[15,15]
                                var M : TBinary = insn[14,14]
                                var register_list : TBinary = insn[12,0]
                                
                                nil
                if bit(insn, 20):
                  if not bit(insn, 13):
                    #i: ((1, 1, 1, 0, 1, 0, 0, 0, 1, 0, None, 1, None, None, None, None, None, None, 0, None, None, None, None, None, None, None, None, None, None, None, None, None), [('W', 21, 21), ('Rn', 19, 16), ('P', 15, 15), ('M', 14, 14), ('register_list', 12, 0)], 'LDM<c>.W <Rn>{!},<registers>', False)
                    #LDM<c>.W <Rn>{!},<registers>
                    #(1, 1, 1, 0, 1, 0, 0, 0, 1, 0, None, 1, None, None, None, None, None, None, 0, None, None, None, None, None, None, None, None, None, None, None, None, None)
                    block:
                      var W : TBinary = insn[21,21]
                      var Rn : TEnt = Reg(b2int(insn[19,16]))
                      var P : TBinary = insn[15,15]
                      var M : TBinary = insn[14,14]
                      var register_list : TBinary = insn[12,0]
                      return z(if W.bit: opLDMIA else: opLDM, 0, Rn, RegList(cat(P, M, b"0", register_list)))
                      nil
                else:
                  if not bit(insn, 15):
                    if not bit(insn, 13):
                      #i: ((1, 1, 1, 0, 1, 0, 0, 0, 1, 0, None, 0, None, None, None, None, 0, None, 0, None, None, None, None, None, None, None, None, None, None, None, None, None), [('W', 21, 21), ('Rn', 19, 16), ('M', 14, 14), ('register_list', 12, 0)], 'STM<c>.W <Rn>{!},<registers>', False)
                      #STM<c>.W <Rn>{!},<registers>
                      #(1, 1, 1, 0, 1, 0, 0, 0, 1, 0, None, 0, None, None, None, None, 0, None, 0, None, None, None, None, None, None, None, None, None, None, None, None, None)
                      block:
                        var W : TBinary = insn[21,21]
                        var Rn : TEnt = Reg(b2int(insn[19,16]))
                        var M : TBinary = insn[14,14]
                        var register_list : TBinary = insn[12,0]
                        
                        nil
            else:
              if bit(insn, 22):
                if not bit(insn, 21):
                  if bit(insn, 20):
                    if bit(insn, 11):
                      if bit(insn, 10):
                        if bit(insn, 9):
                          if bit(insn, 8):
                            #i: ((1, 1, 1, 0, 1, 0, 0, 0, 0, 1, 0, 1, None, None, None, None, None, None, None, None, 1, 1, 1, 1, None, None, None, None, None, None, None, None), [('Rn', 19, 16), ('Rt', 15, 12), ('imm8', 7, 0)], 'LDREX<c> <Rt>,[<Rn>{,#<imm8>}]', True)
                            #LDREX<c> <Rt>,[<Rn>{,#<imm8>}]
                            #(1, 1, 1, 0, 1, 0, 0, 0, 0, 1, 0, 1, None, None, None, None, None, None, None, None, 1, 1, 1, 1, None, None, None, None, None, None, None, None)
                            block:
                              var Rn : TEnt = Reg(b2int(insn[19,16]))
                              var Rt : TEnt = Reg(b2int(insn[15,12]))
                              var imm8 : TBinary = insn[7,0]
                              
                              nil
                  else:
                    #i: ((1, 1, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None), [('Rn', 19, 16), ('Rt', 15, 12), ('Rd', 11, 8), ('imm8', 7, 0)], 'STREX<c> <Rd>,<Rt>,[<Rn>{,#<imm8>}]', True)
                    #STREX<c> <Rd>,<Rt>,[<Rn>{,#<imm8>}]
                    #(1, 1, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None)
                    block:
                      var Rn : TEnt = Reg(b2int(insn[19,16]))
                      var Rt : TEnt = Reg(b2int(insn[15,12]))
                      var Rd : TEnt = Reg(b2int(insn[11,8]))
                      var imm8 : TBinary = insn[7,0]
                      
                      nil
          if bit(insn, 22):
            if not bit(insn, 21):
              if bit(insn, 20):
                if bit(insn, 19):
                  if bit(insn, 18):
                    if bit(insn, 17):
                      if bit(insn, 16):
                        #i: ((1, 1, 1, 0, 1, 0, 0, None, None, 1, 0, 1, 1, 1, 1, 1, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None), [('P', 24, 24), ('U', 23, 23), ('Rt', 15, 12), ('Rt2', 11, 8), ('imm8', 7, 0)], 'LDRD<c> <Rt>,<Rt2>,[PC,#-0] Special case', True)
                        #LDRD<c> <Rt>,<Rt2>,[PC,#-0] Special case
                        #(1, 1, 1, 0, 1, 0, 0, None, None, 1, 0, 1, 1, 1, 1, 1, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None)
                        block:
                          var P : TBinary = insn[24,24]
                          var U : TBinary = insn[23,23]
                          var Rt : TEnt = Reg(b2int(insn[15,12]))
                          var Rt2 : TBinary = insn[11,8]
                          var imm8 : TBinary = insn[7,0]
                          
                          nil
            if bit(insn, 20):
              #i: ((1, 1, 1, 0, 1, 0, 0, None, None, 1, None, 1, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None), [('P', 24, 24), ('U', 23, 23), ('W', 21, 21), ('Rn', 19, 16), ('Rt', 15, 12), ('Rt2', 11, 8), ('imm8', 7, 0)], 'LDRD<c> <Rt>,<Rt2>,[<Rn>,#+/-<imm8>]!', False)
              #LDRD<c> <Rt>,<Rt2>,[<Rn>,#+/-<imm8>]!
              #(1, 1, 1, 0, 1, 0, 0, None, None, 1, None, 1, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None)
              block:
                var P : TBinary = insn[24,24]
                var U : TBinary = insn[23,23]
                var W : TBinary = insn[21,21]
                var Rn : TEnt = Reg(b2int(insn[19,16]))
                var Rt : TEnt = Reg(b2int(insn[15,12]))
                var Rt2 : TBinary = insn[11,8]
                var imm8 : TBinary = insn[7,0]
                
                nil
            else:
              #i: ((1, 1, 1, 0, 1, 0, 0, None, None, 1, None, 0, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None), [('P', 24, 24), ('U', 23, 23), ('W', 21, 21), ('Rn', 19, 16), ('Rt', 15, 12), ('Rt2', 11, 8), ('imm8', 7, 0)], 'STRD<c> <Rt>,<Rt2>,[<Rn>,#+/-<imm8>]!', False)
              #STRD<c> <Rt>,<Rt2>,[<Rn>,#+/-<imm8>]!
              #(1, 1, 1, 0, 1, 0, 0, None, None, 1, None, 0, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None)
              block:
                var P : TBinary = insn[24,24]
                var U : TBinary = insn[23,23]
                var W : TBinary = insn[21,21]
                var Rn : TEnt = Reg(b2int(insn[19,16]))
                var Rt : TEnt = Reg(b2int(insn[15,12]))
                var Rt2 : TBinary = insn[11,8]
                var imm8 : TBinary = insn[7,0]
                
                nil
  return nil
