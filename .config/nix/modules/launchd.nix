{ pkgs, config, ... }:
{
  launchd.user.agents.mbsync = {
    command = "${pkgs.isync}/bin/mbsync -c /Users/dylan/.config/isync/mbsyncrc -a";
    serviceConfig = {
      StartInterval = 300; # every 5 minutes
      KeepAlive = false;
    };
  };

  launchd.user.agents.protonmail-bridge = {
    command = "${pkgs.protonmail-bridge}/Applications/ProtonMail\ Bridge.app/Contents/MacOS/ProtonMail Bridge";
    serviceConfig = {
      RunAtLoad = true;
      KeepAlive = true;
    };
  };
}

