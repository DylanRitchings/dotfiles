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
        outer.top = 28;  # Top padding for sketchybar
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

      # Notify sketchybar on window/workspace changes
      on-window-detected = ["sketchybar" "--trigger" "space_windows_change"];
      on-focused-monitor-changed = ["sketchybar" "--trigger" "space_changed"];
      on-workspace-changed = ["sketchybar" "--trigger" "space_changed"];
    };
  };
}
