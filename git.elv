use utils

symbol-for=[&ahead=" " &behind=" " &diverged=":" &dirty=" " &none=" "]

fn git-dir {
    try
        path=(git rev-parse --git-dir 2>/dev/null)
    except
        fail "Not a git repositoryy"
    tried
    path-dir (path-abs $path)
}

fn is-touched {
    utils:not { utils:ok { git diff --no-ext-diff --quiet --exit-code } }
}

fn branch-name {
    try
        git symbolic-ref -q --short HEAD
    except
        git show-ref --head -s --abbrev | head -1
    tried
}

fn commit-count {
    try
        splits &sep="\t" (git rev-list --quiet --count --left-right "@{upstream}...HEAD" 2>/dev/null)
    except
        fail "We are currently not on a branch"
    tried
}

fn ahead {
    {commits-behind, commits-ahead}=(commit-count)

    if == $commits-behind 0; then
        if == $commits-ahead 0; then
            put none
        else
            put ahead
        fi
    else
        if == $commits-ahead 0; then
            put behind
        else
            put diverged
        fi
    fi
}

fn git-string {
    # This will fail when we are not in a git directory
    le:styled (tilde-abbr (git-dir)) 32

    put ' on '; le:styled (branch-name) 33; put ' '

    if is-touched; then
        put $symbol-for[dirty] ' '
    else
        try
            put $symbol-for[(ahead)] ' '
        except
        tried
    fi

    put '/'

    utils:relative-path (git-dir) $pwd

    put ' ~> '
}
