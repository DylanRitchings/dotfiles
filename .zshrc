export ZSH="$HOME/.oh-my-zsh"
export PATH=/Users/dylan/Library/Python/3.12/bin:$PATH

ZSH_THEME="eastwood"

plugins=(
    fzf
    fzf-tab
    zsh-autosuggestions
    git
    colorize
    history
    aws
    web-search
    zsh-syntax-highlighting
    F-Sy-H
    #emacs
)

source $ZSH/oh-my-zsh.sh
export EDITOR=nvim
[ -f "~/dev/personal_repos/dotfiles/bash/init.sh" ] && source ~/dev/personal_repos/dotfiles/bash/init.sh
