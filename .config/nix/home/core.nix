{pkgs, ...}: {
  home.packages = with pkgs; [

    ripgrep 
    fzf 

  ];

  programs = {
    # modern vim
    neovim = {
      enable = true;
      defaultEditor = true;
      vimAlias = true;
    };

    # A modern replacement for ‘ls’
    # useful in bash/zsh prompt, not in nushell.


    # skim provides a single executable: sk.
    # Basically anywhere you would want to use grep, try sk instead.
    # skim = {
    #   enable = true;
    #   enableBashIntegration = true;
    # };
  };
}
