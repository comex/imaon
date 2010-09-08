import disas, os, parseutils, strutils, armtypes, types, allAC, armfuncs

proc fooInsn(insn : string) : string =
    if insn == nil:
        return "Invalid"
    else:
        return insn

var ctx = newPStringAsmCtx()
var n : int
if paramStr(1) == "16":
    discard parseHex(paramStr(2), n)
    var insn = ctx.processInsn16(Binary(n, 16), {})
    echo(fooInsn(insn))
elif paramStr(1) == "32":
    discard parseHex(paramStr(2), n)
    var insn = ctx.processInsn32(Binary(n, 32), {})
    echo(fooInsn(insn))
elif paramStr(1) == "all16":
    for i in 0..0xffff:
        write(stdout, toHex(i, 4) & ": ")
        var insn = ctx.processInsn16(Binary(i, 16), {})
        echo(fooInsn(insn))
