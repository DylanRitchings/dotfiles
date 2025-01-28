# Fig pre block. Keep at the top of this file.
if [[ "$OSTYPE" == "darwin"* ]]; then

  fi
# Path to your oh-my-zsh installation.
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
export EDITOR=emacs
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


if [ -z "$TMUX" ]; then
    tmux
fi
# export AWS_VAULT_BACKEND="pass"
# export GPG_TTY="$( tty )"

workFolder="~/Work"

alias dev='cd ~/Dev/'
alias cdd='cd ~/Dev/'
alias work="cd $workFolder"
alias cdw="cd $workFolder"


alias roles='cat ~/.aws/config'

alias src="source"


alias gcane="git commit --amend --no-edit"


alias vim='emacsclient -t'
alias vi='emacsclient -t'

alias py="python3"
alias python="python3"
alias pip="pip3"

alias doom='~/.emacs.d/bin/doom'

alias glog="git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all"

function idea {
    intellij-idea-community $1 &
    }

function tfplansave {
    tfbuild $1 $2 plan -no-color | sed 's,\x1B\[[0-9;]*[a-zA-Z],,g' | tee -a $3"$(basename `git rev-parse --show-toplevel`)_Plan-$2.txt"
    }

function 'sudoe' {
  sudo screen -dm emacs $1
}

function e {
  emacs $1
    }
function ec {
  emacsclient -n $1
}

function cpr {
  blue=`tput setaf 6`

  repoName=$(basename `git rev-parse --show-toplevel`)
  currentBranch=$(git branch --show-current)
  prTitle="$1"

  output=$(aws-vault exec "TLG" -- \
    aws codecommit create-pull-request \
    --title $prTitle \
    --targets repositoryName=$repoName,sourceReference=$currentBranch)
  srcCommId=$(echo $output | jq -r '.pullRequest.pullRequestTargets[0].sourceCommit')
  destCommId=$(echo $output | jq -r '.pullRequest.pullRequestTargets[0].destinationCommit')

  git diff "$destCommId" "$srcCommId"
  prId=$(echo $output | jq -r '.pullRequest.pullRequestId')
  prUrl="https://eu-west-2.console.aws.amazon.com/codesuite/codecommit/repositories/"$repoName"/pull-requests/"$prId"/changes?region=eu-west-2"

  echo ${blue}$prUrl${reset}

}

function cclone {
  cd ~/Documents/Work/Repos
  repo="$1"
  if [ -d "$repo" ];
  then
    cd $repo
    git pull
  else
    git clone "https://git-codecommit.eu-west-2.amazonaws.com/v1/repos/${repo}"
    cd $repo
    pre-commit install
  fi
  cd terraform_src

}

# Emacs cd tracker
if [ -n "$INSIDE_EMACS" ]; then
  chpwd() { print -P "\033AnSiTc %d" }
  print -P "\033AnSiTu %n"
  print -P "\033AnSiTc %d"
fi

if [ -e /home/dylan/.nix-profile/etc/profile.d/nix.sh ]; then . /home/dylan/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer


if [ -d "$HOME/bin" ] ; then
  PATH="/home/dylan/terraform-lsp:$HOME/bin"
fi

export PATH="/home/dylan/.emacs.d/bin:$PATH"



export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion



# Fuzzy matching
zstyle ':completion:*' matcher-list '' \
  'm:{a-z\-}={A-Z\_}' \
  'r:[^[:alpha:]]||[[:alpha:]]=** r:|=* m:{a-z\-}={A-Z\_}' \
  'r:|?=** m:{a-z\-}={A-Z\_}'


if [[ "$OSTYPE" == "darwin"* ]]; then
  source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

DISABLE_MAGIC_FUNCTIONS=true

# neofetch
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"

# Work config
[ -f $HOME/.workrc ] && source $HOME/.workrc



# tmux has-session -t "notes" 2>/dev/null || (tmux new-session -d -s "notes" -c "$HOME" && tmux send-keys -t "notes" "cd ~/notes && nvim ." C-m)
#
# tmux new -A -s "terminal"
#
PATH="$PATH":"$HOME/dev/personal_repos/dotfiles/scripts/"
bindkey -s ^f "tmux-sessionizer\n"
bindkey -s ^s "window-split\n"

# function tm {
#   PROJECT_FOLDERS=(
#     "$HOME/dev/work_repos"
#     "$HOME/dev/personal_repos"
#     "$HOME/.config"
#   )
#
#   session_path=$(
#     find "${PROJECT_FOLDERS[@]}" -maxdepth 1 -mindepth 1 -type d |
#       fzf --height=50% --border --prompt="Select project: "
#   ) || exit
#
#   session_name=$(basename "$session_path")
#   tmux has-session -t "$session_name" 2>/dev/null || (
#     tmux new-session -d -s "$session_name" -c "$session_path"
#     tmux switch-client -t "$session_name"
#     tmux rename-window -t "$session_name":0 "vim"
#     tmux send-keys -t "$session_name":0 "cd $session_path && nvim ." C-m
#
#     tmux new-window -t "$session_name":1 -n "term"
#     tmux send-keys -t "$session_name":1 "cd $session_path" C-m
#   )
#   # tmux switch-client -t "$session_name"
#
#   # TODO
#   # TMUX startup:
#   #   create root sessions
#   #   create notes sessions
# }
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/dylan/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/dylan/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/dylan/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/dylan/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
