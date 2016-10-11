fn ok [f]{
    try $f; except; false; tried
}

fn not-ok [f]{
    if ok $f; then false; fi
}

fn search [list ele]{
    for idx in (range (count $list)); do
        if eq $ele $list[$idx]; then
            put $idx
        fi
    done
}

fn remove [list @indices]{
    # indices should be sorted and uniqed

    nindices=(count $indices)
    nlist=(count $list)

    # no element need to be deleted
    if == $nindices 0; then return; fi

    each {
        if >= $@ $nlist; then
            fail "invalid arguments"
        fi
    } $indices


    ret=$list[:$indices[0]]

    for idx in (range (- $nindices 1)); do
        next=$list[(+ $indices[$idx] 1):$indices[(+ $idx 1)]]
        ret=[$@ret $@next]
    done

    if != (+ $indices[-1] 1) $nlist; then
        tail=$list[(+ $indices[-1] 1):]
    else
        tail=[]
    fi

    put [$@ret $@tail]
}
