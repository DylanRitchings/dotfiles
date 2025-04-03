{ pkgs, ... }: {


  environment.systemPackages = with pkgs; [
    neovim
    git
    zsh-syntax-highlighting
    sc-im
     
    #OS
    sketchybar
    # skhd = {
    #     enable = true;
    #   };
    # yabai = {
    #     enable = true;
    #   };
 
    #languages
    python3
    ansible
    terraform
    go

    #tools
    tmux
    jq
    just
    ripgrep
    stow

  ];
  environment.variables.EDITOR = "nvim";
  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = true; # Fetch the newest stable branch of Homebrew's git repo
      upgrade = true; # Upgrade outdated casks, formulae, and App Store apps
      cleanup = "zap";
    };

    # Applications to install from Mac App Store using mas.
    # You need to install all these Apps manually first so that your apple account have records for them.
    # otherwise Apple Store will refuse to install them.
    # For details, see https://github.com/mas-cli/mas 
    masApps = {
      Xcode = 497799835;

    };

    taps = [
      "homebrew/services"
    ];


    brews = [
    ];


    casks = [
      "alacritty"
      "librewolf"
      "obsidian"
      "syncthing"
      "shottr"

      "discord"
      "libreoffice"

      "jellyfin-media-player"
      "raycast" 

      "bitwarden"
      "steam"
      #creation
      

    ];
  };
}
