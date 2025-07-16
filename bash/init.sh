DOTFILES=$HOME/dev/repos/dotfiles
BASHFILES=$DOTFILES/bash
SCRIPTS=$BASHFILES/scripts

if [[ ":$PATH:" != *":$SCRIPTS:"* ]]; then
  export PATH="$SCRIPTS:$PATH"
fi

# [ -f "$BASHFILES/setup.sh" ] && source $BASHFILES/setup.sh
[ -f "$BASHFILES/aliases.sh" ] && source $BASHFILES/aliases.sh
[ -f "$BASHFILES/functions.sh" ] && source $BASHFILES/functions.sh
[ -f "$BASHFILES/settings.sh" ] && source $BASHFILES/settings.sh
if [[ "$OSTYPE" == "darwin"* ]]; then
  [ -f "$BASHFILES/mac.sh" ] && source $BASHFILES/mac.sh
fi

if [[ "$MSYSTEM" == "MINGW64" ]] || [[ "$MSYSTEM" == "UCRT64" ]]  || [[ "$MSYSTEM" == "MSYS" ]] ; then
  [ -f "$DOTFILES/private-bash/init.sh" ] && source $DOTFILES/private-bash/init.sh
fi

[ -f "$BASHFILES/finalize.sh" ] && source $BASHFILES/finalize.sh

