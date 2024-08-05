{ nixfiles, pkgs, config, ... }: {
  home = {
    username = "dan_vm";
    homeDirectory = "/home/dan_vm";
    stateVersion = "23.11";
  };

  xdg.enable = true;

  imports = [
    "${nixfiles}/modules/home/alacritty"
    "${nixfiles}/modules/home/bat"
    "${nixfiles}/modules/home/cava"
    "${nixfiles}/modules/home/eza"
    "${nixfiles}/modules/home/git"
    "${nixfiles}/modules/home/gpg"
    "${nixfiles}/modules/home/mako"
    "${nixfiles}/modules/home/neofetch"
    "${nixfiles}/modules/home/hyprland"
    "${nixfiles}/modules/home/jetbrains"
    "${nixfiles}/modules/home/qalculate"
    "${nixfiles}/modules/home/starship"
    "${nixfiles}/modules/home/theme"
    "${nixfiles}/modules/home/waybar"
    "${nixfiles}/modules/home/wofi"
    "${nixfiles}/modules/home/zsh"
  ];
}
