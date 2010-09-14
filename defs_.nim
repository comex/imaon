#: ADC{S}<c> <Rd>,<Rn>,#<const>
#  avail: i:1 S:1 Rn:4 imm3:3 Rd:4 imm8:8

#: ADC<c> <Rdn>,<Rm>
#  avail: Rm:3 Rdn:3

#: ADC{S}<c>.W <Rd>,<Rn>,<Rm>{,<shift>}
#  avail: S:1 Rn:4 imm3:3 Rd:4 imm2:2 typ:2 Rm:4

#: ADD<c> <Rd>,<Rn>,#<imm3>
#  avail: imm3:3 Rn:3 Rd:3

#: ADD<c> <Rdn>,#<imm8>
#  avail: Rdn:3 imm8:8

#: ADD{S}<c>.W <Rd>,<Rn>,#<const>
#  avail: i:1 S:1 Rn:4 imm3:3 Rd:4 imm8:8

#: ADDW<c> <Rd>,<Rn>,#<imm12>
#  avail: i:1 Rn:4 imm3:3 Rd:4 imm8:8

#: ADD<c> <Rd>,<Rn>,<Rm>
#  avail: Rm:3 Rn:3 Rd:3

#: ADD<c> <Rdn>,<Rm>
#  avail: DN:1 Rm:4 Rdn:3

#: ADD{S}<c>.W <Rd>,<Rn>,<Rm>{,<shift>}
#  avail: S:1 Rn:4 imm3:3 Rd:4 imm2:2 typ:2 Rm:4

#: ADD<c> <Rd>,SP,#<imm8>
#  avail: Rd:3 imm8:8

#: ADD<c> SP,SP,#<imm7>
#  avail: imm7:7

#: ADD{S}<c>.W <Rd>,SP,#<const>
#  avail: i:1 S:1 imm3:3 Rd:4 imm8:8

#: ADDW<c> <Rd>,SP,#<imm12>
#  avail: i:1 imm3:3 Rd:4 imm8:8

#: ADD<c> <Rdm>, SP, <Rdm>
#  avail: DM:1 Rdm:3

#: ADD<c> SP,<Rm>
#  avail: Rm:4

#: ADD{S}<c>.W <Rd>,SP,<Rm>{,<shift>}
#  avail: S:1 imm3:3 Rd:4 imm2:2 typ:2 Rm:4

#: ADR<c> <Rd>,<label>
#  avail: Rd:3 imm8:8

#: SUB <Rd>,PC,#0 Special case for zero offset
#  avail: i:1 imm3:3 Rd:4 imm8:8

#: ADR<c>.W <Rd>,<label> <label> after current instruction
#  avail: i:1 imm3:3 Rd:4 imm8:8

#: AND{S}<c> <Rd>,<Rn>,#<const>
#  avail: i:1 S:1 Rn:4 imm3:3 Rd:4 imm8:8

#: AND<c> <Rdn>,<Rm>
#  avail: Rm:3 Rdn:3

#: AND{S}<c>.W <Rd>,<Rn>,<Rm>{,<shift>}
#  avail: S:1 Rn:4 imm3:3 Rd:4 imm2:2 typ:2 Rm:4

#: ASR<c> <Rd>,<Rm>,#<imm5>
#  avail: imm5:5 Rm:3 Rd:3

#: ASR{S}<c>.W <Rd>,<Rm>,#<imm5>
#  avail: S:1 imm3:3 Rd:4 imm2:2 Rm:4

#: ASR<c> <Rdn>,<Rm>
#  avail: Rm:3 Rdn:3

#: ASR{S}<c>.W <Rd>,<Rn>,<Rm>
#  avail: S:1 Rn:4 Rd:4 Rm:4

#: B<c> <label>
#  avail: cond:4 imm8:8

#: B<c> <label>
#  avail: imm11:11

#: B<c>.W <label>
#  avail: S:1 cond:4 imm6:6 J1:1 J2:1 imm11:11

#: B<c>.W <label>
#  avail: S:1 imm10:10 J1:1 J2:1 imm11:11

#: BFC<c> <Rd>,#<lsb>,#<width>
#  avail: imm3:3 Rd:4 imm2:2 msb:5

#: BFI<c> <Rd>,<Rn>,#<lsb>,#<width>
#  avail: Rn:4 imm3:3 Rd:4 imm2:2 msb:5

