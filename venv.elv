use utils

fn deactivate {
    if !=s $E:_VIRTUALENV_CURRENT_PATH ""; then
        paths=(utils:remove $paths (utils:search $paths $E:_VIRTUALENV_CURRENT_PATH))
        del E:_VIRTUALENV_CURRENT_PATH
    fi

    if !=s $E:_VIRTUALENV_SAVED_PYTHONHOME ""; then
        E:PYTHONHOME=$E:_VIRTUALENV_SAVED_PYTHONHOME
        del E:_VIRTUALENV_SAVED_PYTHONHOME
    fi
}

fn activate [venv_path]{
    if utils:not-ok { test -x $venv_path/bin/python }; then
        echo "Error: $venv_path seems not a virtualenv" >&2
        return
    fi

    deactivate
    
    E:_VIRTUALENV_CURRENT_PATH=$pwd/$venv_path/bin/
    paths=[$E:_VIRTUALENV_CURRENT_PATH $@paths]

    E:_VIRTUALENV_SAVED_PYTHONHOME=$E:PYTHONHOME
    del E:PYTHONHOME
}
