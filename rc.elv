use tmux
tmux:start

# use bffi as the default completion in elvish
#le:completer['']={ bash ~/.elvish/get-completion.bash $@ }

# alias
fn ls { e:ls --color $@ }
fn grep { e:grep --color $@ }
fn yat { yaourt $@ }
fn up { yaourt -Syua --devel --noconfirm}
fn vim { nvim $@ }
fn svim { sudo nvim $@ }

# bind
le:binding[insert][Alt+Backspace]=kill-small-word-left
le:binding[insert][Ctrl+A]=move-dot-sol
le:binding[insert][Ctrl+E]=move-dot-eol
