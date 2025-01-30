
stow --target="$HOME" . -v --simulate
cd .config && stow --target="$HOME/AppData/Local" . 
# stow -t "$HOME" "zsh" --adopt

# chmod +x ~/dev/personal_repos/scripts/tmux-sessionizer



