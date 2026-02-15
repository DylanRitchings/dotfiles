{ pkgs, ... }: {
  services.aerospace = {
    enable = true;
    settings = {
      # start-at-login managed by nix-darwin/launchd, not aerospace itself
      enable-normalization-flatten-containers = true;
      enable-normalization-opposite-orientation-for-nested-containers = true;
      
      # Automatically switch between macOS Spaces when switching workspaces
      automatically-unhide-macos-hidden-apps = false;
      
      # Use macOS native spaces instead of creating virtual workspaces
      # Map aerospace workspaces to macOS Mission Control spaces
      workspace-to-monitor-force-assignment = {
        "1" = 1;
        "2" = 1;
        "3" = 1;
        "4" = 1;
        "5" = 1;
        "6" = 1;
        "7" = 1;
        "8" = 1;
        "9" = 1;
      };

      # Callbacks to notify sketchybar
      exec-on-workspace-change = ["~/.config/sketchybar/plugins/aerospace_refresh.sh"];
      on-window-detected = ["~/.config/sketchybar/plugins/aerospace_refresh.sh"];

      # Keybindings
      mode.main.binding = {
        # Switch to workspace with Shift+Option+Control+num
        "shift-alt-ctrl-1" = "workspace 1";
        "shift-alt-ctrl-2" = "workspace 2";
        "shift-alt-ctrl-3" = "workspace 3";
        "shift-alt-ctrl-4" = "workspace 4";
        "shift-alt-ctrl-5" = "workspace 5";
        "shift-alt-ctrl-6" = "workspace 6";
        "shift-alt-ctrl-7" = "workspace 7";
        "shift-alt-ctrl-8" = "workspace 8";
        "shift-alt-ctrl-9" = "workspace 9";
        
        # Move focused window to workspace with Shift+Option+Control+Command+num
        "shift-alt-ctrl-cmd-1" = "move-node-to-workspace 1";
        "shift-alt-ctrl-cmd-2" = "move-node-to-workspace 2";
        "shift-alt-ctrl-cmd-3" = "move-node-to-workspace 3";
        "shift-alt-ctrl-cmd-4" = "move-node-to-workspace 4";
        "shift-alt-ctrl-cmd-5" = "move-node-to-workspace 5";
        "shift-alt-ctrl-cmd-6" = "move-node-to-workspace 6";
        "shift-alt-ctrl-cmd-7" = "move-node-to-workspace 7";
        "shift-alt-ctrl-cmd-8" = "move-node-to-workspace 8";
        "shift-alt-ctrl-cmd-9" = "move-node-to-workspace 9";
        
        # Focus windows
        "shift-alt-ctrl-h" = "focus left";
        "shift-alt-ctrl-l" = "focus right";
        "shift-alt-ctrl-j" = "focus down";
        "shift-alt-ctrl-k" = "focus up";
      };
    };
  };
}
