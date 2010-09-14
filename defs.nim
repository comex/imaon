# 1 is S.  Some instructions, like CMP, have implicit S.
# t is 1 if not in an IT block, else 0
# Condition codes are other flags.

#: ADC{S}<c> <Rd>,<Rn>,#<const>
#  avail: i:1 S:1 Rn:4 imm3:3 Rd:4 imm8:8
return ctx.opADC(S, >Rd, <Rn, ctx.TEImm(cat(i, imm3, imm8)))
#: ADC<c> <Rdn>,<Rm>
#  avail: Rm:3 Rdn:3
return ctx.opADC(t, >Rdn, <Rdn, <Rm)
#: ADC{S}<c>.W <Rd>,<Rn>,<Rm>{,<shift>}
#  avail: S:1 Rn:4 imm3:3 Rd:4 imm2:2 typ:2 Rm:4
return ctx.opADC(S, >Rd, ctx.DIShift(<Rm, typ, cat(imm3, imm2)))
#: ADD<c> <Rd>,<Rn>,#<imm3>
#  avail: imm3:3 Rn:3 Rd:3
return ctx.opADD(t, >Rd, <Rn, <imm3)
#: ADD<c> <Rdn>,#<imm8>
#  avail: Rdn:3 imm8:8
return ctx.opADD(t, >Rdn, <Rdn, <imm8)
#: ADD{S}<c>.W <Rd>,<Rn>,#<const>
#  avail: i:1 S:1 Rn:4 imm3:3 Rd:4 imm8:8
return ctx.opADD(S, >Rd, <Rn, <ctx.TEImm(cat(i, imm3, imm8)))
#: ADDW<c> <Rd>,<Rn>,#<imm12>
#  avail: i:1 Rn:4 imm3:3 Rd:4 imm8:8
return ctx.opADD({}, >Rd, <Rn, <cat(i, imm3, imm8))
#: ADD<c> <Rd>,<Rn>,<Rm>
#  avail: Rm:3 Rn:3 Rd:3
return ctx.opADD(t, >Rd, <Rn, <Rm)
#: ADD<c> <Rdn>,<Rm>
#  avail: DN:1 Rm:4 Rdn:3
if DN.bit: Rdn = rshift(Rdn)
if Rdn == SP or Rm == SP: break
return ctx.opADD({}, >Rdn, <Rdn, <Rm)
#: ADD{S}<c>.W <Rd>,<Rn>,<Rm>{,<shift>}
#  avail: S:1 Rn:4 imm3:3 Rd:4 imm2:2 typ:2 Rm:4
if Rd == PC and S == {ifS}: break
if Rn == SP: break
return ctx.opADD(S, >Rd, <Rn, <ctx.DIShift(<Rm, typ, cat(imm3, imm2)))
#: ADD<c> <Rd>,SP,#<imm8>
#  avail: Rd:3 imm8:8
return ctx.opADD({}, >Rd, <SP, <cat(imm8, b"00"))
#: ADD<c> SP,SP,#<imm7>
#  avail: imm7:7
return ctx.opADD({}, >SP, <SP, <cat(imm7, b"00"))
#: ADD{S}<c>.W <Rd>,SP,#<const>
#  avail: i:1 S:1 imm3:3 Rd:4 imm8:8
if Rd == PC and S == {ifS}: break
return ctx.opADD(S, >Rd, <SP, <ctx.TEImm(cat(i, imm3, imm8)))
#: ADDW<c> <Rd>,SP,#<imm12>
#  avail: i:1 imm3:3 Rd:4 imm8:8
return ctx.opADD({}, >Rd, <SP, <cat(i, imm3, imm8))
#: ADD<c> <Rdm>, SP, <Rdm>
#  avail: DM:1 Rdm:3
if DM.bit: Rdm = rshift(Rdm)
return ctx.opADD({}, >Rdm, <SP, <Rdm)
#: ADD<c> SP,<Rm>
#  avail: Rm:4
return ctx.opADD({}, >SP, <SP, <Rm)
#: ADD{S}<c>.W <Rd>,SP,<Rm>{,<shift>}
#  avail: S:1 imm3:3 Rd:4 imm2:2 typ:2 Rm:4
return ctx.opADD(S, >Rd, <SP, <ctx.DIShift(<Rm, typ, cat(imm3, imm2)))
#: ADR<c> <Rd>,<label>
#  avail: Rd:3 imm8:8
return ctx.opADR({}, >Rd, <PC, <(cat(imm8, b"00").num))
#: SUB <Rd>,PC,#0 Special case for zero offset
#  avail: i:1 imm3:3 Rd:4 imm8:8
return ctx.opADR({}, >Rd, <PC, <(-cat(i, imm3, imm8).num))
#: ADR<c>.W <Rd>,<label> <label> after current instruction
#  avail: i:1 imm3:3 Rd:4 imm8:8
return ctx.opADR({}, <Rd, <PC, <(cat(i, imm3, imm8).num))
#: AND{S}<c> <Rd>,<Rn>,#<const>
#  avail: i:1 S:1 Rn:4 imm3:3 Rd:4 imm8:8
if Rd == PC and S == {ifS}: break
var r = ctx.TEImm_C(cat(i, imm3, imm8))
return ctx.opAND(S + r.setCarry, >Rd, <Rn, <r.ent)
#: AND<c> <Rdn>,<Rm>
#  avail: Rm:3 Rdn:3
return ctx.opAND(t, >Rdn, <Rdn, <Rm)
#: AND{S}<c>.W <Rd>,<Rn>,<Rm>{,<shift>}
#  avail: S:1 Rn:4 imm3:3 Rd:4 imm2:2 typ:2 Rm:4
#return ctx.opASR(t, Rd, Rn, ctx.DIShift(42))#>Rm, b"10", cat(imm3, imm2)))
#: ASR<c> <Rd>,<Rm>,#<imm5>
#  avail: imm5:5 Rm:3 Rd:3
#return ctx.opASR(t, Rd, Rd, ctx.DIShift(>Rm, b"10", imm5))
#: ASR{S}<c>.W <Rd>,<Rm>,#<imm5>
#  avail: S:1 imm3:3 Rd:4 imm2:2 Rm:4
#return ctx.opASR(S, Rd, Rm, cat(imm3, imm2))
#: ASR<c> <Rdn>,<Rm>
#  avail: Rm:3 Rdn:3
#return ctx.opASR({}, Rdn, Rdn, Rm)
#: ASR{S}<c>.W <Rd>,<Rn>,<Rm>
#  avail: S:1 Rn:4 Rd:4 Rm:4
#return ctx.opASR(S, Rd, Rn, Rm)
#: B<c> <label>
#  avail: cond:4 imm8:8
return ctx.opB(fromCond(cond), <(sxt(cat(imm8, b"0"))))
#: B<c> <label>
#  avail: imm11:11
return ctx.opB({}, <(sxt(cat(imm11, b"0"))))
#: B<c>.W <label>
#  avail: S:1 cond:4 imm6:6 J1:1 J2:1 imm11:11
var SA = cast[int](S)
return ctx.opB(S + fromCond(cond), <(sxt(cat(Binary(SA, 1), J1, J2, imm6, imm11, b"0"))))
#: B<c>.W <label>
#  avail: S:1 imm10:10 J1:1 J2:1 imm11:11
var SA = cast[int](S)
return ctx.opB(S, <(sxt(cat(Binary(SA, 1), Binary(J1.num xor SA, 1), Binary(J2.num xor SA, 1), imm10, imm11, b"0"))))
#: BFC<c> <Rd>,#<lsb>,#<width>
#  avail: imm3:3 Rd:4 imm2:2 msb:5
var lsb = cat(imm3, imm2)
return ctx.opBFC({}, >Rd, <lsb, <(msb.num - lsb.num + 1))
#: BFI<c> <Rd>,<Rn>,#<lsb>,#<width>
#  avail: Rn:4 imm3:3 Rd:4 imm2:2 msb:5
var lsb = cat(imm3, imm2)
return ctx.opBFI({}, >Rd, <Rn, <lsb, <(msb.num - lsb.num + 1))
#: BIC{S}<c> <Rd>,<Rn>,#<const>
#  avail: i:1 S:1 Rn:4 imm3:3 Rd:4 imm8:8
var r = ctx.TEImm_C(cat(i, imm3, imm8))
return ctx.opBIC(S + r.setCarry, >Rd, <Rn, r.ent)
#: BIC<c> <Rdn>,<Rm>
#  avail: Rm:3 Rdn:3
return ctx.opBIC({}, >Rdn, <Rdn, <Rm)
#: BIC{S}<c>.W <Rd>,<Rn>,<Rm>{,<shift>}
#  avail: S:1 Rn:4 imm3:3 Rd:4 imm2:2 typ:2 Rm:4
return ctx.opBIC(S, >Rd, <Rn, ctx.DIShift(<Rm, typ, cat(imm3, imm2)))
#: BKPT #<imm8>
#  avail: imm8:8
return ctx.opBKPT({}, <imm8)
#: BL<c> <label>
#  avail: S:1 imm10:10 J1:1 J2:1 imm11:11
return ctx.opBL({}, <(sxt(cat(Binary(cast[int](S), 1), J1, J2, imm10, imm11, b"0"))))
#: BLX<c> <Rm>
#  avail: Rm:4
return ctx.opBLX({}, <Rm)
#: BX<c> <Rm>
#  avail: Rm:4
return ctx.opBX({}, <Rm)
#: CB{N}Z <Rn>,<label>
#  avail: op:1 i:1 imm5:5 Rn:3
var arg = <cat(i, imm5, b"0")
if op.bit:
    return ctx.opCBNZ({}, <Rn, arg)
