DOTFILES=$HOME/dev/repos/dotfiles/bash/
[ -f "$DOTFILES/setup.sh" ] && source $DOTFILES/setup.sh
[ -f "$DOTFILES/aliases.sh" ] && source $DOTFILES/aliases.sh
[ -f "$DOTFILES/functions.sh" ] && source $DOTFILES/functions.sh
[ -f "$DOTFILES/settings.sh" ] && source $DOTFILES/settings.sh
if [[ "$OSTYPE" == "darwin"* ]]; then
  [ -f "$DOTFILES/mac.sh" ] && source $DOTFILES/mac.sh
fi

if [[ "$MSYSTEM" == "MINGW64" ]] ; then
  [ -f "$DOTFILES/private-bash/init.sh" ] && source $DOTFILES/private-bash/init.sh
fi

[ -f "$DOTFILES/finalize.sh" ] && source $DOTFILES/finalize.sh








