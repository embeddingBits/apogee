function fetch --wraps=fastfetch
    fastfetch -c ~/.config/fastfetch/small.jsonc --logo-color-1 blue --logo-color-2 red --logo ~/.config/fastfetch/custom.txt $argv
end

function ls --wraps=exa --wraps='exa --icons' --description 'alias ls exa --icons'
    eza $argv --icons
end

function nv --wraps=nvim --description 'alias nv nvim'
    nvim $argv
end

# Git commands
alias gt="git status"
alias gp="git push"
alias ga="git add"
alias gl="git log"
alias gc="git commit -m"
alias gu="git pull"

# Common Commands
alias j="z"
alias tree="ls --tree"
alias zb="zig build"
alias upfor="uptime -p"

# Pacman aliases (Arch)
alias pac="sudo pacman"
alias pacup="sudo pacman -Syu"
# AUR helper (uncomment if using yay/paru)
# alias xi="yay -S"
# alias xr="yay -Rns"
# alias xu="yay -Syu"

# Tmux aliases
alias tnew="tmux new -s"
alias tls="tmux ls"
alias ta="tmux attach -t"
alias td="tmux detach"

# Agents
alias oc="opencode"
alias oc-c="opencode --continue"