else:
    return ctx.opCBZ({}, <Rn, arg)
#: CDP<c> <coproc>,<opc1>,<CRd>,<CRn>,<CRm>,<opc2>
#  avail: opc1:4 CRn:4 CRd:4 coproc:4 opc2:3 CRm:4
return ctx.opCDP({}, <coproc, <opc1, <CRd, <CRn, <CRm, <opc2)
#: CDP2<c> <coproc>,<opc1>,<CRd>,<CRn>,<CRm>,<opc2>
#  avail: opc1:4 CRn:4 CRd:4 coproc:4 opc2:3 CRm:4
return ctx.opCDP2({}, <coproc, <opc1, <CRd, <CRn, <CRm, <opc2)
#: CLREX<c>
#  avail: 
return ctx.opCLREX({})
#: CLZ<c> <Rd>,<Rm>
#  avail: Rm:4 Rd:4 Rm_P:4
return ctx.opCLZ({}, >Rd, <Rm)
#: CMN<c> <Rn>,#<const>
#  avail: i:1 Rn:4 imm3:3 imm8:8
return ctx.opCMN({ifS}, >Rn, ctx.TEImm(cat(i, imm3, imm8)))
#: CMN<c> <Rn>,<Rm>
#  avail: Rm:3 Rn:3
return ctx.opCMN({ifS}, >Rn, <Rm)
#: CMN<c>.W <Rn>,<Rm>{,<shift>}
#  avail: Rn:4 imm3:3 imm2:2 typ:2 Rm:4
return ctx.opCMN({ifS}, >Rn, ctx.DIShift(<Rm, typ, cat(imm3, imm2)))
#: CMP<c> <Rn>,#<imm8>
#  avail: Rn:3 imm8:8
return ctx.opCMP({ifS}, <Rn, <imm8)
#: CMP<c>.W <Rn>,#<const>
#  avail: i:1 Rn:4 imm3:3 imm8:8
return ctx.opCMP({ifS}, <Rn, ctx.TEImm(cat(i, imm3, imm8)))
#: CMP<c> <Rn>,<Rm>
#  avail: Rm:3 Rn:3
return ctx.opCMP({ifS}, <Rn, <Rm)
#: CMP<c> <Rn>,<Rm>
#  avail: N:1 Rm:4 Rn:3
if N.bit: Rn = rshift(Rn)
return ctx.opCMP({}, <Rn, <Rm)
#: CMP<c>.W <Rn>, <Rm> {,<shift>}
#  avail: Rn:4 imm3:3 imm2:2 typ:2 Rm:4
return ctx.opCMP({}, <Rn, ctx.DIShift(<Rm, typ, cat(imm3, imm2)))
#: CPS<effect> <iflags>
#  avail: im:1 I:1 F:1
nil # see B4-2
#: DBG<c> #<option>
#  avail: option:4
return ctx.opDBG({}, <option)
#: DMB<c> #<option>
#  avail: option:4
return ctx.opDMB({}, <option)
#: DSB<c> #<option>
#  avail: option:4
return ctx.opDSB({}, <option)
#: EOR{S}<c> <Rd>,<Rn>,#<const>
#  avail: i:1 S:1 Rn:4 imm3:3 Rd:4 imm8:8
return ctx.opEOR(S, >Rd, <Rn, ctx.TEImm(cat(i, imm3, imm8)))
#: EOR<c> <Rdn>,<Rm>
#  avail: Rm:3 Rdn:3
return ctx.opEOR(t, >Rdn, <Rdn, <Rm)
#: EOR{S}<c>.W <Rd>,<Rn>,<Rm>{,<shift>}
#  avail: S:1 Rn:4 imm3:3 Rd:4 imm2:2 typ:2 Rm:4
return ctx.opEOR(S, >Rd, <Rn, ctx.DIShift(<Rm, typ, cat(imm3, imm2)))
#: ISB<c> #<option>
#  avail: option:4
return ctx.opISB({}, <option)
#: IT{x{y{z}}} <firstcond>
#  avail: firstcond:4 mask:4
# Yuk.  This will need special care.
if mask == b"0000": break
return ctx.opIT(fromCond(firstcond), ctx.ITarg(parseIT(TCond(firstcond.num), mask)))
#: LDC{L}<c> <coproc>,<CRd>,[<Rn>],<option>
#  avail: P:1 U:1 D:1 W:1 Rn:4 CRd:4 coproc:4 imm8:8
if P == b"0" and W == b"0": break
return ctx.opLDC({}, <coproc, ctx.Deref(>Rn, <cat(imm8, b"00"), 4, P.bit, W.bit, U.bit))
#: LDC2{L}<c> <coproc>,<CRd>,[<Rn>],<option>
#  avail: P:1 U:1 D:1 W:1 Rn:4 CRd:4 coproc:4 imm8:8
if P == b"0" and W == b"0": break
return ctx.opLDC2({}, <coproc, ctx.Deref(>Rn, <cat(imm8, b"00"), 4, P.bit, W.bit, U.bit))
#: LDC{L}<c> <coproc>,<CRd>,[PC,#-0] Special case LDC{L}<c> <coproc>,<CRd>,[PC],<option>
#  avail: P:1 U:1 D:1 W:1 CRd:4 coproc:4 imm8:8

