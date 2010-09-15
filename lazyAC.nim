type TOpName* = enum
    opnADC,
    opnADD,
    opnADDW,
    opnADR,
    opnAND,
    opnASR,
    opnB,
    opnBFC,
    opnBFI,
    opnBIC,
    opnBKPT,
    opnBL,
    opnBLX,
    opnBX,
    opnCBNZ,
    opnCBZ,
    opnCDP,
    opnCDP2,
    opnCLREX,
    opnCLZ,
    opnCMN,
    opnCMP,
    opnCPS,
    opnDBG,
    opnDMB,
    opnDSB,
    opnEOR,
    opnISB,
    opnIT,
    opnLDC,
    opnLDC2,
    opnLDM,
    opnLDMIA,
    opnLDMDB,
    opnLDR,
    opnLDRB,
    opnLDRBT,
    opnLDRD,
    opnLDREX,
    opnLDREXB,
    opnLDREXH,
    opnLDRH,
    opnLDRHT,
    opnLDRSB,
    opnLDRSBT,
    opnLDRSH,
    opnLDRSHT,
    opnLDRT,
    opnLSL,
    opnLSR,
    opnMCR,
    opnMCR2,
    opnMCRR,
    opnMCRR2,
    opnMLA,
    opnMLS,
    opnMOV,
    opnMOVS,
    opnMOVT,
    opnMOVW,
    opnMRC,
    opnMRC2,
    opnMRRC,
    opnMRRC2,
    opnMRS,
    opnMSR,
    opnMUL,
    opnMVN,
    opnNOP,
    opnORN,
    opnORR,
    opnPLD,
    opnPLI,
    opnPOP,
    opnPUSH,
    opnRBIT,
    opnREV,
    opnREV16,
    opnREVSH,
    opnROR,
    opnRRX,
    opnRSB,
    opnSBC,
    opnSBFX,
    opnSDIV,
    opnSEV,
    opnSMLAL,
    opnSMULL,
    opnSSAT,
    opnSTC,
    opnSTC2,
    opnSTM,
    opnSTMIA,
    opnSTMDB,
    opnSTR,
    opnSTRB,
    opnSTRBT,
    opnSTRD,
    opnSTREX,
    opnSTREXB,
    opnSTREXH,
    opnSTRH,
    opnSTRHT,
    opnSTRT,
    opnSUB,
    opnSUBW,
    opnSVC,
    opnSXTB,
    opnSXTH,
    opnTBB,
    opnTBH,
    opnTEQ,
    opnTST,
    opnUBFX,
    opnUDIV,
    opnUMLAL,
    opnUMULL,
    opnUSAT,
    opnUXTB,
    opnUXTH,
    opnWFE,
    opnWFI,
    opnYIELD


