{ pkgs, lib, nixfiles, ... }: {
  imports = [
    "${nixfiles}/modules/home/alacritty"
    "${nixfiles}/modules/home/bat"
    "${nixfiles}/modules/home/direnv"
    "${nixfiles}/modules/home/eza"
    "${nixfiles}/modules/home/git"
    "${nixfiles}/modules/home/gpg"
    "${nixfiles}/modules/home/scripts/nixfiles"
    "${nixfiles}/modules/home/starship"
    "${nixfiles}/modules/home/theme/colorScheme.nix"
    "${nixfiles}/modules/home/xdg"
    "${nixfiles}/modules/home/zsh"
  ];

  home = {
    username = "dan";
    homeDirectory = "/Users/dan";
    stateVersion = "24.11";
  };

  # TODO: Make this an automatic config in the gpg module.
  services.gpg-agent.pinentryPackage = lib.mkForce pkgs.pinentry_mac;
  xdg.userDirs.enable = lib.mkForce false;
  xdg.desktopEntries = lib.mkForce {};
}
