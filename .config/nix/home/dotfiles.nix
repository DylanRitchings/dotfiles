
{pkgs, ...}: {

  systemd.tmpfiles.settings = {
    "dev" = {
       "repos" = {d.mode = "0777";};
     };
  };

  home-manager.users.dylan = {
    userActivationScripts.home-setup.text = ''
      ${pkgs.git}/bin/git clone https://github.com/DylanRitchings/dotfiles ~/dev/repos/
    '';
  };
}
