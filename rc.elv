use tmux
tmux:start

# Todo: check existence of the dircolor file
use ls-color
ls-color:setup ~/Source/dircolors-solarized/dircolors.256dark

# use bffi as the default completion in elvish
#le:completer['']={ bash ~/.elvish/get-completion.bash $@ }

# alias
fn ls { e:ls --color=auto $@ }
fn grep { e:grep --color=auto $@ }
fn yat { yaourt $@ }
fn up { yaourt -Syua --devel --noconfirm}
fn vim { nvim $@ }
fn svim { sudo nvim $@ }

# bind
le:binding[insert][Alt+Backspace]=$le:&kill-small-word-left
le:binding[insert][Ctrl+A]=$le:&move-dot-sol
le:binding[insert][Ctrl+E]=$le:&move-dot-eol

# environments
E:GOPATH=~/go
