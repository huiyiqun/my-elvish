fn start {
    if == $E:TMUX ''; then
        try
            exec tmux attach
        except
            exec tmux
        tried
    fi
}
