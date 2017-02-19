use utils

fn setup [config]{
    if (utils:ok { test -f $config }) {
        E:LS_COLORS = (sh -c 'eval $(dircolors '$config') && echo $LS_COLORS')
    } else {
        echo "Failed to config $LS_COLORS" >&2
    }
}
