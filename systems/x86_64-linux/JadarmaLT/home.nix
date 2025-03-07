{ pkgs, ... }: {

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
    monitor = [
      "eDP-1,1920x1080@60,0x0,1"
    ];
  };
}
