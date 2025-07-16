{config, pkgs, ...}: 
#
# let
#   gtk3Path = pkgs.gtk3.dev;
#   glibPath = pkgs.glib.dev;
# in
{
  # home.sessionVariables = {
  #   PKG_CONFIG_PATH = "${gtk3Path}/lib/pkgconfig:${glibPath}/lib/pkgconfig";
  # };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    oh-my-zsh.enable = false;

    antidote = {
      enable = true;
      plugins = [
        # "ohmyzsh/ohmyzsh path:plugins/git"
        "ohmyzsh/ohmyzsh path:plugins/colorize"
        "ohmyzsh/ohmyzsh path:plugins/history"
        "ohmyzsh/ohmyzsh path:plugins/aws"
        "ohmyzsh/ohmyzsh path:plugins/web-search"

        "zsh-users/zsh-autosuggestions"
        "zsh-users/zsh-syntax-highlighting"
        "Aloxaf/fzf-tab"
        "z-shell/F-Sy-H"
      ];

    };

    initContent = ''
      export PKG_CONFIG_PATH="/opt/homebrew/opt/gtk+3/lib/pkgconfig:/opt/homebrew/opt/glib/lib/pkgconfig:/opt/homebrew/lib/pkgconfig:/opt/homebrew/share/pkgconfig"
      # Plugin equivalents of "git", "colorize", etc. from Oh My Zsh
      autoload -Uz vcs_info
      precmd() { vcs_info }
      setopt prompt_subst
      PS1='%F{blue}%n@%m%f %F{cyan}%~%f $\{vcs_info_msg_0_}%# '
      # Homebrew
      eval "$(/opt/homebrew/bin/brew shellenv)"
      export PATH="/opt/homebrew/bin:$PATH"

      # Nix paths
      export PATH="$HOME/.nix-profile/bin:/nix/var/nix/profiles/default/bin:/run/current-system/sw/bin:$PATH"

      # Custom dotfiles init
      if [ -f "$HOME/dev/repos/dotfiles/bash/init.sh" ]; then
        source "$HOME/dev/repos/dotfiles/bash/init.sh"
      fi

      # Fix path-related arrays
      typeset -U path cdpath fpath manpath

      # Completion setup
      autoload -U compinit && compinit

      # History settings
      HISTSIZE=10000
      SAVEHIST=10000
      HISTFILE="$HOME/.config/.zsh_history"
      mkdir -p "$(dirname "$HISTFILE")"
      setopt HIST_FCNTL_LOCK
      unsetopt APPEND_HISTORY
      setopt HIST_IGNORE_DUPS
      unsetopt HIST_IGNORE_ALL_DUPS
      setopt HIST_IGNORE_SPACE
      unsetopt HIST_EXPIRE_DUPS_FIRST
      setopt SHARE_HISTORY
      unsetopt EXTENDED_HISTORY

      unalias ga 2>/dev/null

      # Extended PATHs
      export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/go/bin"
      export PATH="$PATH:$HOME/Library/Python/3.9/bin"

      export EDITOR=nvim
    '';
  };

}
