use utils

fn deactivate {
    if (!=s $E:_VIRTUALENV_CURRENT_PATH "") {
        paths = [(utils:remove $paths $E:_VIRTUALENV_CURRENT_PATH)]
        del E:_VIRTUALENV_CURRENT_PATH
    }

    if (!=s $E:_VIRTUALENV_SAVED_PYTHONHOME "") {
        E:PYTHONHOME = $E:_VIRTUALENV_SAVED_PYTHONHOME
        del E:_VIRTUALENV_SAVED_PYTHONHOME
    }
}

fn activate [venv-path]{
    if (utils:not-ok { test -x $venv-path/bin/python }) {
        fail "Error: "$venv-path" seems not a virtualenv"
    }

    deactivate
    
    E:_VIRTUALENV_CURRENT_PATH = (path-abs $venv-path/bin)
    paths = [$E:_VIRTUALENV_CURRENT_PATH $@paths]

    E:_VIRTUALENV_SAVED_PYTHONHOME = $E:PYTHONHOME
    del E:PYTHONHOME
}

fn venv-path {
    if (utils:not { is $E:_VIRTUALENV_CURRENT_PATH "" }) {
        if (utils:contain $paths $E:_VIRTUALENV_CURRENT_PATH) {
            put $E:_VIRTUALENV_CURRENT_PATH
            return
        }
    }
    fail "Virtualenv is not activated"
}

fn venv-string {
    if (utils:ok { venv-path | each { } }) {
        print '' "(venv)" ''
    }
}

fn venv-string-with-path {
    where = 
    if (utils:ok { where = (venv-path)}) {
        print '' "(venv)" at (tilde-abbr $where) ''
    }
}
