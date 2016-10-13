use utils

fn deactivate {
    if !=s $E:_VIRTUALENV_CURRENT_PATH ""; then
        paths=[(utils:remove $paths $E:_VIRTUALENV_CURRENT_PATH)]
        del E:_VIRTUALENV_CURRENT_PATH
    fi

    if !=s $E:_VIRTUALENV_SAVED_PYTHONHOME ""; then
        E:PYTHONHOME=$E:_VIRTUALENV_SAVED_PYTHONHOME
        del E:_VIRTUALENV_SAVED_PYTHONHOME
    fi
}

fn activate [venv-path]{
    if utils:not-ok { test -x $venv-path/bin/python }; then
        fail "Error: "$venv-path" seems not a virtualenv"
    fi

    deactivate
    
    E:_VIRTUALENV_CURRENT_PATH=(path-abs $venv-path/bin)
    paths=[$E:_VIRTUALENV_CURRENT_PATH $@paths]

    E:_VIRTUALENV_SAVED_PYTHONHOME=$E:PYTHONHOME
    del E:PYTHONHOME
}

fn venv-path {
    if utils:not { is $E:_VIRTUALENV_CURRENT_PATH "" }; then
        if utils:contain $paths $E:_VIRTUALENV_CURRENT_PATH; then
            put $E:_VIRTUALENV_CURRENT_PATH
            return
        fi
    fi
    fail "Virtualenv is not activated"
}

fn venv-string {
    if utils:ok { venv-path | each { } }; then
        print '' "(venv)" ''
    fi
}

fn venv-string-with-path {
    where=
    if utils:ok { where=(venv-path) }; then
        print '' "(venv)" at (tilde-abbr $where) ''
    fi
}
