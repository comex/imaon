

macro z*(n : expr) : expr =
    result = newNimNode(nnkCall, n)
    result.add(newIdentNode("Insn"))
    result.add(n[1])#newIdentNode($n[1].ident))
    result.add(n[2])
    for i in 3..n.len - 1:
        var call = newNimNode(nnkCall)
        call.add(newIdentNode("@"))
        call.add(n[i])
        result.add(call)

#stuff that will have to be implemented by an AsmCtx:
#(for a literal context, TEnt can be a union of word and pointer
Imm(word) : TRVal
Reg(TReg) : TRVal
RegListA(set[TReg]) : TRVal
ShiftA(base : TRVal, kind : TShiftKind, amt : TRVal) : TVal
DerefA(base : TVal, offset : TRVal, size : TDerefSize, kind : TDerefKind)
Negate(TRVal)
IsZero(TRVal)

TRVal
    @@ -> TVal

TVal
    $$ => TRVal
