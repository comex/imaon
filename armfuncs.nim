import armtypes
proc DIShift*(base : TEnt, typ, imm5 : TBinary) : TEnt =
    case int(typ.num)
    of 0b00:
        return Shift(base, LSL, @imm5)
    of 0b01:
        return Shift(base, LSR, @(if imm5.num == 0: 32 else: imm5.num))
    of 0b10:
        return Shift(base, ASR, @(if imm5.num == 0: 32 else: imm5.num))
    of 0b11:
        if imm5.num == 0:
            return Shift(base, RRX, @1)
        else:
            return Shift(base, ROR, @imm5)
    else: nil

proc TEImm_C*(imm12 : TBinary) : tuple[ent : TEnt, setCarry : int] =
    if imm12[11,10] == b"00":
        case int(imm12[9,8].num)
        of 0b00:
            result.ent = @zxt(imm12[7,0])
        of 0b01:
            result.ent = @cat(b"00000000", imm12[7,0], b"00000000", imm12[7,0])
        of 0b10:
            result.ent = @cat(imm12[7,0], b"00000000", imm12[7,0], b"00000000",)
        of 0b11:
            result.ent = @cat(imm12[7,0], imm12[7,0], imm12[7,0], imm12[7,0])
        else: nil
    else:
        var unrotated_value = zxt(cat(b"1", imm12[6,0]))
        var r = do_ror(unrotated_value, b2int(imm12[11,7]))
        result.ent = @r
        result.setCarry = if r[0].bit: 1 else: 0

proc TEImm*(imm12 : TBinary) : TEnt =
    return TEImm_C(imm12).ent
