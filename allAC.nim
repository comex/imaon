# We don't want circular dependencies.

type TStringAsmCtx* = object
type PStringAsmCtx* = ref TStringAsmCtx

template foreachAC*(thetempl : expr) =
    thetempl(PStringAsmCtx, string, string)
