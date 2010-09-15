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
#nil # see B4-2
return ctx.opCPS(if not im.bit: {ifCPSIE} else: {}, ctx.CPSarg(I.bit, F.bit))
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
return ctx.opLDC({}, <coproc, <CRd, ctx.Deref(>Rn, <cat(imm8, b"00"), 4, P.bit, W.bit, U.bit))
#: LDC2{L}<c> <coproc>,<CRd>,[<Rn>],<option>
#  avail: P:1 U:1 D:1 W:1 Rn:4 CRd:4 coproc:4 imm8:8
if P == b"0" and W == b"0": break
return ctx.opLDC2({}, <coproc, <CRd, ctx.Deref(>Rn, <cat(imm8, b"00"), 4, P.bit, W.bit, U.bit))
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
if Ra == PC: break
# TODO: This affects N and Z flags but not C, V
return ctx.opMLA({}, >Rd, <Rn, <Rm, <Ra)
#: MLS<c> <Rd>,<Rn>,<Rm>,<Ra>
#  avail: Rn:4 Ra:4 Rd:4 Rm:4
# This does not affect /any/ flags.
return ctx.opMLA({}, >Rd, <Rn, <Rm, <Ra)
#: MOV<c> <Rd>,#<imm8>
#  avail: Rd:3 imm8:8
return ctx.opMOV(t, >Rd, <imm8)
#: MOV{S}<c>.W <Rd>,#<const>
#  avail: i:1 S:1 imm3:3 Rd:4 imm8:8
var r = ctx.TEImm_C(cat(i, imm3, imm8))
return ctx.opMOV(S + r.setCarry, >Rd, <r.ent)
#: MOVW<c> <Rd>,#<imm16>
#  avail: i:1 imm4:4 imm3:3 Rd:4 imm8:8
return ctx.opMOV({}, >Rd, <cat(imm4, i, imm3, imm8))
#: MOV<c> <Rd>,<Rm>
#  avail: D:1 Rm:4 Rd:3
return ctx.opMOV(t, >Rd, <Rm)
#: MOVS <Rd>,<Rm> (formerly LSL <Rd>,<Rm>,#0)
#  avail: Rm:3 Rd:3
return ctx.opMOV({}, >Rd, <Rm)
#: MOV{S}<c>.W <Rd>,<Rm>
#  avail: S:1 Rd:4 Rm:4
return ctx.opMOV(S, >Rd, <Rm)
#: MOVT<c> <Rd>,#<imm16>
#  avail: i:1 imm4:4 imm3:3 Rd:4 imm8:8
return ctx.opMOVT({}, >Rd, <cat(imm4, i, imm3, imm8))
#: MRC<c> <coproc>,<opc1>,<Rt>,<CRn>,<CRm>{,<opc2>}
#  avail: opc1:3 CRn:4 Rt:4 coproc:4 opc2:3 CRm:4
if coproc[3,1] == b"101": break
return ctx.opMRC({}, <coproc, <opc1, >Rt, <Crn, <Crm, <opc2)
#: MRC2<c> <coproc>,<opc1>,<Rt>,<CRn>,<CRm>{,<opc2>}
#  avail: opc1:3 CRn:4 Rt:4 coproc:4 opc2:3 CRm:4
return ctx.opMRC2({}, <coproc, <opc1, >Rt, <Crn, <Crm, <opc2)
#: MRRC<c> <coproc>,<opc>,<Rt>,<Rt2>,<CRm>
#  avail: Rt2:4 Rt:4 coproc:4 opc1:4 CRm:4
if coproc[3,1] == b"101": break
return ctx.opMRRC({}, <coproc, <opc1, >Rt, >Rt2, <Crm)
#: MRRC2<c> <coproc>,<opc>,<Rt>,<Rt2>,<CRm>
#  avail: Rt2:4 Rt:4 coproc:4 opc1:4 CRm:4
return ctx.opMRRC2({}, <coproc, <opc1, >Rt, >Rt2, <Crm)
#: MRS<c> <Rd>,<spec_reg>
#  avail: Rd:4 SYSm:8
return ctx.opMRS({}, >Rd, <SYSm)
#: MSR<c> <spec_reg>,<Rn>
#  avail: Rn:4 SYSm:8
return ctx.opMSR({}, <SYSm, <Rn)
#: MUL<c> <Rdm>,<Rn>,<Rdm>
#  avail: Rn:3 Rdm:3
return ctx.opMUL(t, >Rdm, <Rn, <Rdm)
#: MUL<c> <Rd>,<Rn>,<Rm>
#  avail: Rn:4 Rd:4 Rm:4
return ctx.opMUL({}, >Rd, <Rn, <Rm)
#: MVN{S}<c> <Rd>,#<const>
#  avail: i:1 S:1 imm3:3 Rd:4 imm8:8
var r = ctx.TEImm_C(cat(i, imm3, imm8))
##return ctx.opMOV(S + r.setCarry, >Rd, <(not r.ent))
return ctx.opMVN(S + r.setCarry, >Rd, <r.ent)
#: MVN<c> <Rd>,<Rm>
#  avail: Rm:3 Rd:3
return ctx.opMVN(t, >Rd, <Rm)
#: MVN{S}<c>.W <Rd>,<Rm>{,shift>}
#  avail: S:1 imm3:3 Rd:4 imm2:2 typ:2 Rm:4
return ctx.opMVN(S, >Rd, ctx.DIShift(<Rm, typ, cat(imm3, imm2)))
#: NOP<c>
#  avail: 
return ctx.opNOP({})
#: NOP<c>.W
#  avail: 
return ctx.opNOP({})
#: ORN{S}<c> <Rd>,<Rn>,#<const>
#  avail: i:1 S:1 Rn:4 imm3:3 Rd:4 imm8:8
var r = ctx.TEImm_C(cat(i, imm3, imm8))
return ctx.opORN(S + r.setCarry, >Rd, <Rn, <r.ent)
#: ORN{S}<c> <Rd>,<Rn>,<Rm>{,<shift>}
#  avail: S:1 Rn:4 imm3:3 Rd:4 imm2:2 typ:2 Rm:4
return ctx.opORN(S, >Rd, <Rn, ctx.DIShift(<Rm, typ, cat(imm3, imm2)))
#: ORR{S}<c> <Rd>,<Rn>,#<const>
#  avail: i:1 S:1 Rn:4 imm3:3 Rd:4 imm8:8
var r = ctx.TEImm_C(cat(i, imm3, imm8))
return ctx.opORR(S + r.setCarry, >Rd, <Rn, <r.ent)
#: ORR<c> <Rdn>,<Rm>
#  avail: Rm:3 Rdn:3
return ctx.opORR(t, >Rdn, <Rdn, <Rm)
#: ORR{S}<c>.W <Rd>,<Rn>,<Rm>{,<shift>}
#  avail: S:1 Rn:4 imm3:3 Rd:4 imm2:2 typ:2 Rm:4
return ctx.opORR(S, >Rd, <Rn, ctx.DIShift(<Rm, typ, cat(imm3, imm2)))
#: PLD{W}<c> [<Rn>,#<imm12>]
#  avail: W:1 Rn:4 imm12:12
if Rn == PC: break
return ctx.opPLD(if W.bit: {ifPLDW} else: {}, ctx.Deref(>Rn, <imm12, 4, true, false, true))
#: PLD{W}<c> [<Rn>,#-<imm8>]
#  avail: W:1 Rn:4 imm8:8
if Rn == PC: break
return ctx.opPLD(if W.bit: {ifPLDW} else: {}, ctx.Deref(>Rn, <imm8, 4, true, false, false))
#: PLD<c> <label>
#  avail: U:1 imm12:12
return ctx.opPLD({}, ctx.Deref(>PC, <imm12, 4, true, false, U.bit))
#: PLD<c> [<Rn>,<Rm>{,LSL #<imm2>}]
#  avail: Rn:4 shift:2 Rm:4
if Rn == PC: break
# XXX newer version has a W bit
return ctx.opPLD({}, ctx.Deref(<Rn, ctx.Shift(<Rm, LSL, <shift), 4, true, false, true))
#: PLI<c> [<Rn>,#<imm12>]
#  avail: Rn:4 imm12:12
return ctx.opPLI({}, ctx.Deref(>PC, <imm12, 4, true, false, true))
#: PLI<c> [<Rn>,#-<imm8>]
#  avail: Rn:4 imm8:8
return ctx.opPLI({}, ctx.Deref(>PC, <imm8, 4, true, false, false))
#: PLI<c> <label>
#  avail: U:1 imm12:12
return ctx.opPLI({}, ctx.Deref(>PC, <imm12, 4, true, false, U.bit))
#: PLI<c> [<Rn>,<Rm>{,LSL #<imm2>}]
#  avail: Rn:4 shift:2 Rm:4
# XXX newer version has a W bit
return ctx.opPLI({}, ctx.Deref(<Rn, ctx.Shift(<Rm, LSL, <shift), 4, true, false, true))
#: POP<c> <registers>
#  avail: P:1 register_list:8
return ctx.opLDMIA({}, >SP, ctx.RegList(cat(P, b"0000000", register_list)))
#: POP<c>.W <registers>
#  avail: P:1 M:1 register_list:13
return ctx.opLDMIA({}, >SP, ctx.RegList(cat(P, M, b"0", register_list)))
#: PUSH<c> <registers>
#  avail: M:1 register_list:8
return ctx.opSTMIA({}, >SP, ctx.RegList(cat(b"0", M, b"0000000", register_list)))
#: PUSH<c>.W <registers>
#  avail: M:1 register_list:13
return ctx.opSTMIA({}, >SP, ctx.RegList(cat(b"0", M, b"0", register_list)))
#: RBIT<c> <Rd>,<Rm>
#  avail: Rm:4 Rd:4 Rm_P:4
return ctx.opRBIT({}, >Rd, <Rm)
#: REV<c> <Rd>,<Rm>
#  avail: Rm:3 Rd:3
return ctx.opREV({}, >Rd, <Rm)
#: REV<c>.W <Rd>,<Rm>
#  avail: Rm:4 Rd:4 Rm_P:4
return ctx.opREV({}, >Rd, <Rm)
#: REV16<c> <Rd>,<Rm>
#  avail: Rm:3 Rd:3
return ctx.opREV16({}, >Rd, <Rm)
#: REV16<c>.W <Rd>,<Rm>
#  avail: Rm:4 Rd:4 Rm_P:4
return ctx.opREV16({}, >Rd, <Rm)
#: REVSH<c> <Rd>,<Rm>
#  avail: Rm:3 Rd:3
return ctx.opREVSH({}, >Rd, <Rm)
#: REVSH<c>.W <Rd>,<Rm>
#  avail: Rm:4 Rd:4 Rm_P:4
return ctx.opREVSH({}, >Rd, <Rm)
#: ROR{S}<c> <Rd>,<Rm>,#<imm5>
#  avail: S:1 imm3:3 Rd:4 imm2:2 Rm:4
if imm3 == b"000" and imm2 == b"00": break
return ctx.opROR(S, >Rd, ctx.Shift(<Rm, ROR, <cat(imm3, imm2)))
#: ROR<c> <Rdn>,<Rm>
#  avail: Rm:3 Rdn:3
return ctx.opROR(t, >Rdn, <Rdn, <Rm)
#: ROR{S}<c>.W <Rd>,<Rn>,<Rm>
#  avail: S:1 Rn:4 Rd:4 Rm:4
return ctx.opROR(S, >Rd, ctx.Shift(<Rn, ROR, <Rm))
#: RRX{S}<c> <Rd>,<Rm>
#  avail: S:1 Rd:4 Rm:4
return ctx.opRRX(S, >Rd, ctx.Shift(<Rm, RRX, <1))
#: RSB<c> <Rd>,<Rn>,#0
#  avail: Rn:3 Rd:3
return ctx.opRSB(t, >Rd, <Rn, <0)
#: RSB{S}<c>.W <Rd>,<Rn>,#<const>
#  avail: i:1 S:1 Rn:4 imm3:3 Rd:4 imm8:8
return ctx.opRSB(S, >Rd, <Rn, ctx.TEImm(cat(i, imm3, imm8)))
#: RSB{S}<c> <Rd>,<Rn>,<Rm>{,<shift>}
#  avail: S:1 Rn:4 imm3:3 Rd:4 imm2:2 typ:2 Rm:4
return ctx.opRSB(S, >Rd, <Rn, ctx.DIShift(<Rm, typ, cat(imm3, imm2)))
#: SBC{S}<c> <Rd>,<Rn>,#<const>
#  avail: i:1 S:1 Rn:4 imm3:3 Rd:4 imm8:8
return ctx.opSBC(S, >Rd, <Rn, ctx.TEImm(cat(i, imm3, imm8)))
#: SBC<c> <Rdn>,<Rm>
#  avail: Rm:3 Rdn:3
return ctx.opSBC(t, >Rdn, <Rdn, <Rm)
#: SBC{S}<c>.W <Rd>,<Rn>,<Rm>{,<shift>}
#  avail: S:1 Rn:4 imm3:3 Rd:4 imm2:2 typ:2 Rm:4
return ctx.opSBC(S, >Rd, <Rn, ctx.DIShift(<Rm, typ, cat(imm3, imm2)))
#: SBFX<c> <Rd>,<Rn>,#<lsb>,#<width>
#  avail: Rn:4 imm3:3 Rd:4 imm2:2 widthm1:5
return ctx.opSBFX({}, >Rd, <Rn, <cat(imm3, imm2), <(widthm1.num + 1))
#: SDIV<c> <Rd>,<Rn>,<Rm>
#  avail: Rn:4 Rd:4 Rm:4
# XXX note about 0x80000000/0xffffffff
return ctx.opSDIV({}, >Rd, <Rn, <Rm)
#: SEV<c>
#  avail: 
return ctx.opSEV({})
#: SEV<c>.W
#  avail: 
return ctx.opSEV({})
#: SMLAL<c> <RdLo>,<RdHi>,<Rn>,<Rm>
#  avail: Rn:4 RdLo:4 RdHi:4 Rm:4
return ctx.opSMLAL({}, >RdLo, >RdHi, <Rn, <Rm)
#: SMULL<c> <RdLo>,<RdHi>,<Rn>,<Rm>
#  avail: Rn:4 RdLo:4 RdHi:4 Rm:4
return ctx.opSMULL({}, >RdLo, >RdHi, <Rn, <Rm)
#: SSAT<c> <Rd>,#<imm5>,<Rn>{,<shift>}
#  avail: sh:1 Rn:4 imm3:3 Rd:4 imm2:2 sat_imm:5
if sh.bit and imm3 == b"000" and imm2 == b"00": break
return ctx.opSSAT({}, >Rd, <sat_imm, ctx.DIShift(<Rn, cat(sh, b"0"), cat(imm3, imm2)))
#: STC{L}<c> <coproc>,<CRd>,[<Rn>],<option>
#  avail: P:1 U:1 N:1 W:1 Rn:4 CRd:4 coproc:4 imm8:8
var D = N
if not P.bit and not U.bit and D.bit and not W.bit: break
if coproc[3,1] == b"101": break
return ctx.opSTC({}, <coproc, <CRd, ctx.Deref(>Rn, <cat(imm8, b"00"), 4, P.bit, W.bit, U.bit))
#: STC2{L}<c> <coproc>,<CRd>,[<Rn>],<option>
#  avail: P:1 U:1 N:1 W:1 Rn:4 CRd:4 coproc:4 imm8:8
var D = N
if not P.bit and not U.bit and D.bit and not W.bit: break
return ctx.opSTC(if D.bit: {ifSTCL} else: {}, <coproc, <CRd, ctx.Deref(>Rn, <cat(imm8, b"00"), 4, P.bit, W.bit, U.bit))
#: STM<c> <Rn>!,<registers>
#  avail: Rn:3 register_list:8
var rl = cat(b"00000000", register_list)
if rl[int(Rn)].bit:
    return ctx.opSTM({}, <Rn, ctx.RegList(rl))
