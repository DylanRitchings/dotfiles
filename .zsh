eval "$(/opt/homebrew/bin/brew shellenv)"
# >>> JVM installed by coursier >>>
export JAVA_HOME="/Users/dylan/Library/Caches/Coursier/arc/https/github.com/AdoptOpenJDK/openjdk8-binaries/releases/download/jdk8u292-b10/OpenJDK8U-jdk_x64_mac_hotspot_8u292b10.tar.gz/jdk8u292-b10/Contents/Home"
# <<< JVM installed by coursier <<<

# >>> coursier install directory >>>
export PATH="$PATH:/Users/dylan/Library/Application Support/Coursier/bin"
# <<< coursier install directory <<<
export PATH="/opt/homebrew/bin:$PATH"

export PATH=$PATH:~/.android-sdk-macosx/platform-tools/

[ -f "$HOME/dev/repos/dotfiles/bash/init.sh" ] && source $HOME/dev/repos/dotfiles/bash/init.sh

source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh


typeset -U path cdpath fpath manpath

for profile in ${(z)NIX_PROFILES}; do
  fpath+=($profile/share/zsh/site-functions $profile/share/zsh/$ZSH_VERSION/functions $profile/share/zsh/vendor-completions)
done

HELPDIR="/nix/store/6hf7mz56ghwfrnyknhplwmx39kg9gqmg-zsh-5.9/share/zsh/$ZSH_VERSION/help"





# Oh-My-Zsh/Prezto calls compinit during initialization,
# calling it twice causes slight start up slowdown
# as all $fpath entries will be traversed again.
autoload -U compinit && compinit

# History options should be set in .zshrc and after oh-my-zsh sourcing.
# See https://github.com/nix-community/home-manager/issues/177.
HISTSIZE="10000"
SAVEHIST="10000"

HISTFILE="$HOME/.zsh_history"
mkdir -p "$(dirname "$HISTFILE")"

setopt HIST_FCNTL_LOCK
unsetopt APPEND_HISTORY
setopt HIST_IGNORE_DUPS
unsetopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
unsetopt HIST_EXPIRE_DUPS_FIRST
setopt SHARE_HISTORY
unsetopt EXTENDED_HISTORY


export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/go/bin"

if [[ $TERM != "dumb" ]]; then
  eval "$(/etc/profiles/per-user/dylan/bin/starship init zsh)"
fi

if [[ $options[zle] = on ]]; then
  . /nix/store/3rzxyfr8ybsxx34rwlfc4zv70igcdj4r-skim-0.16.0/share/skim/completion.zsh
  . /nix/store/3rzxyfr8ybsxx34rwlfc4zv70igcdj4r-skim-0.16.0/share/skim/key-bindings.zsh
fi


# Aliases


# Named Directory Hashes




