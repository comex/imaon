ops = [
    "ADC",
    "ADD",
    "ADDW",
    "ADR",
    "AND",
    "ASR",
    "B",
    "BFC",
    "BFI",
    "BIC",
    "BKPT",
    "BL",
    "BLX",
    "BX",
    "CBNZ",
    "CBZ",
    "CDP",
    "CDP2",
    "CLREX",
    "CLZ",
    "CMN",
    "CMP",
    "CPS",
    "DBG",
    "DMB",
    "DSB",
    "EOR",
    "ISB",
    "IT",
    "LDC",
    "LDC2",
    "LDM",
    "LDMIA",
    "LDMDB",
    "LDR",
    "LDRB",
    "LDRBT",
    "LDRD",
    "LDREX",
    "LDREXB",
    "LDREXH",
    "LDRH",
    "LDRHT",
    "LDRSB",
    "LDRSBT",
    "LDRSH",
    "LDRSHT",
    "LDRT",
    "LSL",
    "LSR",
    "MCR",
    "MCR2",
    "MCRR",
    "MCRR2",
    "MLA",
    "MLS",
    "MOV",
    "MOVS",
    "MOVT",
    "MOVW",
    "MRC",
    "MRC2",
    "MRRC",
    "MRRC2",
    "MRS",
    "MSR",
    "MUL",
    "MVN",
    "NOP",
    "ORN",
    "ORR",
    "PLD",
    "PLI",
    "POP",
    "PUSH",
    "RBIT",
    "REV",
    "REV16",
    "REVSH",
    "ROR",
    "RRX",
    "RSB",
    "SBC",
    "SBFX",
    "SDIV",
    "SEV",
    "SMLAL",
    "SMULL",
    "SSAT",
    "STC",
    "STC2",
    "STM",
    "STMIA",
    "STMDB",
    "STR",
    "STRB",
    "STRBT",
    "STRD",
    "STREX",
    "STREXB",
    "STREXH",
    "STRH",
    "STRHT",
    "STRT",
    "SUB",
    "SUBW",
    "SVC",
    "SXTB",
    "SXTH",
    "TBH",
    "TEQ",
    "TST",
    "UBFX",
    "UDIV",
    "UMLAL",
    "UMULL",
    "USAT",
    "UXTB",
    "UXTH",
    "WFE",
    "WFI",
    "YIELD",
]

print 'template beLazy*(TAsmCtx : typedesc, TVal : typedesc) ='
for op in ops:
    print '    proc op%s*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =' % op
    print '        return ctx.GenericOp("%s", flags, ents)' % op