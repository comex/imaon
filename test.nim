import disas, os, parseutils, strutils, armtypes, types, stringAC, armfuncs

proc fooInsn(insn : pointer) : string =
    if insn == nil:
        return "Invalid"
    else:
        var a = cast[string](insn)
        GCunref(a)
        return a

var ctx = newPStringAsmCtx()
if true:
    var n : int
    discard parseHex(paramStr(1), n)
    var insn = ctx.processInsn32(Binary(n, 32), {})
    echo(fooInsn(insn))
#if true:
#    for i in 0..0xffff:
#        write(stdout, toHex(i, 4) & ": ")
#        var insn = ctx.processInsn16(Binary(i, 16), {})
#        echo(fooInsn(insn))
