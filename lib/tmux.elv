use utils

fn start {
    if (==s $E:TMUX '') {
        if (utils:ok { tmux ls }) {
            # There are existing sessions
            exec tmux attach
        } else {
            exec tmux
        }
    }
}
