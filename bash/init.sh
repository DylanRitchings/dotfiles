DOTFILES=$HOME/dev/repos/dotfiles
BASHFILES=$DOTFILES/bash
SCRIPTS=$BASHFILES/scripts

if [[ ":$PATH:" != *":$SCRIPTS:"* ]]; then
  export PATH="$SCRIPTS:$PATH"
fi

if [[ "$MSYSTEM" == "MINGW64" ]] || [[ "$MSYSTEM" == "UCRT64" ]]  || [[ "$MSYSTEM" == "MSYS" ]] ; then
  source $BASHFILES/setup.sh
fi
source $BASHFILES/aliases.sh
source $BASHFILES/functions.sh
source $BASHFILES/settings.sh

# if [ -z "$TMUX" ]; then
#     tmux
# fi

if [[ "$OSTYPE" == "darwin"* ]]; then
  [ -f "$BASHFILES/mac.sh" ] && source $BASHFILES/mac.sh
fi

if [[ "$MSYSTEM" == "MINGW64" ]] || [[ "$MSYSTEM" == "UCRT64" ]]  || [[ "$MSYSTEM" == "MSYS" ]] ; then
  source $BASHFILES/private-bash/init.sh
fi

source $BASHFILES/finalize.sh