#: LDC2{L}<c> <coproc>,<CRd>,[PC,#-0] Special case LDC{L}<c> <coproc>,<CRd>,[PC],<option>
#  avail: P:1 U:1 D:1 W:1 CRd:4 coproc:4 imm8:8

#: LDM<c> <Rn>,<registers> <Rn> included in <registers>
#  avail: Rn:3 register_list:8
var rl = cat(b"00000000", register_list)
if rl[int(Rn)].bit:
    #rl = rl.bclear(int(rn))
    return ctx.opLDM({}, <Rn, ctx.RegList(rl))
else:
    return ctx.opLDMIA({}, >Rn, ctx.RegList(rl))
#: LDM<c>.W <Rn>{!},<registers>
#  avail: W:1 Rn:4 P:1 M:1 register_list:13
if W.bit:
    return ctx.opLDMIA({}, >Rn, ctx.RegList(cat(P, M, b"0", register_list)))
else:
    return ctx.opLDM({}, <Rn, ctx.RegList(cat(P, M, b"0", register_list)))
#: LDMDB<c> <Rn>{!},<registers>
#  avail: W:1 Rn:4 P:1 M:1 register_list:13
return ctx.opLDMDB({}, >Rn, ctx.RegList(cat(P, M, b"0", register_list)))
#: LDR<c> <Rt>, [<Rn>{,#<imm5>}]
#  avail: imm5:5 Rn:3 Rt:3
return ctx.opLDR({}, >Rt, ctx.Deref(>Rn, <cat(imm5, b"00"), 4, true, false, true))
#: LDR<c> <Rt>,[SP{,#<imm8>}]
#  avail: Rt:3 imm8:8
return ctx.opLDR({}, >Rt, ctx.Deref(>SP, <cat(imm8, b"00"), 4, true, false, true))
#: LDR<c>.W <Rt>,[<Rn>{,#<imm12>}]
#  avail: Rn:4 Rt:4 imm12:12
if Rn == PC: break
return ctx.opLDR({}, >Rt, ctx.Deref(>Rn, <imm12, 4, true, false, true))
#: LDR<c> <Rt>,[<Rn>,#+/-<imm8>]!
#  avail: Rn:4 Rt:4 P:1 U:1 W:1 imm8:8
if Rn == PC: break
if P.bit and U.bit and not W.bit: break
if Rn == SP and not P.bit and U.bit and W.bit and imm8 == b"00000100": break
if not P.bit and not W.bit: break
return ctx.opLDR({}, >Rt, ctx.Deref(>PC, <imm8, 4, P.bit, W.bit, U.bit))
# Where's mah label?
#: LDR<c> <Rt>,<label>
#  avail: Rt:3 imm8:8
return ctx.opLDR({}, >Rt, ctx.Deref(>PC, <cat(imm8, b"00"), 4, true, false, true))
#: LDR<c>.W <Rt>,[PC,#-0] Special case
#  avail: U:1 Rt:4 imm12:12
return ctx.opLDR({}, >Rt, ctx.Deref(>PC, <imm12, 4, true, U.bit, true))
#: LDR<c> <Rt>,[<Rn>,<Rm>]
#  avail: Rm:3 Rn:3 Rt:3
return ctx.opLDR({}, >Rt, ctx.Deref(>Rn, <Rm, 4, true, false, true))
#: LDR<c>.W <Rt>,[<Rn>,<Rm>{,LSL #<imm2>}]
#  avail: Rn:4 Rt:4 imm2:2 Rm:4
if Rn == PC: break
return ctx.opLDR({}, >Rt, ctx.Deref(>Rn, ctx.Shift(<Rm, LSL, <imm2), 4, true, false, true))
#: LDRB<c> <Rt>,[<Rn>{,#<imm5>}]
#  avail: imm5:5 Rn:3 Rt:3
return ctx.opLDRB({}, >Rt, ctx.Deref(>Rn, <imm5, 1, true, false, true))
#: LDRB<c>.W <Rt>,[<Rn>{,#<imm12>}]
#  avail: Rn:4 Rt:4 imm12:12
if Rt == PC or Rn == PC: break
return ctx.opLDRB({}, >Rt, ctx.Deref(>Rn, <imm12, 1, true, false, true))
#: LDRB<c> <Rt>,[<Rn>,#+/-<imm8>]!
#  avail: Rn:4 Rt:4 P:1 U:1 W:1 imm8:8
if Rt == PC and (P.bit and not U.bit and not W.bit): break
if Rn == PC: break
if P.bit and U.bit and not W.bit: break
if not P.bit and not W.bit: break
return ctx.opLDRB({}, >Rt, ctx.Deref(>Rn, <imm8, 1, P.bit, W.bit, U.bit))
#: LDRB<c> <Rt>,[PC,#-0] Special case
#  avail: U:1 Rt:4 imm12:12
if Rt == PC: break
return ctx.opLDRB({}, >Rt, ctx.Deref(>PC, <imm12, 1, true, U.bit, true))
#: LDRB<c> <Rt>,[<Rn>,<Rm>]
#  avail: Rm:3 Rn:3 Rt:3
return ctx.opLDRB({}, >Rt, ctx.Deref(>Rn, <Rm, 1, true, false, true))
#: LDRB<c>.W <Rt>,[<Rn>,<Rm>{,LSL #<imm2>}]
#  avail: Rn:4 Rt:4 imm2:2 Rm:4
if Rt == PC or Rn == PC: break
return ctx.opLDRB({}, >Rt, ctx.Deref(>Rn, ctx.Shift(<Rm, LSL, <imm2), 1, true, false, true))
#: LDRBT<c> <Rt>,[<Rn>,#<imm8>]
#  avail: Rn:4 Rt:4 imm8:8
if Rn == PC: break
return ctx.opLDRBT({}, >Rt, ctx.Deref(>Rn, <imm8, 1, true, false, true))
#: LDRD<c> <Rt>,<Rt2>,[<Rn>,#+/-<imm8>]!
#  avail: P:1 U:1 W:1 Rn:4 Rt:4 Rt2:4 imm8:8
if not P.bit and not W.bit: break
if Rn == PC: break
return ctx.opLDRD({}, >Rt, >Rt2, ctx.Deref(>Rn, <cat(imm8, b"00"), 8, P.bit, W.bit, U.bit))
#: LDRD<c> <Rt>,<Rt2>,[PC,#-0] Special case
#  avail: P:1 U:1 Rt:4 Rt2:4 imm8:8
return ctx.opLDRD({}, >Rt, >Rt2, ctx.Deref(>PC, <cat(imm8, b"00"), 8, P.bit, false, U.bit))
#: LDREX<c> <Rt>,[<Rn>{,#<imm8>}]
#  avail: Rn:4 Rt:4 imm8:8
return ctx.opLDREX({}, >Rt, ctx.Deref(>Rn, <cat(imm8, b"00"), 4, true, false, true))
#: LDREXB<c> <Rt>, [<Rn>]
#  avail: Rn:4 Rt:4
return ctx.opLDREXB({}, >Rt, ctx.Deref(>Rn, <0, 1, true, false, true))
#: LDREXH<c> <Rt>, [<Rn>]
#  avail: Rn:4 Rt:4
return ctx.opLDREXH({}, >Rt, ctx.Deref(>Rn, <0, 2, true, false, true))
#: LDRH<c> <Rt>,[<Rn>{,#<imm5>}]
#  avail: imm5:5 Rn:3 Rt:3
return ctx.opLDRH({}, >Rt, ctx.Deref(>Rn, <cat(imm5, b"0"), 2, true, false, true))
#: LDRH<c>.W <Rt>,[<Rn>{,#<imm12>}]
#  avail: Rn:4 Rt:4 imm12:12
if Rt == PC or Rn == PC: break
return ctx.opLDRH({}, >Rt, ctx.Deref(>Rn, <imm12, 2, true, false, true))
#: LDRH<c> <Rt>,[<Rn>,#+/-<imm8>]!
#  avail: Rn:4 Rt:4 P:1 U:1 W:1 imm8:8
if Rn == PC: break
if Rt == PC and (P.bit and not U.bit and not W.bit): break
if P.bit and U.bit and not W.bit: break
return ctx.opLDRH({}, >Rt, ctx.Deref(>Rn, <imm8, 2, P.bit, W.bit, U.bit))
#: LDRH<c> <Rt>,[PC,#-0] Special case
#  avail: U:1 Rt:4 imm12:12
if Rt == PC: break
return ctx.opLDRH({}, >Rt, ctx.Deref(>PC, <imm12, 2, true, U.bit, true))
#: LDRH<c> <Rt>,[<Rn>,<Rm>]
#  avail: Rm:3 Rn:3 Rt:3
return ctx.opLDRH({}, >Rt, ctx.Deref(<Rn, <Rm, 2, true, false, true))
#: LDRH<c>.W <Rt>,[<Rn>,<Rm>{,LSL #<imm2>}]
#  avail: Rn:4 Rt:4 imm2:2 Rm:4
if Rn == PC or Rt == PC: break
return ctx.opLDRH({}, >Rt, ctx.Deref(<Rn, ctx.Shift(<Rm, LSL, <imm2), 2, true, false, true))
#: LDRHT<c> <Rt>,[<Rn>,#<imm8>]
#  avail: Rn:4 Rt:4 imm8:8
if Rn == PC: break
return ctx.opLDRHT({}, >Rt, ctx.Deref(<Rn, <imm8, 2, true, false, true))
#: LDRSB<c> <Rt>,[<Rn>,#<imm12>]
#  avail: Rn:4 Rt:4 imm12:12
if Rt == PC or Rn == PC: break
return ctx.opLDRSB({}, >Rt, ctx.Deref(>Rn, <imm12, 1, true, false, true))
#: LDRSB<c> <Rt>,[<Rn>,#+/-<imm8>]!
#  avail: Rn:4 Rt:4 P:1 U:1 W:1 imm8:8
if Rt == PC and (P.bit and not U.bit and not W.bit): break
if Rn == PC: break
if P.bit and U.bit and not W.bit: break
if not P.bit and not W.bit: break
return ctx.opLDRSB({}, >Rt, ctx.Deref(>Rn, <imm8, 1, P.bit, W.bit, U.bit))
#: LDRSB<c> <Rt>,[PC,#-0] Special case
#  avail: U:1 Rt:4 imm12:12
if Rt == PC: break
return ctx.opLDRSB({}, >Rt, ctx.Deref(>PC, <imm12, 1, true, U.bit, true))
#: LDRSB<c> <Rt>,[<Rn>,<Rm>]
#  avail: Rm:3 Rn:3 Rt:3
return ctx.opLDRSB({}, >Rt, ctx.Deref(>Rn, <Rm, 1, true, false, true))
#: LDRSB<c>.W <Rt>,[<Rn>,<Rm>{,LSL #<imm2>}]
#  avail: Rn:4 Rt:4 imm2:2 Rm:4
if Rt == PC or Rn == PC: break
return ctx.opLDRSB({}, >Rt, ctx.Deref(>Rn, ctx.Shift(<Rm, LSL, <imm2), 1, true, false, true))
#: LDRSBT<c> <Rt>,[<Rn>,#<imm8>]
#  avail: Rn:4 Rt:4 imm8:8
if Rn == PC: break
return ctx.opLDRSBT({}, >Rt, ctx.Deref(>Rn, <imm8, 1, true, false, true))
#: LDRSH<c> <Rt>,[<Rn>,#<imm12>]
#  avail: Rn:4 Rt:4 imm12:12
if Rt == PC or Rn == PC: break
return ctx.opLDRSH({}, >Rt, ctx.Deref(>Rn, <imm12, 2, true, false, true))
#: LDRSH<c> <Rt>,[<Rn>,#+/-<imm8>]!
#  avail: Rn:4 Rt:4 P:1 U:1 W:1 imm8:8
if Rn == PC: break
if Rt == PC and (P.bit and not U.bit and not W.bit): break
if P.bit and U.bit and not W.bit: break
return ctx.opLDRSH({}, >Rt, ctx.Deref(>Rn, <imm8, 2, P.bit, W.bit, U.bit))
#: LDRSH<c> <Rt>,[PC,#-0] Special case
#  avail: U:1 Rt:4 imm12:12
if Rt == PC: break
return ctx.opLDRSH({}, >Rt, ctx.Deref(>PC, <imm12, 2, true, U.bit, true))
#: LDRSH<c> <Rt>,[<Rn>,<Rm>]
#  avail: Rm:3 Rn:3 Rt:3
return ctx.opLDRSH({}, >Rt, ctx.Deref(<Rn, <Rm, 2, true, false, true))
#: LDRSH<c>.W <Rt>,[<Rn>,<Rm>{,LSL #<imm2>}]
#  avail: Rn:4 Rt:4 imm2:2 Rm:4
if Rn == PC or Rt == PC: break
return ctx.opLDRSH({}, >Rt, ctx.Deref(<Rn, ctx.Shift(<Rm, LSL, <imm2), 2, true, false, true))
#: LDRSHT<c> <Rt>,[<Rn>,#<imm8>]
#  avail: Rn:4 Rt:4 imm8:8
if Rn == PC: break
return ctx.opLDRSHT({}, >Rt, ctx.Deref(<Rn, <imm8, 2, true, false, true))
#: LDRT<c> <Rt>,[<Rn>,#<imm8>]
#  avail: Rn:4 Rt:4 imm8:8
if Rn == PC: break
return ctx.opLDRT({}, >Rt, ctx.Deref(<Rn, <imm8, 4, true, false, true))
#: LSL<c> <Rd>,<Rm>,#<imm5>
#  avail: imm5:5 Rm:3 Rd:3
# DIShift with b"00" is just a LSL
return ctx.opLSL(t, >Rd, ctx.Shift(<Rm, LSL, <imm5))
#: LSL{S}<c>.W <Rd>,<Rm>,#<imm5>
#  avail: S:1 imm3:3 Rd:4 imm2:2 Rm:4
return ctx.opLSL(S, >Rd, ctx.Shift(<Rm, LSL, <cat(imm3, imm2)))
#: LSL<c> <Rdn>,<Rm>
#  avail: Rm:3 Rdn:3
return ctx.opLSL(t, >Rdn, ctx.Shift(<Rdn, LSL, <Rm))
#: LSL{S}<c>.W <Rd>,<Rn>,<Rm>
#  avail: S:1 Rn:4 Rd:4 Rm:4
return ctx.opLSL(S, >Rd, ctx.Shift(<Rn, LSL, <Rm))
#: LSR<c> <Rd>,<Rm>,#<imm5>
#  avail: imm5:5 Rm:3 Rd:3
return ctx.opLSR(t, >Rd, ctx.Shift(<Rm, LSR, <imm5))
#: LSR{S}<c>.W <Rd>,<Rm>,#<imm5>
#  avail: S:1 imm3:3 Rd:4 imm2:2 Rm:4
return ctx.opLSR(S, >Rd, ctx.Shift(<Rm, LSR, <cat(imm3, imm2)))
#: LSR<c> <Rdn>,<Rm>
#  avail: Rm:3 Rdn:3
return ctx.opLSR(t, >Rdn, ctx.Shift(<Rdn, LSR, <Rm))
#: LSR{S}<c>.W <Rd>,<Rn>,<Rm>
#  avail: S:1 Rn:4 Rd:4 Rm:4
return ctx.opLSR(S, >Rd, ctx.Shift(<Rn, LSR, <Rm))
#: MCR<c> <coproc>,<opc1>,<Rt>,<CRn>,<CRm>{,<opc2>}
#  avail: opc1:3 CRn:4 Rt:4 coproc:4 opc2:3 CRm:4
if coproc[3,1] == b"101": break
return ctx.opMCR({}, <coproc, <opc1, <Rt, <Crn, <Crm, <opc2)
#: MCR2<c> <coproc>,<opc1>,<Rt>,<CRn>,<CRm>{,<opc2>}
#  avail: opc1:3 CRn:4 Rt:4 coproc:4 opc2:3 CRm:4
 # no check here!
