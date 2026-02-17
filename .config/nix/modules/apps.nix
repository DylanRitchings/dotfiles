{ pkgs, ... }: {


  environment.systemPackages = with pkgs; [
    neovim
    git
    #zsh-syntax-highlighting
    sc-im
    antidote
    # oh-my-zsh    
    # zsh-autosuggestions
    # zsh-syntax-highlighting
    # zsh-fzf-tab
    # zsh-f-sy-h 

    #OS
    syncthing
    sketchybar
    # sketchybar-app-font # TODO currently installed manually 
    # skhd 
    # yabai
    # karabiner-elements
 
    #languages
    python3
    pyenv
    ansible
    terraform
    terraform-ls
    sourcekit-lsp
    glib

    go

    #tools
    tmux
    jq
    fd
    just
    ripgrep
    stow
    immich-cli
    ranger
    # viu
    # nsxiv
    # xquartz
    tree
    tldr
    texlive.combined.scheme-full
    odin
    yt-dlp
    nodejs_24
    typescript
    typescript-language-server
    imagemagick
    exiftool

    #email
    isync
    msmtp
    neomutt
    wakeonlan
    btop
    presenterm
    # tailscale
    gcc-arm-embedded
    openocd
    dfu-util
    gnumake
    gh
    # aerospace
    ocaml
    opam
    dune_3
    wget
  ];

  services = {
    sketchybar.enable = true;
    # isync.enable = true;
    # msmtp.enable = true;

    # tailscale = {
    #   enable = true;
    # };
    # aerospace.enable = true; # Now configured in aerospace.nix
    # yabai = {
    #   enable = true;
    #   enableScriptingAddition = true; 
    # };
    # skhd.enable = true;
  };
  # services.raycast.enable = true;
  # services.sketchybar-app-font.enable = true;
  # services.zsh-syntax-highlighting.enable = true;

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
    
    caskArgs = {
        no_quarantine = true;
    };

    # Applications to install from Mac App Store using mas.
    # You need to install all these Apps manually first so that your apple account have records for them.
    # otherwise Apple Store will refuse to install them.
    # For details, see https://github.com/mas-cli/mas 
    masApps = {
      # Xcode = 497799835;

    };

    taps = [
      "homebrew/services"
      "localstack/tap"
      "krishkrosh/apps"
    ];


    brews = [
      "zsh-syntax-highlighting"
      "gtk+3"
      "cairo" 
      "pkg-config"
      "yt-dlp"
      "ffmpeg"
    ];


    casks = [
      "font-liberation"
      "alacritty"
      "librewolf"
      "brave-browser"
      "obsidian"
      "shottr" #TODO move to top?
      "syncthing-app"
      "spotify"

      "discord"
      "libreoffice"

      "jellyfin-media-player"
      # "localstack-cli"

      "bitwarden" #TODO move to top
      "steam"
      "karabiner-elements" #TODO move to top
      "menuwhere"
      "whatsapp"
      "raycast"
      "stats"
      "balenaetcher"
      "autodesk-fusion"
      "netdownloadhelpercoapp"
      "affinity-photo"
      "fx-cast-bridge"
      "orcaslicer"
      "electrum"
      "trackweight"
      "telegram"
      "tailscale-app"
      "openscad"
      "digiKam"
      "firefox"
      "proton-mail-bridge"
      "coconutbattery"
      "calibre"
      "scroll-reverser"

      "cardinal" # music rack
      "epic-games"
      "ableton-live-suite@11"
      "vlc"
      "transmission"
      "copilot-cli"
      # "amethyst"
    ];
  };
}





