function f --description "Find a file with fzf and open it with xdg-open"
    set -l search_path $argv[1]
    if test -z "$search_path"
        set search_path ~
    end

    set -l find_cmd "find \"$search_path\" -type f 2>/dev/null"

    if test "$search_path" = "/"
        sudo -v
        set find_cmd "sudo $find_cmd"
    end

    set -l selected_file (eval $find_cmd | fzf --preview 'bat --color=always --style=numbers --line-range=:500 {}')

    if test -n "$selected_file"
        xdg-open "$selected_file" >/dev/null 2>&1 &
    else
        echo "File not selected"
    end
end