return ctx.opMCR2({}, <coproc, <opc1, <Rt, <Crn, <Crm, <opc2)
#: MCRR<c> <coproc>,<opc1>,<Rt>,<Rt2>,<CRm>
#  avail: Rt2:4 Rt:4 coproc:4 opc1:4 CRm:4
if coproc[3,1] == b"101": break
return ctx.opMCRR({}, <coproc, <opc1, <Rt, <Rt2, <CRm)
#: MCRR2<c> <coproc>,<opc1>,<Rt>,<Rt2>,<CRm>
#  avail: Rt2:4 Rt:4 coproc:4 opc1:4 CRm:4
return ctx.opMCRR2({}, <coproc, <opc1, <Rt, <Rt2, <CRm)
#: MLA<c> <Rd>,<Rn>,<Rm>,<Ra>
#  avail: Rn:4 Ra:4 Rd:4 Rm:4

#: MLS<c> <Rd>,<Rn>,<Rm>,<Ra>
#  avail: Rn:4 Ra:4 Rd:4 Rm:4

#: MOV<c> <Rd>,#<imm8>
#  avail: Rd:3 imm8:8

#: MOV{S}<c>.W <Rd>,#<const>
#  avail: i:1 S:1 imm3:3 Rd:4 imm8:8

#: MOVW<c> <Rd>,#<imm16>
#  avail: i:1 imm4:4 imm3:3 Rd:4 imm8:8