template beLazy*(TAsmCtx : typedesc, TVal : typedesc) =
    proc opADC*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp(opnADC, "ADC", flags, ents)
    proc opADD*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp(opnADD, "ADD", flags, ents)
    proc opADDW*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp(opnADDW, "ADDW", flags, ents)
    proc opADR*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp(opnADR, "ADR", flags, ents)
    proc opAND*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp(opnAND, "AND", flags, ents)
    proc opASR*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp(opnASR, "ASR", flags, ents)
    proc opB*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp(opnB, "B", flags, ents)
    proc opBFC*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp(opnBFC, "BFC", flags, ents)
    proc opBFI*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp(opnBFI, "BFI", flags, ents)
    proc opBIC*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp(opnBIC, "BIC", flags, ents)
    proc opBKPT*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp(opnBKPT, "BKPT", flags, ents)
    proc opBL*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp(opnBL, "BL", flags, ents)
    proc opBLX*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp(opnBLX, "BLX", flags, ents)
    proc opBX*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp(opnBX, "BX", flags, ents)
    proc opCBNZ*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp(opnCBNZ, "CBNZ", flags, ents)
    proc opCBZ*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp(opnCBZ, "CBZ", flags, ents)
    proc opCDP*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp(opnCDP, "CDP", flags, ents)
    proc opCDP2*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp(opnCDP2, "CDP2", flags, ents)
    proc opCLREX*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp(opnCLREX, "CLREX", flags, ents)
    proc opCLZ*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp(opnCLZ, "CLZ", flags, ents)
    proc opCMN*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp(opnCMN, "CMN", flags, ents)
    proc opCMP*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp(opnCMP, "CMP", flags, ents)
    proc opCPS*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp(opnCPS, "CPS", flags, ents)
    proc opDBG*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp(opnDBG, "DBG", flags, ents)
    proc opDMB*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp(opnDMB, "DMB", flags, ents)
    proc opDSB*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp(opnDSB, "DSB", flags, ents)
    proc opEOR*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp(opnEOR, "EOR", flags, ents)
    proc opISB*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp(opnISB, "ISB", flags, ents)
    proc opIT*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp(opnIT, "IT", flags, ents)
    proc opLDC*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp(opnLDC, "LDC", flags, ents)
    proc opLDC2*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp(opnLDC2, "LDC2", flags, ents)
    proc opLDM*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp(opnLDM, "LDM", flags, ents)
    proc opLDMIA*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp(opnLDMIA, "LDMIA", flags, ents)
    proc opLDMDB*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp(opnLDMDB, "LDMDB", flags, ents)
    proc opLDR*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp(opnLDR, "LDR", flags, ents)
    proc opLDRB*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp(opnLDRB, "LDRB", flags, ents)
    proc opLDRBT*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp(opnLDRBT, "LDRBT", flags, ents)
    proc opLDRD*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp(opnLDRD, "LDRD", flags, ents)
    proc opLDREX*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp(opnLDREX, "LDREX", flags, ents)
    proc opLDREXB*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp(opnLDREXB, "LDREXB", flags, ents)
    proc opLDREXH*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp(opnLDREXH, "LDREXH", flags, ents)
    proc opLDRH*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp(opnLDRH, "LDRH", flags, ents)
    proc opLDRHT*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp(opnLDRHT, "LDRHT", flags, ents)
    proc opLDRSB*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp(opnLDRSB, "LDRSB", flags, ents)
    proc opLDRSBT*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp(opnLDRSBT, "LDRSBT", flags, ents)
    proc opLDRSH*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp(opnLDRSH, "LDRSH", flags, ents)
    proc opLDRSHT*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp(opnLDRSHT, "LDRSHT", flags, ents)
    proc opLDRT*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp(opnLDRT, "LDRT", flags, ents)
    proc opLSL*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp(opnLSL, "LSL", flags, ents)
    proc opLSR*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp(opnLSR, "LSR", flags, ents)
    proc opMCR*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp(opnMCR, "MCR", flags, ents)
    proc opMCR2*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp(opnMCR2, "MCR2", flags, ents)
    proc opMCRR*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp(opnMCRR, "MCRR", flags, ents)
    proc opMCRR2*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp(opnMCRR2, "MCRR2", flags, ents)
    proc opMLA*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp(opnMLA, "MLA", flags, ents)
    proc opMLS*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp(opnMLS, "MLS", flags, ents)
    proc opMOV*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp(opnMOV, "MOV", flags, ents)
    proc opMOVS*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp(opnMOVS, "MOVS", flags, ents)
    proc opMOVT*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp(opnMOVT, "MOVT", flags, ents)
    proc opMOVW*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp(opnMOVW, "MOVW", flags, ents)
    proc opMRC*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp(opnMRC, "MRC", flags, ents)
    proc opMRC2*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp(opnMRC2, "MRC2", flags, ents)
    proc opMRRC*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp(opnMRRC, "MRRC", flags, ents)
    proc opMRRC2*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp(opnMRRC2, "MRRC2", flags, ents)
    proc opMRS*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp(opnMRS, "MRS", flags, ents)
    proc opMSR*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp(opnMSR, "MSR", flags, ents)
    proc opMUL*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp(opnMUL, "MUL", flags, ents)
    proc opMVN*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp(opnMVN, "MVN", flags, ents)
    proc opNOP*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp(opnNOP, "NOP", flags, ents)
    proc opORN*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp(opnORN, "ORN", flags, ents)
    proc opORR*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp(opnORR, "ORR", flags, ents)
    proc opPLD*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp(opnPLD, "PLD", flags, ents)
    proc opPLI*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp(opnPLI, "PLI", flags, ents)
    proc opPOP*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp(opnPOP, "POP", flags, ents)
    proc opPUSH*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp(opnPUSH, "PUSH", flags, ents)
    proc opRBIT*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp(opnRBIT, "RBIT", flags, ents)
    proc opREV*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp(opnREV, "REV", flags, ents)
    proc opREV16*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp(opnREV16, "REV16", flags, ents)
    proc opREVSH*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp(opnREVSH, "REVSH", flags, ents)
    proc opROR*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp(opnROR, "ROR", flags, ents)
    proc opRRX*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp(opnRRX, "RRX", flags, ents)
    proc opRSB*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp(opnRSB, "RSB", flags, ents)
    proc opSBC*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp(opnSBC, "SBC", flags, ents)
    proc opSBFX*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp(opnSBFX, "SBFX", flags, ents)
    proc opSDIV*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp(opnSDIV, "SDIV", flags, ents)
    proc opSEV*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp(opnSEV, "SEV", flags, ents)
    proc opSMLAL*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp(opnSMLAL, "SMLAL", flags, ents)
    proc opSMULL*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp(opnSMULL, "SMULL", flags, ents)
    proc opSSAT*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp(opnSSAT, "SSAT", flags, ents)
    proc opSTC*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp(opnSTC, "STC", flags, ents)
    proc opSTC2*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp(opnSTC2, "STC2", flags, ents)
    proc opSTM*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp(opnSTM, "STM", flags, ents)
    proc opSTMIA*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp(opnSTMIA, "STMIA", flags, ents)
    proc opSTMDB*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp(opnSTMDB, "STMDB", flags, ents)
    proc opSTR*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp(opnSTR, "STR", flags, ents)
    proc opSTRB*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp(opnSTRB, "STRB", flags, ents)
    proc opSTRBT*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp(opnSTRBT, "STRBT", flags, ents)
    proc opSTRD*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp(opnSTRD, "STRD", flags, ents)
    proc opSTREX*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp(opnSTREX, "STREX", flags, ents)
    proc opSTREXB*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp(opnSTREXB, "STREXB", flags, ents)
    proc opSTREXH*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp(opnSTREXH, "STREXH", flags, ents)
    proc opSTRH*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp(opnSTRH, "STRH", flags, ents)
    proc opSTRHT*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp(opnSTRHT, "STRHT", flags, ents)
    proc opSTRT*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp(opnSTRT, "STRT", flags, ents)
    proc opSUB*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp(opnSUB, "SUB", flags, ents)
    proc opSUBW*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp(opnSUBW, "SUBW", flags, ents)
    proc opSVC*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp(opnSVC, "SVC", flags, ents)
    proc opSXTB*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp(opnSXTB, "SXTB", flags, ents)
    proc opSXTH*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp(opnSXTH, "SXTH", flags, ents)
    proc opTBB*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp(opnTBB, "TBB", flags, ents)
    proc opTBH*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp(opnTBH, "TBH", flags, ents)
    proc opTEQ*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp(opnTEQ, "TEQ", flags, ents)
    proc opTST*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp(opnTST, "TST", flags, ents)
    proc opUBFX*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp(opnUBFX, "UBFX", flags, ents)
    proc opUDIV*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp(opnUDIV, "UDIV", flags, ents)
    proc opUMLAL*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp(opnUMLAL, "UMLAL", flags, ents)
    proc opUMULL*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp(opnUMULL, "UMULL", flags, ents)
    proc opUSAT*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp(opnUSAT, "USAT", flags, ents)
    proc opUXTB*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp(opnUXTB, "UXTB", flags, ents)
    proc opUXTH*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp(opnUXTH, "UXTH", flags, ents)
    proc opWFE*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp(opnWFE, "WFE", flags, ents)
    proc opWFI*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp(opnWFI, "WFI", flags, ents)
    proc opYIELD*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp(opnYIELD, "YIELD", flags, ents)
