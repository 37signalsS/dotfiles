function rm
    if not isatty stdout
        command rm $argv
        return
    end

    if type -q kioclient5
        echo "→ KDE trash"
        kioclient5 move $argv trash:/
    else if type -q gio
        echo "→ GNOME trash"
        gio trash $argv
    else if type -q trash
        echo "→ trash-cli"
        trash $argv
    else
        echo "→ real rm"
        command rm $argv
    end
end
