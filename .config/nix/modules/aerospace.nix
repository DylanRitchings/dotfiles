{ pkgs, ... }: {
  services.aerospace = {
    enable = true;
    settings = {
      # start-at-login managed by nix-darwin/launchd, not aerospace itself
      enable-normalization-flatten-containers = true;
      enable-normalization-opposite-orientation-for-nested-containers = true;
      
      gaps = {
        inner.horizontal = 10;
        inner.vertical = 10;
        outer.left = 10;
        outer.bottom = 10;
        outer.top = 70;  # Top padding for sketchybar
        outer.right = 10;
      };

      # Keybindings handled by karabiner
      mode.main.binding = {};
      
      # Workspace definitions (9 workspaces)
      workspace = [
        { workspace = 1; }
        { workspace = 2; }
        { workspace = 3; }
        { workspace = 4; }
        { workspace = 5; }
        { workspace = 6; }
        { workspace = 7; }
        { workspace = 8; }
        { workspace = 9; }
      ];

      # Hooks removed - configure sketchybar triggers manually if needed
    };
  };
}
