{ pkgs, nixfiles, ... }: {

  imports = [
    "${nixfiles}/modules/home/alacritty"
    "${nixfiles}/modules/home/bat"
    "${nixfiles}/modules/home/cava"
    "${nixfiles}/modules/home/direnv"
    "${nixfiles}/modules/home/eza"
    "${nixfiles}/modules/home/firefox"
    "${nixfiles}/modules/home/git"
    "${nixfiles}/modules/home/gpg"
    "${nixfiles}/modules/home/htop"
    "${nixfiles}/modules/home/mako"
    "${nixfiles}/modules/home/neofetch"
    "${nixfiles}/modules/home/hyprland"
    "${nixfiles}/modules/home/jetbrains"
    "${nixfiles}/modules/home/qalculate"
    "${nixfiles}/modules/home/scripts"
    "${nixfiles}/modules/home/starship"
    "${nixfiles}/modules/home/theme"
    "${nixfiles}/modules/home/waybar"
    "${nixfiles}/modules/home/wofi"
    "${nixfiles}/modules/home/xdg"
    "${nixfiles}/modules/home/zathura"
    "${nixfiles}/modules/home/zsh"
  ];

  home = {
    username = "dan";
    homeDirectory = "/home/dan";
    stateVersion = "24.05";

    # Extra apps and packages.
    packages = with pkgs; [
      evince
      kdePackages.ark
      keepassxc
      pavucontrol
      pcmanfm
      protonup-ng
      signal-desktop
      spotify
      vesktop
      viewnior
      qpwgraph
    ];
  };

  wayland.windowManager.hyprland.settings = {
    monitor = [
      "eDP-1,1920x1080@60,0x0,1"
    ];
  };
}
