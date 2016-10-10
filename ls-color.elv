use utils

fn setup [config]{
    if utils:ok { test -f $config }; then
        E:LS_COLORS=[(splits &sep="'" (dircolors $config | head -1))][1]
    else
        echo [WARNING] No such file: $config
    fi
}
