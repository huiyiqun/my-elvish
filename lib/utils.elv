fn ok [f]{
    if ?(f) { true } else { false }
}

fn not [f]{
    if ($f) { false } else { true }
}

fn not-ok [f]{
    not { ok $f }
}

fn remove [list target]{
    for ele [$@list]  {
        if (not { eq $ele $target }) {
            put $ele
        }
    }
}

fn relative-path [parent child]{
    {parent, child}=(each path-abs [$parent $child])


    if (not { == (each count [$child $parent]) }) {
        if (not { has-suffix $parent / }) {
            parent = $parent/
        }
    }

    if (not { has-prefix $child $parent }) {
        fail (echo $child is not sub-directory of $parent)
    }

    try {
        put $child[(count $parent):]
    } except {
        put ''
    }
}

fn contain [list target]{
    not { ok {
        each [element]{
            if (is $element $target) {
                fail "equal"
            }
        } $list
    }}
}
