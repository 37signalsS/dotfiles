function i --description "Interactively search for content and edit with nvim. Usage: fc [path]"
    set -l search_path "."
    if test -n "$argv[1]"
        set search_path $argv[1]
    end
    set -l rg_cmd "rg --line-number --no-heading --color=always . \"$search_path\" 2>/dev/null"

    # Use sudo for root search
    if test "$search_path" = "/"
        sudo -v
        set rg_cmd "sudo $rg_cmd"
    end

    set -l selection (eval $rg_cmd | fzf --ansi --delimiter ':' --preview 'bat --color=always --style=numbers --highlight-line {2} {1}' --preview-window 'up:60%:wrap')

    if test -n "$selection"
        set -l file (echo "$selection" | cut -d: -f1)
        set -l line (echo "$selection" | cut -d: -f2)

        if test -n "$file"
            xdg-open "$file"
        end
    else
        echo "No match selected"
    end
end
