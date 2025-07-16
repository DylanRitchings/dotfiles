
{pkgs, ...}: {
  services.syncthing = {
    enable = true;
    # user = "dylan";
    # group = "dylan";
    # settings = {
    #   devices = {
    #     "Pixel 8" = { id = ""; };
    #   };
    # };

  };
}