else:
    return ctx.opSTMIA({}, >Rn, ctx.RegList(rl))
#: STM<c>.W <Rn>{!},<registers>
#  avail: W:1 Rn:4 M:1 register_list:13
if W.bit:
    return ctx.opSTMIA({}, >Rn, ctx.RegList(cat(b"0", M, b"0", register_list)))
else:
    return ctx.opSTM({}, <Rn, ctx.RegList(cat(b"0", M, b"0", register_list)))
#: STMDB<c> <Rn>{!},<registers>
#  avail: W:1 Rn:4 M:1 register_list:13
return ctx.opSTMDB({}, >Rn, ctx.RegList(cat(b"0", M, b"0", register_list)))
# XXX XXX 
# These are directly copied from LDR without checking the docs...
#: STR<c> <Rt>, [<Rn>{,#<imm5>}]
#  avail: imm5:5 Rn:3 Rt:3
return ctx.opSTR({}, <Rt, ctx.Deref(>Rn, <cat(imm5, b"00"), 4, true, false, true))
#: STR<c> <Rt>,[SP,#<imm8>]
#  avail: Rt:3 imm8:8
return ctx.opSTR({}, <Rt, ctx.Deref(>SP, <cat(imm8, b"00"), 4, true, false, true))
#: STR<c>.W <Rt>,[<Rn>,#<imm12>]
#  avail: Rn:4 Rt:4 imm12:12
if Rn == PC: break
return ctx.opSTR({}, <Rt, ctx.Deref(>Rn, <imm12, 4, true, false, true))
#: STR<c> <Rt>,[<Rn>,#+/-<imm8>]!
#  avail: Rn:4 Rt:4 P:1 U:1 W:1 imm8:8
if Rn == PC: break
if P.bit and U.bit and not W.bit: break
if Rn == SP and not P.bit and U.bit and W.bit and imm8 == b"00000100": break
if not P.bit and not W.bit: break
return ctx.opSTR({}, <Rt, ctx.Deref(>PC, <imm8, 4, P.bit, W.bit, U.bit))
#: STR<c> <Rt>,[<Rn>,<Rm>]
#  avail: Rm:3 Rn:3 Rt:3
return ctx.opSTR({}, <Rt, ctx.Deref(>Rn, <Rm, 4, true, false, true))
#: STR<c>.W <Rt>,[<Rn>,<Rm>{,LSL #<imm2>}]
#  avail: Rn:4 Rt:4 imm2:2 Rm:4
if Rn == PC: break
return ctx.opSTR({}, <Rt, ctx.Deref(>Rn, ctx.Shift(<Rm, LSL, <imm2), 4, true, false, true))
#: STRB<c> <Rt>,[<Rn>,#<imm5>]
#  avail: imm5:5 Rn:3 Rt:3
return ctx.opSTRB({}, <Rt, ctx.Deref(>Rn, <imm5, 1, true, false, true))
#: STRB<c>.W <Rt>,[<Rn>,#<imm12>]
#  avail: Rn:4 Rt:4 imm12:12
if Rt == PC or Rn == PC: break
return ctx.opSTRB({}, <Rt, ctx.Deref(>Rn, <imm12, 1, true, false, true))
#: STRB<c> <Rt>,[<Rn>,#+/-<imm8>]!
#  avail: Rn:4 Rt:4 P:1 U:1 W:1 imm8:8
if Rt == PC and (P.bit and not U.bit and not W.bit): break
if Rn == PC: break
if P.bit and U.bit and not W.bit: break
if not P.bit and not W.bit: break
return ctx.opSTRB({}, <Rt, ctx.Deref(>Rn, <imm8, 1, P.bit, W.bit, U.bit))
#: STRB<c> <Rt>,[<Rn>,<Rm>]
#  avail: Rm:3 Rn:3 Rt:3
return ctx.opSTRB({}, <Rt, ctx.Deref(>Rn, <Rm, 1, true, false, true))
#: STRB<c>.W <Rt>,[<Rn>,<Rm>{,LSL #<imm2>}]
#  avail: Rn:4 Rt:4 imm2:2 Rm:4
if Rt == PC or Rn == PC: break
return ctx.opSTRB({}, >Rt, ctx.Deref(>Rn, ctx.Shift(<Rm, LSL, <imm2), 1, true, false, true))
#: STRBT<c> <Rt>,[<Rn>,#<imm8>]
#  avail: Rn:4 Rt:4 imm8:8
if Rn == PC: break
return ctx.opSTRBT({}, <Rt, ctx.Deref(>Rn, <imm8, 1, true, false, true))
#: STRD<c> <Rt>,<Rt2>,[<Rn>,#+/-<imm8>]!
#  avail: P:1 U:1 W:1 Rn:4 Rt:4 Rt2:4 imm8:8
if not P.bit and not W.bit: break
if Rn == PC: break
return ctx.opSTRD({}, <Rt, <Rt2, ctx.Deref(>Rn, <cat(imm8, b"00"), 8, P.bit, W.bit, U.bit))
#: STREX<c> <Rd>,<Rt>,[<Rn>{,#<imm8>}]
#  avail: Rn:4 Rt:4 Rd:4 imm8:8
return ctx.opSTREX({}, <Rt, ctx.Deref(>Rn, <cat(imm8, b"00"), 4, true, false, true))
#: STREXB<c> <Rd>,<Rt>,[<Rn>]
#  avail: Rn:4 Rt:4 Rd:4
return ctx.opSTREXB({}, <Rt, ctx.Deref(>Rn, <0, 1, true, false, true))
#: STREXH<c> <Rd>,<Rt>,[<Rn>]
#  avail: Rn:4 Rt:4 Rd:4
return ctx.opSTREXH({}, <Rt, ctx.Deref(>Rn, <0, 2, true, false, true))
#: STRH<c> <Rt>,[<Rn>{,#<imm5>}]
#  avail: imm5:5 Rn:3 Rt:3
return ctx.opSTRH({}, <Rt, ctx.Deref(>Rn, <cat(imm5, b"0"), 2, true, false, true))
#: STRH<c>.W <Rt>,[<Rn>{,#<imm12>}]
#  avail: Rn:4 Rt:4 imm12:12
if Rt == PC or Rn == PC: break
return ctx.opSTRH({}, <Rt, ctx.Deref(>Rn, <imm12, 2, true, false, true))
#: STRH<c> <Rt>,[<Rn>,#+/-<imm8>]!
#  avail: Rn:4 Rt:4 P:1 U:1 W:1 imm8:8
if Rn == PC: break
if Rt == PC and (P.bit and not U.bit and not W.bit): break
if P.bit and U.bit and not W.bit: break
return ctx.opSTRH({}, <Rt, ctx.Deref(>Rn, <imm8, 2, P.bit, W.bit, U.bit))
#: STRH<c> <Rt>,[<Rn>,<Rm>]
#  avail: Rm:3 Rn:3 Rt:3
if Rt == PC: break
return ctx.opSTRH({}, <Rt, ctx.Deref(<Rn, <Rm, 2, true, false, true))
#: STRH<c>.W <Rt>,[<Rn>,<Rm>{,LSL #<imm2>}]
#  avail: Rn:4 Rt:4 imm2:2 Rm:4
if Rn == PC or Rt == PC: break
return ctx.opSTRH({}, <Rt, ctx.Deref(<Rn, ctx.Shift(<Rm, LSL, <imm2), 2, true, false, true))
#: STRHT<c> <Rt>,[<Rn>,#<imm8>]
#  avail: Rn:4 Rt:4 imm8:8
if Rn == PC: break
return ctx.opSTRHT({}, <Rt, ctx.Deref(<Rn, <imm8, 2, true, false, true))
#: STRT<c> <Rt>,[<Rn>,#<imm8>]
#  avail: Rn:4 Rt:4 imm8:8
if Rn == PC: break
return ctx.opSTRT({}, <Rt, ctx.Deref(<Rn, <imm8, 4, true, false, true))
#: SUB<c> <Rd>,<Rn>,#<imm3>
#  avail: imm3:3 Rn:3 Rd:3
return ctx.opSUB(t, >Rd, <Rn, <imm3)
#: SUB<c> <Rdn>,#<imm8>
#  avail: Rdn:3 imm8:8
return ctx.opSUB(t, >Rdn, <Rdn, <imm8)
#: SUB{S}<c>.W <Rd>,<Rn>,#<const>
#  avail: i:1 S:1 Rn:4 imm3:3 Rd:4 imm8:8
if Rd == PC and S == {ifS}: break
if Rn == SP: break
return ctx.opSUB(S, >Rd, <Rn, ctx.TEImm(cat(i, imm3, imm8)))
#: SUBW<c> <Rd>,<Rn>,#<imm12>
#  avail: i:1 Rn:4 imm3:3 Rd:4 imm8:8
if Rn == PC: break
if Rn == SP: break
return ctx.opSUB({}, >Rd, <Rn, <cat(i, imm3, imm8))
#: SUB<c> <Rd>,<Rn>,<Rm>
#  avail: Rm:3 Rn:3 Rd:3
return ctx.opSUB(t, >Rd, <Rn, <Rm)
#: SUB{S}<c>.W <Rd>,<Rn>,<Rm>{,<shift>}
#  avail: S:1 Rn:4 imm3:3 Rd:4 imm2:2 typ:2 Rm:4
if Rd == PC and S == {ifS}: break
if Rn == SP: break
return ctx.opSUB(S, >Rd, <Rn, ctx.DIShift(<Rm, typ, cat(imm3, imm2)))
#: SUB<c> SP,SP,#<imm7>
#  avail: imm7:7
return ctx.opSUB({}, >SP, <SP, <cat(imm7, b"00"))
#: SUB{S}<c>.W <Rd>,SP,#<const>
#  avail: i:1 S:1 imm3:3 Rd:4 imm8:8
return ctx.opSUB(S, >Rd, <SP, <cat(i, imm3, imm8))
#: SUBW<c> <Rd>,SP,#<imm12>
#  avail: i:1 imm3:3 Rd:4 imm8:8
return ctx.opSUB({}, >Rd, <SP, <cat(i, imm3, imm8))
#: SUB{S}<c> <Rd>,SP,<Rm>{,<shift>}
#  avail: S:1 imm3:3 Rd:4 imm2:2 typ:2 Rm:4
return ctx.opSUB(S, >Rd, <SP, ctx.DIShift(<Rm, typ, cat(imm3, imm2)))
#: SVC<c> #<imm8>
#  avail: imm8:8
return ctx.opSVC({}, <imm8)
#: SXTB<c> <Rd>,<Rm>
#  avail: Rm:3 Rd:3
return ctx.opSXTB({}, <Rd, <Rm)
#: SXTB<c>.W <Rd>,<Rm>{,<rotation>}
#  avail: Rd:4 rotate:2 Rm:4
return ctx.opSXTB({}, >Rd, ctx.Shift(<Rm, ROR, <cat(rotate, b"000")))
#: SXTH<c> <Rd>,<Rm>
#  avail: Rm:3 Rd:3
return ctx.opSXTH({}, >Rd, <Rm)
#: SXTH<c>.W <Rd>,<Rm>{,<rotation>}
#  avail: Rd:4 rotate:2 Rm:4
return ctx.opSXTH({}, >Rd, ctx.Shift(<Rm, ROR, <cat(rotate, b"000")))
#: TBH<c> [<Rn>,<Rm>,LSL #1]
#  avail: Rn:4 H:1 Rm:4
if H.bit:
    return ctx.opTBH({}, ctx.Deref(<Rn, ctx.Shift(<Rm, LSL, <1), 2, true, false, true))
