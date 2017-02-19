fn ok [f]{
    try { $f; } except {
 false; }
}

fn not-ok [f]{
    if (ok $f) { false; }
}

fn not [f]{
    if ($f) { false; }
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
