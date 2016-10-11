fn ok [f]{
    try $f
    except; false
    tried
}

fn not-ok [f]{
    try $f; false
    except
    tried
}

fn search [list ele]{
    for idx in (range (count $list)); do
        if eq $ele $list[$idx]; then
            put $idx
            return
        fi
    done
}
