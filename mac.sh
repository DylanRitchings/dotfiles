mkdir -p ~/dev/{repos}
git clone https://github.com/DylanRitchings/dotfiles
git submodule update --remote --merge

stow --target="$HOME" . -v --simulate
cd .config && stow --target="$HOME/AppData/Local" . 
# stow -t "$HOME" "zsh" --adopt

# chmod +x ~/dev/personal_repos/scripts/tmux-sessionizer