else:
    return ctx.opTBB({}, ctx.Deref(<Rn, <Rm, 1, true, false, true))
#: TEQ<c> <Rn>,#<const>
#  avail: i:1 Rn:4 imm3:3 imm8:8
var r = ctx.TEImm_C(cat(i, imm3, imm8))
return ctx.opTEQ({ifS} + r.setCarry, <Rn, <r.ent)
#: TEQ<c> <Rn>,<Rm>{,<shift>}
#  avail: Rn:4 imm3:3 imm2:2 typ:2 Rm:4
return ctx.opTEQ({ifS}, <Rn, ctx.DIShift(<Rm, typ, cat(imm3, imm2)))
#: TST<c> <Rn>,#<const>
#  avail: i:1 Rn:4 imm3:3 imm8:8
var r = ctx.TEImm_C(cat(i, imm3, imm8))
return ctx.opTST({ifS} + r.setCarry, <Rn, <r.ent)
#: TST<c> <Rn>,<Rm>
#  avail: Rm:3 Rn:3
return ctx.opTST({ifS}, <Rn, <Rm)
#: TST<c>.W <Rn>,<Rm>{,<shift>}
#  avail: Rn:4 imm3:3 imm2:2 typ:2 Rm:4
return ctx.opTST({ifS}, <Rn, ctx.DIShift(<Rm, typ, cat(imm3, imm2)))
#: UBFX<c> <Rd>,<Rn>,#<lsb>,#<width>
#  avail: Rn:4 imm3:3 Rd:4 imm2:2 widthm1:5
return ctx.opUBFX({}, >Rd, <Rn, <cat(imm3, imm2), <(widthm1.num + 1))
#: UDIV<c> <Rd>,<Rn>,<Rm>
#  avail: Rn:4 Rd:4 Rm:4
return ctx.opUDIV({}, >Rd, <Rn, <Rm)
#: UMLAL<c> <RdLo>,<RdHi>,<Rn>,<Rm>
#  avail: Rn:4 RdLo:4 RdHi:4 Rm:4
return ctx.opUMLAL({}, >RdLo, >RdHi, <Rn, <Rm)
#: UMULL<c> <RdLo>,<RdHi>,<Rn>,<Rm>
#  avail: Rn:4 RdLo:4 RdHi:4 Rm:4
return ctx.opUMULL({}, >RdLo, >RdHi, <Rn, <Rm)
#: USAT<c> <Rd>,#<imm5>,<Rn>{,<shift>}
#  avail: sh:1 Rn:4 imm3:3 Rd:4 imm2:2 sat_imm:5
if sh.bit and imm3 == b"000" and imm2 == b"00": break
return ctx.opUSAT({}, >Rd, <sat_imm, ctx.DIShift(<Rn, cat(sh, b"0"), cat(imm3, imm2)))
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
#: done