#: MOV<c> <Rd>,<Rm>
#  avail: D:1 Rm:4 Rd:3

#: MOVS <Rd>,<Rm> (formerly LSL <Rd>,<Rm>,#0)
#  avail: Rm:3 Rd:3

#: MOV{S}<c>.W <Rd>,<Rm>
#  avail: S:1 Rd:4 Rm:4

#: MOVT<c> <Rd>,#<imm16>
#  avail: i:1 imm4:4 imm3:3 Rd:4 imm8:8

#: MRC<c> <coproc>,<opc1>,<Rt>,<CRn>,<CRm>{,<opc2>}
#  avail: opc1:3 CRn:4 Rt:4 coproc:4 opc2:3 CRm:4

#: MRC2<c> <coproc>,<opc1>,<Rt>,<CRn>,<CRm>{,<opc2>}
#  avail: opc1:3 CRn:4 Rt:4 coproc:4 opc2:3 CRm:4

#: MRRC<c> <coproc>,<opc>,<Rt>,<Rt2>,<CRm>
#  avail: Rt2:4 Rt:4 coproc:4 opc1:4 CRm:4

#: MRRC2<c> <coproc>,<opc>,<Rt>,<Rt2>,<CRm>
#  avail: Rt2:4 Rt:4 coproc:4 opc1:4 CRm:4

