import disas, os, parseutils, strutils, armtypes, types
if false:
    var n : int
    discard parseHex(paramStr(1), n)
    var insn = processInsn16(Binary(n, 16), 0)
    if insn == nil:
        echo("Invalid")
    else:
        echo($insn)
if true:
    for i in 0..0xffff:
        write(stdout, toHex(i, 4) & ": ")
        var insn = processInsn16(Binary(i, 16), 0)
        if insn == nil:
            echo("Invalid")
        else:
            echo($insn)

echo(9)
