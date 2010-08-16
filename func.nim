template map*(mstmt : expr, mlist : expr) : expr =
    block:
        var q = mlist
        var it : typeof[q[0]]
        var ret : seq[typeof[mstmt]] = @[]
        for it in q.items:
            ret.add(mstmt)
        ret

template filter*(mstmt : expr, mlist : expr) : expr =
    block:
        var q = mlist
        var it : typeof[q[0]]
        var ret : typeof[q] = @[]
        for it in q.items:
            if mstmt:
                ret.add(it)
        ret

