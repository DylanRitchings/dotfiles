
[ -f "./setup.sh" ] && source ./setup.sh
[ -f "./aliases.sh" ] && source ./aliases.sh
[ -f "./functions.sh" ] && source ./functions.sh

if [[ "$OSTYPE" == "darwin"* ]]; then
  [ -f "./mac.sh" ] && source ./mac.sh
fi

if [[ "$MSYSTEM" == "MINGW64" ]] ; then
  [ -f "./private-bash/init.sh" ] && source ./private-bash/init.sh
fi

[ -f "./finalize.sh" ] && source ./finalize.sh








