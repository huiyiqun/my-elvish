fn ok [f]{
    try $f; except false; tried
}

fn not-ok [f]{
    if ok $f; then false; fi
}

fn search [list ele]{
    for idx in (range (count $list)); do
        if eq $ele $list[$idx]; then
            put $idx
            return
        fi
    done
}

fn remove [list index]{
    left=$list[:$index]
    right=$list[(+ $index 1):]
    put [$@left $@right]
}