#: BIC{S}<c> <Rd>,<Rn>,#<const>
#  avail: i:1 S:1 Rn:4 imm3:3 Rd:4 imm8:8

#: BIC<c> <Rdn>,<Rm>
#  avail: Rm:3 Rdn:3

#: BIC{S}<c>.W <Rd>,<Rn>,<Rm>{,<shift>}
#  avail: S:1 Rn:4 imm3:3 Rd:4 imm2:2 typ:2 Rm:4

#: BKPT #<imm8>
#  avail: imm8:8

#: BL<c> <label>
#  avail: S:1 imm10:10 J1:1 J2:1 imm11:11

#: BLX<c> <Rm>
#  avail: Rm:4

#: BX<c> <Rm>
#  avail: Rm:4

#: CB{N}Z <Rn>,<label>
#  avail: op:1 i:1 imm5:5 Rn:3

#: CDP<c> <coproc>,<opc1>,<CRd>,<CRn>,<CRm>,<opc2>
#  avail: opc1:4 CRn:4 CRd:4 coproc:4 opc2:3 CRm:4

#: CDP2<c> <coproc>,<opc1>,<CRd>,<CRn>,<CRm>,<opc2>
#  avail: opc1:4 CRn:4 CRd:4 coproc:4 opc2:3 CRm:4

#: CLREX<c>
#  avail: 

#: CLZ<c> <Rd>,<Rm>
#  avail: Rm:4 Rd:4 Rm_P:4

#: CMN<c> <Rn>,#<const>
#  avail: i:1 Rn:4 imm3:3 imm8:8

#: CMN<c> <Rn>,<Rm>
#  avail: Rm:3 Rn:3

#: CMN<c>.W <Rn>,<Rm>{,<shift>}
#  avail: Rn:4 imm3:3 imm2:2 typ:2 Rm:4

#: CMP<c> <Rn>,#<imm8>
#  avail: Rn:3 imm8:8

#: CMP<c>.W <Rn>,#<const>
#  avail: i:1 Rn:4 imm3:3 imm8:8

#: CMP<c> <Rn>,<Rm>
#  avail: Rm:3 Rn:3

#: CMP<c> <Rn>,<Rm>
#  avail: N:1 Rm:4 Rn:3

#: CMP<c>.W <Rn>, <Rm> {,<shift>}
#  avail: Rn:4 imm3:3 imm2:2 typ:2 Rm:4

#: CPS<effect> <iflags>
#  avail: im:1 I:1 F:1

#: DBG<c> #<option>
#  avail: option:4

#: DMB<c> #<option>
#  avail: option:4

#: DSB<c> #<option>
#  avail: option:4

#: EOR{S}<c> <Rd>,<Rn>,#<const>
#  avail: i:1 S:1 Rn:4 imm3:3 Rd:4 imm8:8

#: EOR<c> <Rdn>,<Rm>
#  avail: Rm:3 Rdn:3

#: EOR{S}<c>.W <Rd>,<Rn>,<Rm>{,<shift>}
#  avail: S:1 Rn:4 imm3:3 Rd:4 imm2:2 typ:2 Rm:4

#: ISB<c> #<option>
#  avail: option:4

#: IT{x{y{z}}} <firstcond>
#  avail: firstcond:4 mask:4

#: LDC{L}<c> <coproc>,<CRd>,[<Rn>],<option>
#  avail: P:1 U:1 D:1 W:1 Rn:4 CRd:4 coproc:4 imm8:8

#: LDC2{L}<c> <coproc>,<CRd>,[<Rn>],<option>
#  avail: P:1 U:1 D:1 W:1 Rn:4 CRd:4 coproc:4 imm8:8

#: LDC{L}<c> <coproc>,<CRd>,[PC,#-0] Special case LDC{L}<c> <coproc>,<CRd>,[PC],<option>
#  avail: P:1 U:1 D:1 W:1 CRd:4 coproc:4 imm8:8

#: LDC2{L}<c> <coproc>,<CRd>,[PC,#-0] Special case LDC{L}<c> <coproc>,<CRd>,[PC],<option>
#  avail: P:1 U:1 D:1 W:1 CRd:4 coproc:4 imm8:8

#: LDM<c> <Rn>,<registers> <Rn> included in <registers>
#  avail: Rn:3 register_list:8

#: LDM<c>.W <Rn>{!},<registers>
#  avail: W:1 Rn:4 P:1 M:1 register_list:13

