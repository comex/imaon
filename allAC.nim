# We don't want to have to explicitly import every AC in clients
import lazyAC, types, strutils, armtypes
include "stringAC"
include "nullAC"

template foreachAC*(thetempl : expr) =
    thetempl(PStringAsmCtx, string, string)
    #thetempl(PNullAsmCtx, TNullVal, TNullRVal)
