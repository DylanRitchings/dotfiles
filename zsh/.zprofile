# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

# User specific environment and startup programs
export PATH=$PATH:$HOME/dev/scripts
export EDITOR="nvim"
export BROWSER="firefox"
export TERMINAL="alacritty"

if [[ "$(tty)" = "/dev/tty1" ]]; then
	sway
fi

syncthing