#: MRS<c> <Rd>,<spec_reg>
#  avail: Rd:4 SYSm:8

#: MSR<c> <spec_reg>,<Rn>
#  avail: Rn:4 SYSm:8

#: MUL<c> <Rdm>,<Rn>,<Rdm>
#  avail: Rn:3 Rdm:3

#: MUL<c> <Rd>,<Rn>,<Rm>
#  avail: Rn:4 Rd:4 Rm:4

#: MVN{S}<c> <Rd>,#<const>
#  avail: i:1 S:1 imm3:3 Rd:4 imm8:8

#: MVN<c> <Rd>,<Rm>
#  avail: Rm:3 Rd:3

#: MVN{S}<c>.W <Rd>,<Rm>{,shift>}
#  avail: S:1 imm3:3 Rd:4 imm2:2 typ:2 Rm:4

#: NOP<c>
#  avail: 

#: NOP<c>.W
#  avail: 

#: ORN{S}<c> <Rd>,<Rn>,#<const>
#  avail: i:1 S:1 Rn:4 imm3:3 Rd:4 imm8:8

#: ORN{S}<c> <Rd>,<Rn>,<Rm>{,<shift>}
#  avail: S:1 Rn:4 imm3:3 Rd:4 imm2:2 typ:2 Rm:4

#: ORR{S}<c> <Rd>,<Rn>,#<const>
#  avail: i:1 S:1 Rn:4 imm3:3 Rd:4 imm8:8

#: ORR<c> <Rdn>,<Rm>
#  avail: Rm:3 Rdn:3

#: ORR{S}<c>.W <Rd>,<Rn>,<Rm>{,<shift>}
#  avail: S:1 Rn:4 imm3:3 Rd:4 imm2:2 typ:2 Rm:4

#: PLD{W}<c> [<Rn>,#<imm12>]
#  avail: W:1 Rn:4 imm12:12

#: PLD{W}<c> [<Rn>,#-<imm8>]
#  avail: W:1 Rn:4 imm8:8

#: PLD<c> <label>
#  avail: U:1 imm12:12

#: PLD<c> [<Rn>,<Rm>{,LSL #<imm2>}]
#  avail: Rn:4 shift:2 Rm:4

#: PLI<c> [<Rn>,#<imm12>]
#  avail: Rn:4 imm12:12

#: PLI<c> [<Rn>,#-<imm8>]
#  avail: Rn:4 imm8:8

#: PLI<c> <label>
#  avail: U:1 imm12:12

#: PLI<c> [<Rn>,<Rm>{,LSL #<imm2>}]
#  avail: Rn:4 shift:2 Rm:4

#: POP<c> <registers>
#  avail: P:1 register_list:8

#: POP<c>.W <registers>
#  avail: P:1 M:1 register_list:13

#: PUSH<c> <registers>
#  avail: M:1 register_list:8

#: PUSH<c>.W <registers>
#  avail: M:1 register_list:13

