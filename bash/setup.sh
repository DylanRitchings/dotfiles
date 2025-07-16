export ZSH="$HOME/.config/oh-my-zsh"
export PATH=/Users/dylan/Library/Python/3.12/bin:$PATH

zstyle ':completion:*' audit 'no'

# # If ZSH is not defined, use the current script's directory.
# [[ -z "$ZSH" ]] && export ZSH=$HOME/.config/zsh/
#
# # Set ZSH_CACHE_DIR to the path where cache files should be created
# # or else we will use the default cache/
# if [[ -z "$ZSH_CACHE_DIR" ]]; then
#   ZSH_CACHE_DIR="$ZSH/cache"
# fi
# fpath=("$ZSH/functions" "$ZSH/completions" $fpath)
# autoload -U compaudit compinit zrecompile
#
# # Skip the compaudit security check (can speed up the process)
#
# antidote bundle <$ZSH_CUSTOM/.zsh_plugins.txt >$ZSH_CUSTOM/.zsh_plugins.zsh
# source $ZSH_CUSTOM/.zsh_plugins.zsh
# [[ -z "$LS_COLORS" ]] || zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

ZSH_THEME="eastwood"
plugins=(
    fzf
    fzf-tab
    zsh-autosuggestions
    zsh-syntax-highlighting
    # git
    colorize
    history
    # aws
    web-search
    F-Sy-H
    #emacs
)


source $ZSH/oh-my-zsh.sh
export EDITOR=nvim
export DISPLAY=:0
