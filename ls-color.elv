use utils

fn setup [config]{
    if utils:ok { test -f $config }; then
        E:LS_COLORS=(sh -c 'eval $(dircolors '$config') && echo $LS_COLORS')
    else
        echo [WARNING] No such file: $config
    fi
}