#: RBIT<c> <Rd>,<Rm>
#  avail: Rm:4 Rd:4 Rm_P:4

#: REV<c> <Rd>,<Rm>
#  avail: Rm:3 Rd:3

#: REV<c>.W <Rd>,<Rm>
#  avail: Rm:4 Rd:4 Rm_P:4

#: REV16<c> <Rd>,<Rm>
#  avail: Rm:3 Rd:3

#: REV16<c>.W <Rd>,<Rm>
#  avail: Rm:4 Rd:4 Rm_P:4

#: REVSH<c> <Rd>,<Rm>
#  avail: Rm:3 Rd:3

#: REVSH<c>.W <Rd>,<Rm>
#  avail: Rm:4 Rd:4 Rm_P:4

#: ROR{S}<c> <Rd>,<Rm>,#<imm5>
#  avail: S:1 imm3:3 Rd:4 imm2:2 Rm:4

#: ROR<c> <Rdn>,<Rm>
#  avail: Rm:3 Rdn:3

#: ROR{S}<c>.W <Rd>,<Rn>,<Rm>
#  avail: S:1 Rn:4 Rd:4 Rm:4

#: RRX{S}<c> <Rd>,<Rm>
#  avail: S:1 Rd:4 Rm:4

#: RSB<c> <Rd>,<Rn>,#0
#  avail: Rn:3 Rd:3

#: RSB{S}<c>.W <Rd>,<Rn>,#<const>
#  avail: i:1 S:1 Rn:4 imm3:3 Rd:4 imm8:8

#: RSB{S}<c> <Rd>,<Rn>,<Rm>{,<shift>}
#  avail: S:1 Rn:4 imm3:3 Rd:4 imm2:2 typ:2 Rm:4

#: SBC{S}<c> <Rd>,<Rn>,#<const>
#  avail: i:1 S:1 Rn:4 imm3:3 Rd:4 imm8:8

#: SBC<c> <Rdn>,<Rm>
#  avail: Rm:3 Rdn:3

#: SBC{S}<c>.W <Rd>,<Rn>,<Rm>{,<shift>}
#  avail: S:1 Rn:4 imm3:3 Rd:4 imm2:2 typ:2 Rm:4

#: SBFX<c> <Rd>,<Rn>,#<lsb>,#<width>
#  avail: Rn:4 imm3:3 Rd:4 imm2:2 widthm1:5

#: SDIV<c> <Rd>,<Rn>,<Rm>
#  avail: Rn:4 Rd:4 Rm:4

#: SEV<c>
#  avail: 

#: SEV<c>.W
#  avail: 

#: SMLAL<c> <RdLo>,<RdHi>,<Rn>,<Rm>
#  avail: Rn:4 RdLo:4 RdHi:4 Rm:4

#: SMULL<c> <RdLo>,<RdHi>,<Rn>,<Rm>
#  avail: Rn:4 RdLo:4 RdHi:4 Rm:4

#: SSAT<c> <Rd>,#<imm5>,<Rn>{,<shift>}
#  avail: sh:1 Rn:4 imm3:3 Rd:4 imm2:2 sat_imm:5

#: STC{L}<c> <coproc>,<CRd>,[<Rn>],<option>
#  avail: P:1 U:1 N:1 W:1 Rn:4 CRd:4 coproc:4 imm8:8

#: STC2{L}<c> <coproc>,<CRd>,[<Rn>],<option>
#  avail: P:1 U:1 N:1 W:1 Rn:4 CRd:4 coproc:4 imm8:8

#: STM<c> <Rn>!,<registers>
#  avail: Rn:3 register_list:8

#: STM<c>.W <Rn>{!},<registers>
#  avail: W:1 Rn:4 M:1 register_list:13

#: STMDB<c> <Rn>{!},<registers>
#  avail: W:1 Rn:4 M:1 register_list:13

#: STR<c> <Rt>, [<Rn>{,#<imm5>}]
#  avail: imm5:5 Rn:3 Rt:3

#: STR<c> <Rt>,[SP,#<imm8>]
#  avail: Rt:3 imm8:8

#: STR<c>.W <Rt>,[<Rn>,#<imm12>]
#  avail: Rn:4 Rt:4 imm12:12

#: STR<c> <Rt>,[<Rn>,#+/-<imm8>]!
#  avail: Rn:4 Rt:4 P:1 U:1 W:1 imm8:8

#: STR<c> <Rt>,[<Rn>,<Rm>]
#  avail: Rm:3 Rn:3 Rt:3

#: STR<c>.W <Rt>,[<Rn>,<Rm>{,LSL #<imm2>}]
#  avail: Rn:4 Rt:4 imm2:2 Rm:4

#: STRB<c> <Rt>,[<Rn>,#<imm5>]
#  avail: imm5:5 Rn:3 Rt:3

#: STRB<c>.W <Rt>,[<Rn>,#<imm12>]
#  avail: Rn:4 Rt:4 imm12:12

#: STRB<c> <Rt>,[<Rn>,#+/-<imm8>]!
#  avail: Rn:4 Rt:4 P:1 U:1 W:1 imm8:8

#: STRB<c> <Rt>,[<Rn>,<Rm>]
#  avail: Rm:3 Rn:3 Rt:3

#: STRB<c>.W <Rt>,[<Rn>,<Rm>{,LSL #<imm2>}]
#  avail: Rn:4 Rt:4 imm2:2 Rm:4

#: STRBT<c> <Rt>,[<Rn>,#<imm8>]
#  avail: Rn:4 Rt:4 imm8:8

#: STRD<c> <Rt>,<Rt2>,[<Rn>,#+/-<imm8>]!
#  avail: P:1 U:1 W:1 Rn:4 Rt:4 Rt2:4 imm8:8

#: STREX<c> <Rd>,<Rt>,[<Rn>{,#<imm8>}]
#  avail: Rn:4 Rt:4 Rd:4 imm8:8

#: STREXB<c> <Rd>,<Rt>,[<Rn>]
#  avail: Rn:4 Rt:4 Rd:4

#: STREXH<c> <Rd>,<Rt>,[<Rn>]
#  avail: Rn:4 Rt:4 Rd:4

