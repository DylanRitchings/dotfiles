export ZSH="$HOME/.config/oh-my-zsh"
export HISTFILE="$HOME/.config/zsh/zsh_history"

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
    zsh-vi-mode
)

source $ZSH/oh-my-zsh.sh

alias :q="exit"

alias cd="z"

alias trash="gio trash"
alias bin="gio trash"
alias pip="python -m pip"

eval "$(zoxide init zsh)"

# ------------ZSH fzf-tab ------------
# set descriptions format to enable group support
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# preview directory's content with exa when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'
# It specifies the key to trigger a continuous completion (accept the result and start another completion immediately). It's useful when completing a long path.
zstyle ':fzf-tab:*' continuous-trigger '/'
enable-fzf-tab

alias luamake="/home/dylan/software/lua-language-server/3rd/luamake/luamake"
alias lua-language-server="/home/dylan/software/lua-language-server/bin/lua-language-server"
