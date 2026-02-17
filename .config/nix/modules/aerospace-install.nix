{ pkgs, ... }:
{
  system.activationScripts.installAero = {
    text = ''
      echo "Ensuring latest AeroSpace is installed via Homebrew cask..."
      if [ ! -d /Applications/AeroSpace.app ]; then
        if command -v brew >/dev/null 2>&1; then
          echo "Installing AeroSpace cask via Homebrew"
          brew tap nikitabobko/tap || true
          brew install --cask nikitabobko/tap/aerospace || true
        else
          echo "Homebrew not found - please install Homebrew or install AeroSpace manually"
        fi
      else
        echo "/Applications/AeroSpace.app already present, skipping"
      fi
    '';
  };
}
