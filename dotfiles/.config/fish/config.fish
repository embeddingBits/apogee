set fish_greeting
starship init fish | source
set -x BAT_THEME gruvbox-dark
set -x EDITOR nvim
set -x TERMINAL kitty 

source ~/.config/fish/aliases.fish
export PATH="/home/ebits/.local/bin:$PATH"
zoxide init fish | source

# Prefer systemd's socket-activated agent; only start one if no live socket exists
if not set -q SSH_AUTH_SOCK; or not test -S "$SSH_AUTH_SOCK"
    if test -S "$XDG_RUNTIME_DIR/ssh-agent.socket"
        set -gx SSH_AUTH_SOCK "$XDG_RUNTIME_DIR/ssh-agent.socket"
    else
        eval (ssh-agent -c) > /dev/null
    end
end

set -Ux GOPATH $HOME/.local/go
set -Ux GOBIN  $HOME/.local/go/bin
fish_add_path  $GOBIN
