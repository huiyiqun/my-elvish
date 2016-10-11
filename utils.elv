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
