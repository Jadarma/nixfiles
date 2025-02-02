{ pkgs, nixfiles, ... }: {

  imports = [
    "${nixfiles}/modules/home/alacritty"
    "${nixfiles}/modules/home/cava"
    "${nixfiles}/modules/home/firefox"
    "${nixfiles}/modules/home/htop"
    "${nixfiles}/modules/home/mako"
    "${nixfiles}/modules/home/neofetch"
    "${nixfiles}/modules/home/hyprland"
    "${nixfiles}/modules/home/qalculate"
    "${nixfiles}/modules/home/scripts"
    "${nixfiles}/modules/home/theme"
    "${nixfiles}/modules/home/waybar"
    "${nixfiles}/modules/home/wofi"
    "${nixfiles}/modules/home/zathura"

    "${nixfiles}/modules2/home/nixos"
  ];

  nixfiles.home = {
    cli.enable = true;
    development.enable = true;
  };

  home = {
    username = "dan";
    homeDirectory = "/home/dan";
    stateVersion = "24.05";

    # Extra apps and packages.
    packages = with pkgs; [
      evince
      jetbrains.idea-ultimate
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
