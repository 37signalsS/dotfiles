function d
    sudo -v
    set -l selected_dir (sudo find / -type d 2>/dev/null | fzf --preview 'eza --tree -L 2 --icons=always -C {}' --preview-window=right:50%)
    
    if test -n "$selected_dir"
        cd "$selected_dir"
    else
        echo "Directory not selected"
    end
end
