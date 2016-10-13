fn ok [f]{
    try $f; except; false; tried
}

fn not-ok [f]{
    if ok $f; then false; fi
}

fn not [f]{
    if $f; then false; fi
}

fn remove [list target]{
    for ele in $@list; do
        if not { eq $ele $target }; then
            put $ele
        fi
    done
}

fn relative-path [parent child]{
    {parent, child}=(each path-abs [$parent $child])


    if not { == (each count [$child $parent]) }; then
        if not { has-suffix $parent / }; then
            parent=$parent/
        fi
    fi

    if not { has-prefix $child $parent }; then
        fail (echo $child is not sub-directory of $parent)
    fi

    try
        put $child[(count $parent):]
    except
        put ''
    tried
}

fn contain [list target]{
    not { ok {
        each [element]{
            if is $element $target; then
                fail "equal"
            fi
        } $list
    }}
}
