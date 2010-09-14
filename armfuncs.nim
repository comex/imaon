import armtypes, types, funcs, allAC
include "ltgt"

template ctxspec(TAsmCtx : typedesc, TVal : typedesc, TRVal : typedesc) =
    proc DIShift*(ctx : TAsmCtx, base : TRVal, typ, imm5 : TBinary) : TRVal =
        case int(typ.num)
        of 0b00:
            return ctx.Shift(base, LSL, <imm5)
        of 0b01:
            return ctx.Shift(base, LSR, <(if imm5.num == 0: 32 else: imm5.num))
        of 0b10:
            return ctx.Shift(base, ASR, <(if imm5.num == 0: 32 else: imm5.num))
        of 0b11:
            if imm5.num == 0:
                return ctx.Shift(base, RRX, <1)
            else:
                return ctx.Shift(base, ROR, <imm5)
        else: nil

    proc TEImm_C*(ctx : TAsmCtx, imm12 : TBinary) : tuple[ent : TRVal, setCarry : TInsnFlags] =
        if imm12[11,10] == b"00":
            case int(imm12[9,8].num)
            of 0b00:
                result.ent = <zxt(imm12[7,0])
            of 0b01:
                result.ent = <cat(b"00000000", imm12[7,0], b"00000000", imm12[7,0])
            of 0b10:
                result.ent = <cat(imm12[7,0], b"00000000", imm12[7,0], b"00000000",)
            of 0b11:
                result.ent = <cat(imm12[7,0], imm12[7,0], imm12[7,0], imm12[7,0])
            else: nil
        else:
            var unrotated_value = zxt(cat(b"1", imm12[6,0]))
            var r = bROR(unrotated_value, imm12[11,7].num)
            result.ent = <r
            result.setCarry = if r[0].bit: {ifS} else: {}

    proc TEImm*[TAsmCtx](ctx : TAsmCtx, imm12 : TBinary) : TRVal =
        return ctx.TEImm_C(imm12).ent

foreachAC(ctxspec)