#: STRH<c> <Rt>,[<Rn>{,#<imm5>}]
#  avail: imm5:5 Rn:3 Rt:3

#: STRH<c>.W <Rt>,[<Rn>{,#<imm12>}]
#  avail: Rn:4 Rt:4 imm12:12

#: STRH<c> <Rt>,[<Rn>,#+/-<imm8>]!
#  avail: Rn:4 Rt:4 P:1 U:1 W:1 imm8:8

#: STRH<c> <Rt>,[<Rn>,<Rm>]
#  avail: Rm:3 Rn:3 Rt:3

#: STRH<c>.W <Rt>,[<Rn>,<Rm>{,LSL #<imm2>}]
#  avail: Rn:4 Rt:4 imm2:2 Rm:4

#: STRHT<c> <Rt>,[<Rn>,#<imm8>]
#  avail: Rn:4 Rt:4 imm8:8

#: STRT<c> <Rt>,[<Rn>,#<imm8>]
#  avail: Rn:4 Rt:4 imm8:8

#: SUB<c> <Rd>,<Rn>,#<imm3>
#  avail: imm3:3 Rn:3 Rd:3

#: SUB<c> <Rdn>,#<imm8>
#  avail: Rdn:3 imm8:8

#: SUB{S}<c>.W <Rd>,<Rn>,#<const>
#  avail: i:1 S:1 Rn:4 imm3:3 Rd:4 imm8:8

#: SUBW<c> <Rd>,<Rn>,#<imm12>
#  avail: i:1 Rn:4 imm3:3 Rd:4 imm8:8

#: SUB<c> <Rd>,<Rn>,<Rm>
#  avail: Rm:3 Rn:3 Rd:3

#: SUB{S}<c>.W <Rd>,<Rn>,<Rm>{,<shift>}
#  avail: S:1 Rn:4 imm3:3 Rd:4 imm2:2 typ:2 Rm:4

#: SUB<c> SP,SP,#<imm7>
#  avail: imm7:7

#: SUB{S}<c>.W <Rd>,SP,#<const>
#  avail: i:1 S:1 imm3:3 Rd:4 imm8:8

#: SUBW<c> <Rd>,SP,#<imm12>
#  avail: i:1 imm3:3 Rd:4 imm8:8

#: SUB{S}<c> <Rd>,SP,<Rm>{,<shift>}
#  avail: S:1 imm3:3 Rd:4 imm2:2 typ:2 Rm:4

#: SVC<c> #<imm8>
#  avail: imm8:8
return ctx.opSVC({}, <imm8)
#: SXTB<c> <Rd>,<Rm>
#  avail: Rm:3 Rd:3

#: SXTB<c>.W <Rd>,<Rm>{,<rotation>}
#  avail: Rd:4 rotate:2 Rm:4

#: SXTH<c> <Rd>,<Rm>
#  avail: Rm:3 Rd:3

#: SXTH<c>.W <Rd>,<Rm>{,<rotation>}
#  avail: Rd:4 rotate:2 Rm:4

#: TBH<c> [<Rn>,<Rm>,LSL #1]
#  avail: Rn:4 H:1 Rm:4

#: TEQ<c> <Rn>,#<const>
#  avail: i:1 Rn:4 imm3:3 imm8:8

#: TEQ<c> <Rn>,<Rm>{,<shift>}
#  avail: Rn:4 imm3:3 imm2:2 typ:2 Rm:4

#: TST<c> <Rn>,#<const>
#  avail: i:1 Rn:4 imm3:3 imm8:8

#: TST<c> <Rn>,<Rm>
#  avail: Rm:3 Rn:3

#: TST<c>.W <Rn>,<Rm>{,<shift>}
#  avail: Rn:4 imm3:3 imm2:2 typ:2 Rm:4

#: UBFX<c> <Rd>,<Rn>,#<lsb>,#<width>
#  avail: Rn:4 imm3:3 Rd:4 imm2:2 widthm1:5

#: UDIV<c> <Rd>,<Rn>,<Rm>
#  avail: Rn:4 Rd:4 Rm:4

#: UMLAL<c> <RdLo>,<RdHi>,<Rn>,<Rm>
#  avail: Rn:4 RdLo:4 RdHi:4 Rm:4

#: UMULL<c> <RdLo>,<RdHi>,<Rn>,<Rm>
#  avail: Rn:4 RdLo:4 RdHi:4 Rm:4

#: USAT<c> <Rd>,#<imm5>,<Rn>{,<shift>}
#  avail: sh:1 Rn:4 imm3:3 Rd:4 imm2:2 sat_imm:5

#: UXTB<c> <Rd>,<Rm>
#  avail: Rm:3 Rd:3
return ctx.opUXTB({}, <Rd, <Rm)
#: UXTB<c>.W <Rd>,<Rm>{,<rotation>}
#  avail: Rd:4 rotate:2 Rm:4
return ctx.opUXTB({}, >Rd, ctx.Shift(<Rm, ROR, <cat(rotate, b"000")))
#: UXTH<c> <Rd>,<Rm>
#  avail: Rm:3 Rd:3
return ctx.opUXTH({}, >Rd, <Rm)
#: UXTH<c>.W <Rd>,<Rm>{,<rotation>}
#  avail: Rd:4 rotate:2 Rm:4
return ctx.opUXTH({}, >Rd, ctx.Shift(<Rm, ROR, <cat(rotate, b"000")))
#: WFE<c>
#  avail: 
return ctx.opWFE({})
#: WFE<c>.W
#  avail: 
return ctx.opWFE({})
#: WFI<c>
#  avail: 
return ctx.opWFI({})
#: WFI<c>.W
#  avail: 
return ctx.opWFI({})
#: YIELD<c>
#  avail: 
return ctx.opYIELD({})
#: YIELD<c>.W
#  avail: 
return ctx.opYIELD({})
#: CPS<effect> <iflags>
#  avail: im:1 I:1 F:1

#: MRS<c> <Rd>,<spec_reg>
#  avail: Rd:4 SYSm:8

#: MSR<c> <spec_reg>,<Rn>
#  avail: Rn:4 SYSm:8

#: done
