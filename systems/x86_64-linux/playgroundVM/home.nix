{ config, pkgs, lib, nixfiles, ... }: {

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

  # Stream the audio to the VM host.
  # As a reminder, the config for the host is:
  # xdg.configFile."pipewire/pipewire-pulse.conf.d/30-network-stream-receiver.conf".text = ''
  #   pulse.cmd = [
  #     { cmd = "load-module" args = "module-native-protocol-tcp port=4656 listen=10.10.10.10 auth-anonymous=true" }
  #   ]
  # ''
  xdg.configFile."pipewire/pipewire-pulse.conf.d/30-network-stream-sender.conf".text = ''
    pulse.cmd = [
      { cmd = "load-module" args = "module-tunnel-sink server=tcp:10.10.10.10:4656" }
    ]
  '';
}
