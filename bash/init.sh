
[ -f "./setup.sh" ] && source ./setup.sh
[ -f "./aliases.sh" ] && source ./aliases.sh
[ -f "./functions.sh" ] && source ./functions.sh

if [[ "$OSTYPE" == "darwin"* ]]; then
  [ -f "./mac.sh" ] && source ./mac.sh
fi

if [[ "$MSYSTEM" == "MINGW64" ]] ; then
  [ -f "$HOME/dev/personal_repos/private-bash/private_aliases.sh" ] && source $HOME/dev/personal_repos/private-bash/private_aliases.sh
fi

[ -f "./finalize.sh" ] && source ./finalize.sh








