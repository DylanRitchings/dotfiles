eval "$(/opt/homebrew/bin/brew shellenv)"
# >>> JVM installed by coursier >>>
export JAVA_HOME="/Users/dylan/Library/Caches/Coursier/arc/https/github.com/AdoptOpenJDK/openjdk8-binaries/releases/download/jdk8u292-b10/OpenJDK8U-jdk_x64_mac_hotspot_8u292b10.tar.gz/jdk8u292-b10/Contents/Home"
# <<< JVM installed by coursier <<<

# >>> coursier install directory >>>
export PATH="$PATH:/Users/dylan/Library/Application Support/Coursier/bin"
# <<< coursier install directory <<<
export PATH="/opt/homebrew/bin:$PATH"

export PATH=$PATH:~/.android-sdk-macosx/platform-tools/

[ -f "$HOME/dev/personal_repos/dotfiles/bash/init.sh" ] && source $HOME/dev/personal_repos/dotfiles/bash/init.sh

source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
