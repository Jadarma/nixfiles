{ config, pkgs, lib, ... }: {

  home = {
    username = "dan";
    homeDirectory = "/home/dan";
    stateVersion = "23.11";

    # Extra apps and packages.
    packages = with pkgs; [
      evince
      filelight
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

  nixfiles.home = {
    cli.enable = true;
    desktop.enable = true;
    development.enable = true;

    programs = {
      cava.enable = true;
      firefox.enable = true;
      ghostty.enable = true;
      htop.enable = true;
      neofetch.enable = true;
      qalculate.enable = true;
      zathura.enable = true;
    };
  };

  wayland.windowManager.hyprland.settings = {
    monitor = lib.mkForce [
      "HDMI-A-1,2560x1440@144,0x0,1"
      "DP-1,2560x1440@144,2560x0,1,vrr,2"
      "DP-3,2560x1440@144,5120x0,1"
    ];

    workspace = [
      "4,monitor:HDMI-A-1,persistent:true"
      "5,monitor:HDMI-A-1,persistent:true"
      "6,monitor:HDMI-A-1,persistent:true"
      "1,monitor:DP-1,persistent:true"
      "2,monitor:DP-1,persistent:true"
      "3,monitor:DP-1,persistent:true"
      "7,monitor:DP-3,persistent:true"
      "8,monitor:DP-3,persistent:true"
      "9,monitor:DP-3,persistent:true"
    ];
  };

  services.hyprpaper.settings.wallpaper = lib.mkForce [
    "HDMI-A-1,${config.xdg.dataHome}/wallpapers/bg_left.png"
    "DP-1,${config.xdg.dataHome}/wallpapers/bg_center.png"
    "DP-3,${config.xdg.dataHome}/wallpapers/bg_right.png"
  ];
}
