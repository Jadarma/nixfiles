{ nixfiles, pkgs, config, ... }: {
  home = {
    username = "dan_vm";
    homeDirectory = "/home/dan_vm";
    stateVersion = "23.11";
  };

  xdg.enable = true;

  imports = [
    "${nixfiles}/modules/home/bat"
    "${nixfiles}/modules/home/git"
    "${nixfiles}/modules/home/gpg"
    "${nixfiles}/modules/home/starship"
    "${nixfiles}/modules/home/theme"
    "${nixfiles}/modules/home/zsh"
  ];
}
