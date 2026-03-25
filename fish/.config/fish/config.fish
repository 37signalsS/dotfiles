# Add global env
# set -Ux <name> "value"

if status is-interactive

set -g fish_greeting

alias cd='z'

alias lg='lazygit'

alias vpnon='sudo systemctl start tailscaled.service && sleep 3 && sudo tailscale up'

alias vpnoff='sudo tailscale down && sleep 3 && sudo systemctl stop tailscaled.service'

alias l='eza --tree --icons=always --long --git -a'

alias s='niri -c /home/q/laptop/niri/config.kdl && sudo systemctl stop bluetooth.service'

alias niri-sessions='sudo systemctl start bluetooth.service && niri-session'

alias codium='/usr/bin/codium --enable-features=UseOzonePlatform,WaylandWindowDecorations --ozone-platform=wayland $argv'

zoxide init fish | source
starship init fish | source
atuin init fish | source

set -gx ATUIN_NOBIND "true"
bind up _atuin_bind_up

end

fish_add_path home/q/.bun/bin 
fish_add_path /home/q/.local/bin
fish_add_path /home/q/.cargo/bin
set -gx PATH $PATH /home/q/.lmstudio/bin
