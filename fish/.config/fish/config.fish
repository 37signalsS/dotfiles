# Add global env
# set -Ux <name> "value"

if status is-interactive

set -g fish_greeting

alias n='nvim'

alias nv='sudo -Es nvim'

alias cd='z'

alias lg='lazygit'

alias rm='trash'

alias vpnon='sudo systemctl start tailscaled && sleep 3 && sudo tailscale up'

alias vpnoff='sudo tailscale down && sleep 3 && sudo systemctl stop tailscaled'

alias l='eza --tree --icons=always --long --git -a'

alias s='niri -c /home/q/laptop/niri/config.kdl && sudo systemctl stop bluetooth.service'

alias niri-sessions='sudo systemctl start bluetooth && niri-session'

alias codium='/usr/bin/codium --enable-features=UseOzonePlatform,WaylandWindowDecorations --ozone-platform=wayland $argv'

zoxide init fish | source

thefuck --alias | source

starship init fish | source

set -gx ATUIN_NOBIND "true"
atuin init fish | source
bind up _atuin_bind_up

end

set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH
set PATH $PATH /home/q/.local/bin
set PATH $PATH /home/q/.cargo/bin
set -gx PATH $PATH /home/q/.lmstudio/bin