#: LDMDB<c> <Rn>{!},<registers>
#  avail: W:1 Rn:4 P:1 M:1 register_list:13

#: LDR<c> <Rt>, [<Rn>{,#<imm5>}]
#  avail: imm5:5 Rn:3 Rt:3

#: LDR<c> <Rt>,[SP{,#<imm8>}]
#  avail: Rt:3 imm8:8

#: LDR<c>.W <Rt>,[<Rn>{,#<imm12>}]
#  avail: Rn:4 Rt:4 imm12:12

#: LDR<c> <Rt>,[<Rn>,#+/-<imm8>]!
#  avail: Rn:4 Rt:4 P:1 U:1 W:1 imm8:8

#: LDR<c> <Rt>,<label>
#  avail: Rt:3 imm8:8

#: LDR<c>.W <Rt>,[PC,#-0] Special case
#  avail: U:1 Rt:4 imm12:12

#: LDR<c> <Rt>,[<Rn>,<Rm>]
#  avail: Rm:3 Rn:3 Rt:3

#: LDR<c>.W <Rt>,[<Rn>,<Rm>{,LSL #<imm2>}]
#  avail: Rn:4 Rt:4 imm2:2 Rm:4

#: LDRB<c> <Rt>,[<Rn>{,#<imm5>}]
#  avail: imm5:5 Rn:3 Rt:3

#: LDRB<c>.W <Rt>,[<Rn>{,#<imm12>}]
#  avail: Rn:4 Rt:4 imm12:12

#: LDRB<c> <Rt>,[<Rn>,#+/-<imm8>]!
#  avail: Rn:4 Rt:4 P:1 U:1 W:1 imm8:8

#: LDRB<c> <Rt>,[PC,#-0] Special case
#  avail: U:1 Rt:4 imm12:12

#: LDRB<c> <Rt>,[<Rn>,<Rm>]
#  avail: Rm:3 Rn:3 Rt:3

#: LDRB<c>.W <Rt>,[<Rn>,<Rm>{,LSL #<imm2>}]
#  avail: Rn:4 Rt:4 imm2:2 Rm:4

#: LDRBT<c> <Rt>,[<Rn>,#<imm8>]
#  avail: Rn:4 Rt:4 imm8:8

#: LDRD<c> <Rt>,<Rt2>,[<Rn>,#+/-<imm8>]!
#  avail: P:1 U:1 W:1 Rn:4 Rt:4 Rt2:4 imm8:8

#: LDRD<c> <Rt>,<Rt2>,[PC,#-0] Special case
#  avail: P:1 U:1 Rt:4 Rt2:4 imm8:8

#: LDREX<c> <Rt>,[<Rn>{,#<imm8>}]
#  avail: Rn:4 Rt:4 imm8:8

#: LDREXB<c> <Rt>, [<Rn>]
#  avail: Rn:4 Rt:4

#: LDREXH<c> <Rt>, [<Rn>]
#  avail: Rn:4 Rt:4

#: LDRH<c> <Rt>,[<Rn>{,#<imm5>}]
#  avail: imm5:5 Rn:3 Rt:3

#: LDRH<c>.W <Rt>,[<Rn>{,#<imm12>}]
#  avail: Rn:4 Rt:4 imm12:12

#: LDRH<c> <Rt>,[<Rn>,#+/-<imm8>]!
#  avail: Rn:4 Rt:4 P:1 U:1 W:1 imm8:8

#: LDRH<c> <Rt>,[PC,#-0] Special case
#  avail: U:1 Rt:4 imm12:12

#: LDRH<c> <Rt>,[<Rn>,<Rm>]
#  avail: Rm:3 Rn:3 Rt:3

#: LDRH<c>.W <Rt>,[<Rn>,<Rm>{,LSL #<imm2>}]
#  avail: Rn:4 Rt:4 imm2:2 Rm:4

#: LDRHT<c> <Rt>,[<Rn>,#<imm8>]
#  avail: Rn:4 Rt:4 imm8:8

#: LDRSB<c> <Rt>,[<Rn>,#<imm12>]
#  avail: Rn:4 Rt:4 imm12:12

#: LDRSB<c> <Rt>,[<Rn>,#+/-<imm8>]!
#  avail: Rn:4 Rt:4 P:1 U:1 W:1 imm8:8

