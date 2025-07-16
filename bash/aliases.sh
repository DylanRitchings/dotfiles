
alias dev='cd ~/dev/'
alias cdd='cd ~/dev/'

alias vim='nvim'
alias vi='nvim'
alias nixsrc="(cd $DOTFILES/.config/nix && just rebuild_system)"

# alias py="python3"
# alias python="python3"
# alias pip="pip3"

# alias ask="ollama run deepseek-coder"

alias glog="git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all"
alias ga="git ls-files --others --exclude-standard | fzf -m --prompt=\"Select files to add: \" --layout=reverse-list | xargs -d '\n' git add"
