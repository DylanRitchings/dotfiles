{ pkgs, ... }: {
  services.aerospace = {
    enable = false;

    settings = {
      # start-at-login managed by nix-darwin/launchd, not aerospace itself
      enable-normalization-flatten-containers = true;
      enable-normalization-opposite-orientation-for-nested-containers = true;
      
      # Automatically switch between macOS Spaces when switching workspaces
      automatically-unhide-macos-hidden-apps = false;

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
        
        # Move window to next/prev monitor
        "shift-alt-ctrl-cmd-m" = "move-node-to-monitor --wrap-around next";
        
        # Focus windows
        "shift-alt-ctrl-h" = "focus left";
        "shift-alt-ctrl-l" = "focus right";
        "shift-alt-ctrl-j" = "focus down";
        "shift-alt-ctrl-k" = "focus up";
      };
    };
  };
}
