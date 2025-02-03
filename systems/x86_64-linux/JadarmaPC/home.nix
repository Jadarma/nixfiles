{ pkgs, lib, config, nixfiles, ... }: {

  imports = [
    "${nixfiles}/modules/home/hyprland"
    "${nixfiles}/modules/home/scripts"
    "${nixfiles}/modules/home/theme"
    "${nixfiles}/modules/home/waybar"
    "${nixfiles}/modules/home/wofi"

    "${nixfiles}/modules2/home/nixos"
  ];

  home = {
    username = "dan";
    homeDirectory = "/home/dan";
    stateVersion = "24.11";

    # Extra apps and packages.
    packages = with pkgs; [
      android-studio
      evince
      jetbrains.idea-ultimate
      kdePackages.ark
      keepassxc
      pavucontrol
      pcmanfm
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
      alacritty.enable = true;
      cava.enable = true;
      firefox.enable = true;
      htop.enable = true;
      neofetch.enable = true;
      qalculate.enable = true;
      zathura.enable = true;
    };
  };

  wayland.windowManager.hyprland.settings = {
    monitor = lib.mkForce [
      "DP-1    ,2560x1440@144,0x0,1"
      "HDMI-A-1,2560x1440@144,2560x0,1"
      "DP-2    ,2560x1440@144,5120x0,1"
    ];

    workspace = [
      "4,monitor:DP-1,persistent:true"
      "5,monitor:DP-1,persistent:true"
      "6,monitor:DP-1,persistent:true"
      "1,monitor:HDMI-A-1,persistent:true"
      "2,monitor:HDMI-A-1,persistent:true"
      "3,monitor:HDMI-A-1,persistent:true"
      "7,monitor:DP-2,persistent:true"
      "8,monitor:DP-2,persistent:true"
      "9,monitor:DP-2,persistent:true"
    ];
  };

  services.hyprpaper.settings.wallpaper = lib.mkForce [
    "DP-1,${config.xdg.dataHome}/wallpapers/bg_left.png"
    "HDMI-A-1,${config.xdg.dataHome}/wallpapers/bg_center.png"
    "DP-2,${config.xdg.dataHome}/wallpapers/bg_right.png"
  ];
}