#: LDRSB<c> <Rt>,[PC,#-0] Special case
#  avail: U:1 Rt:4 imm12:12

#: LDRSB<c> <Rt>,[<Rn>,<Rm>]
#  avail: Rm:3 Rn:3 Rt:3

#: LDRSB<c>.W <Rt>,[<Rn>,<Rm>{,LSL #<imm2>}]
#  avail: Rn:4 Rt:4 imm2:2 Rm:4

#: LDRSBT<c> <Rt>,[<Rn>,#<imm8>]
#  avail: Rn:4 Rt:4 imm8:8

#: LDRSH<c> <Rt>,[<Rn>,#<imm12>]
#  avail: Rn:4 Rt:4 imm12:12

#: LDRSH<c> <Rt>,[<Rn>,#+/-<imm8>]!
#  avail: Rn:4 Rt:4 P:1 U:1 W:1 imm8:8

#: LDRSH<c> <Rt>,[PC,#-0] Special case
#  avail: U:1 Rt:4 imm12:12

#: LDRSH<c> <Rt>,[<Rn>,<Rm>]
#  avail: Rm:3 Rn:3 Rt:3

#: LDRSH<c>.W <Rt>,[<Rn>,<Rm>{,LSL #<imm2>}]
#  avail: Rn:4 Rt:4 imm2:2 Rm:4

#: LDRSHT<c> <Rt>,[<Rn>,#<imm8>]
#  avail: Rn:4 Rt:4 imm8:8

#: LDRT<c> <Rt>,[<Rn>,#<imm8>]
#  avail: Rn:4 Rt:4 imm8:8

#: LSL<c> <Rd>,<Rm>,#<imm5>
#  avail: imm5:5 Rm:3 Rd:3

#: LSL{S}<c>.W <Rd>,<Rm>,#<imm5>
#  avail: S:1 imm3:3 Rd:4 imm2:2 Rm:4

#: LSL<c> <Rdn>,<Rm>
#  avail: Rm:3 Rdn:3

#: LSL{S}<c>.W <Rd>,<Rn>,<Rm>
#  avail: S:1 Rn:4 Rd:4 Rm:4

#: LSR<c> <Rd>,<Rm>,#<imm5>
#  avail: imm5:5 Rm:3 Rd:3

#: LSR{S}<c>.W <Rd>,<Rm>,#<imm5>
#  avail: S:1 imm3:3 Rd:4 imm2:2 Rm:4

#: LSR<c> <Rdn>,<Rm>
#  avail: Rm:3 Rdn:3

#: LSR{S}<c>.W <Rd>,<Rn>,<Rm>
#  avail: S:1 Rn:4 Rd:4 Rm:4

#: MCR<c> <coproc>,<opc1>,<Rt>,<CRn>,<CRm>{,<opc2>}
#  avail: opc1:3 CRn:4 Rt:4 coproc:4 opc2:3 CRm:4

#: MCR2<c> <coproc>,<opc1>,<Rt>,<CRn>,<CRm>{,<opc2>}
#  avail: opc1:3 CRn:4 Rt:4 coproc:4 opc2:3 CRm:4

#: MCRR<c> <coproc>,<opc1>,<Rt>,<Rt2>,<CRm>
#  avail: Rt2:4 Rt:4 coproc:4 opc1:4 CRm:4

#: MCRR2<c> <coproc>,<opc1>,<Rt>,<Rt2>,<CRm>
#  avail: Rt2:4 Rt:4 coproc:4 opc1:4 CRm:4

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

#: UXTB<c>.W <Rd>,<Rm>{,<rotation>}
#  avail: Rd:4 rotate:2 Rm:4

#: UXTH<c> <Rd>,<Rm>
#  avail: Rm:3 Rd:3

#: UXTH<c>.W <Rd>,<Rm>{,<rotation>}
#  avail: Rd:4 rotate:2 Rm:4

#: WFE<c>
#  avail: 

#: WFE<c>.W
#  avail: 

#: WFI<c>
#  avail: 

#: WFI<c>.W
#  avail: 

#: YIELD<c>
#  avail: 

#: YIELD<c>.W
#  avail: 

#: CPS<effect> <iflags>
#  avail: im:1 I:1 F:1

#: MRS<c> <Rd>,<spec_reg>
#  avail: Rd:4 SYSm:8

#: MSR<c> <spec_reg>,<Rn>
#  avail: Rn:4 SYSm:8

#: done
