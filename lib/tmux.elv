use utils

fn start {
    if (==s $E:TMUX '') {
        if ?(tmux ls) {
            # There are existing sessions
            exec tmux attach
        } else {
            exec tmux
        }
    }
}
