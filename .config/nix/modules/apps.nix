{ pkgs, ... }: {


  environment.systemPackages = with pkgs; [
    neovim
    git
    zsh-syntax-highlighting
    sc-im
     
    #OS
    syncthing
    sketchybar
    sketchybar-app-font
    skhd 
    yabai
    raycast
    # karabiner-elements
 
    #languages
    python3
    ansible
    terraform
    go

    #tools
    tmux
    jq
    fd
    just
    ripgrep
    stow

  ];
  services.sketchybar.enable = true;
  services.yabai.enable = true;
  services.skhd.enable = true;
  # services.syncthing.enable = true;
  # raycast.enable = true;
  # services.karabiner-elements.enable = true;
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
      "shottr"

      "discord"
      "libreoffice"

      "jellyfin-media-player"

      "bitwarden"
      "steam"
      "karabiner-elements"
      #creation
      

    ];
  };
}
