{ nixfiles, pkgs, config, ... }: {
  home = {
    username = "dan_vm";
    homeDirectory = "/home/dan_vm";
    stateVersion = "23.11";
  };

  xdg.enable = true;

  imports = [
    "${nixfiles}/modules/home/git"
    "${nixfiles}/modules/home/gpg"
  ];
}
