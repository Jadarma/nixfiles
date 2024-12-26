{ pkgs, lib, config, nixfiles, ... }: {

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
    stateVersion = "24.11";

    # Extra apps and packages.
    packages = with pkgs; [
      evince
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

  # Stream Audio From Linux VM.
  xdg.configFile."pipewire/pipewire-pulse.conf.d/30-network-stream-receiver.conf".text = ''
    pulse.cmd = [
      { cmd = "load-module" args = "module-native-protocol-tcp port=4656 listen=10.10.10.10 auth-anonymous=true" }
    ]
  '';
}
