use tmux
tmux:start

# TODO: check existence of the dircolor file
use ls-color
ls-color:setup ~/Source/dircolors-solarized/dircolors.256dark

# use bffi as the default completion in elvish
#le:completer['']={ bash ~/.elvish/get-completion.bash $@ }

# alias
fn ls { e:ls --color=auto $@ }
fn grep { e:grep --color=auto $@ }
fn yat { yaourt $@ }
fn up { yaourt -Syua --devel --noconfirm}

# bind
le:binding[insert][Alt+Backspace]=$le:&kill-small-word-left
le:binding[insert][Ctrl+A]=$le:&move-dot-sol
le:binding[insert][Ctrl+E]=$le:&move-dot-eol

# environments
E:GOPATH=~/go
E:MANPAGER="nvim -u NORC -c 'set ft=man' -"

# prompt
use venv
default-rprompt=$le:rprompt
le:rprompt={ le:styled (venv:venv-string-with-path | slurp) 33; $default-rprompt }

use git
default-prompt=$le:prompt
le:prompt={
    try
        git:git-string
    except
        $default-prompt
    tried
}
