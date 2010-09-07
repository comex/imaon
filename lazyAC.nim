template beLazy*(TAsmCtx : typedesc, TVal : typedesc) =
    proc opADC*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp("ADC", flags, ents)
    proc opADD*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp("ADD", flags, ents)
    proc opADDW*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp("ADDW", flags, ents)
    proc opADR*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp("ADR", flags, ents)
    proc opAND*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp("AND", flags, ents)
    proc opASR*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp("ASR", flags, ents)
    proc opB*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp("B", flags, ents)
    proc opBFC*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp("BFC", flags, ents)
    proc opBFI*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp("BFI", flags, ents)
    proc opBIC*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp("BIC", flags, ents)
    proc opBKPT*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp("BKPT", flags, ents)
    proc opBL*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp("BL", flags, ents)
    proc opBLX*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp("BLX", flags, ents)
    proc opBX*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp("BX", flags, ents)
    proc opCBNZ*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp("CBNZ", flags, ents)
    proc opCBZ*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp("CBZ", flags, ents)
    proc opCDP*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp("CDP", flags, ents)
    proc opCDP2*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp("CDP2", flags, ents)
    proc opCLREX*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp("CLREX", flags, ents)
    proc opCLZ*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp("CLZ", flags, ents)
    proc opCMN*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp("CMN", flags, ents)
    proc opCMP*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp("CMP", flags, ents)
    proc opCPS*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp("CPS", flags, ents)
    proc opDBG*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp("DBG", flags, ents)
    proc opDMB*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp("DMB", flags, ents)
    proc opDSB*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp("DSB", flags, ents)
    proc opEOR*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp("EOR", flags, ents)
    proc opISB*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp("ISB", flags, ents)
    proc opIT*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp("IT", flags, ents)
    proc opLDC*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp("LDC", flags, ents)
    proc opLDC2*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp("LDC2", flags, ents)
    proc opLDM*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp("LDM", flags, ents)
    proc opLDMIA*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp("LDMIA", flags, ents)
    proc opLDMDB*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp("LDMDB", flags, ents)
    proc opLDR*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp("LDR", flags, ents)
    proc opLDRB*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp("LDRB", flags, ents)
    proc opLDRBT*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp("LDRBT", flags, ents)
    proc opLDRD*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp("LDRD", flags, ents)
    proc opLDREX*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp("LDREX", flags, ents)
    proc opLDREXB*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp("LDREXB", flags, ents)
    proc opLDREXH*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp("LDREXH", flags, ents)
    proc opLDRH*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp("LDRH", flags, ents)
    proc opLDRHT*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp("LDRHT", flags, ents)
    proc opLDRSB*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp("LDRSB", flags, ents)
    proc opLDRSBT*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp("LDRSBT", flags, ents)
    proc opLDRSH*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp("LDRSH", flags, ents)
    proc opLDRSHT*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp("LDRSHT", flags, ents)
    proc opLDRT*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp("LDRT", flags, ents)
    proc opLSL*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp("LSL", flags, ents)
    proc opLSR*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp("LSR", flags, ents)
    proc opMCR*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp("MCR", flags, ents)
    proc opMCR2*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp("MCR2", flags, ents)
    proc opMCRR*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp("MCRR", flags, ents)
    proc opMCRR2*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp("MCRR2", flags, ents)
    proc opMLA*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp("MLA", flags, ents)
    proc opMLS*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp("MLS", flags, ents)
    proc opMOV*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp("MOV", flags, ents)
    proc opMOVS*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp("MOVS", flags, ents)
    proc opMOVT*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp("MOVT", flags, ents)
    proc opMOVW*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp("MOVW", flags, ents)
    proc opMRC*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp("MRC", flags, ents)
    proc opMRC2*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp("MRC2", flags, ents)
    proc opMRRC*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp("MRRC", flags, ents)
    proc opMRRC2*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp("MRRC2", flags, ents)
    proc opMRS*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp("MRS", flags, ents)
    proc opMSR*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp("MSR", flags, ents)
    proc opMUL*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp("MUL", flags, ents)
    proc opMVN*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp("MVN", flags, ents)
    proc opNOP*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp("NOP", flags, ents)
    proc opORN*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp("ORN", flags, ents)
    proc opORR*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp("ORR", flags, ents)
    proc opPLD*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp("PLD", flags, ents)
    proc opPLI*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp("PLI", flags, ents)
    proc opPOP*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp("POP", flags, ents)
    proc opPUSH*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp("PUSH", flags, ents)
    proc opRBIT*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp("RBIT", flags, ents)
    proc opREV*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp("REV", flags, ents)
    proc opREV16*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp("REV16", flags, ents)
    proc opREVSH*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp("REVSH", flags, ents)
    proc opROR*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp("ROR", flags, ents)
    proc opRRX*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp("RRX", flags, ents)
    proc opRSB*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp("RSB", flags, ents)
    proc opSBC*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp("SBC", flags, ents)
    proc opSBFX*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp("SBFX", flags, ents)
    proc opSDIV*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp("SDIV", flags, ents)
    proc opSEV*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp("SEV", flags, ents)
    proc opSMLAL*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp("SMLAL", flags, ents)
    proc opSMULL*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp("SMULL", flags, ents)
    proc opSSAT*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp("SSAT", flags, ents)
    proc opSTC*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp("STC", flags, ents)
    proc opSTC2*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp("STC2", flags, ents)
    proc opSTM*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp("STM", flags, ents)
    proc opSTMIA*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp("STMIA", flags, ents)
    proc opSTMDB*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp("STMDB", flags, ents)
    proc opSTR*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp("STR", flags, ents)
    proc opSTRB*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp("STRB", flags, ents)
    proc opSTRBT*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp("STRBT", flags, ents)
    proc opSTRD*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp("STRD", flags, ents)
    proc opSTREX*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp("STREX", flags, ents)
    proc opSTREXB*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp("STREXB", flags, ents)
    proc opSTREXH*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp("STREXH", flags, ents)
    proc opSTRH*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp("STRH", flags, ents)
    proc opSTRHT*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp("STRHT", flags, ents)
    proc opSTRT*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp("STRT", flags, ents)
    proc opSUB*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp("SUB", flags, ents)
    proc opSUBW*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp("SUBW", flags, ents)
    proc opSVC*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp("SVC", flags, ents)
    proc opSXTB*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp("SXTB", flags, ents)
    proc opSXTH*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp("SXTH", flags, ents)
    proc opTBH*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp("TBH", flags, ents)
    proc opTEQ*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp("TEQ", flags, ents)
    proc opTST*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp("TST", flags, ents)
    proc opUBFX*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp("UBFX", flags, ents)
    proc opUDIV*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp("UDIV", flags, ents)
    proc opUMLAL*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp("UMLAL", flags, ents)
    proc opUMULL*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp("UMULL", flags, ents)
    proc opUSAT*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp("USAT", flags, ents)
    proc opUXTB*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp("UXTB", flags, ents)
    proc opUXTH*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp("UXTH", flags, ents)
    proc opWFE*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp("WFE", flags, ents)
    proc opWFI*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp("WFI", flags, ents)
    proc opYIELD*(ctx : TAsmCtx, flags : TInsnFlags, ents : openarray[TVal]) : TVal =
        return ctx.GenericOp("YIELD", flags, ents)
