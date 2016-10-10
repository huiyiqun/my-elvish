use utils

fn start {
    if ==s $E:TMUX ''; then
        if utils:ok { tmux ls }; then
            # There are existing sessions
            exec tmux attach
        else
            exec tmux
        fi
    fi
}
