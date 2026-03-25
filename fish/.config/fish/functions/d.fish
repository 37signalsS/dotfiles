function d
    sudo -v
    set -l selected_dir (sudo find / -type d 2>/dev/null | fzf)
    
    if test -n "$selected_dir"
        cd "$selected_dir"
    else
        echo "Directory not selected"
    end
end
