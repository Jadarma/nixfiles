{ lib, pkgs, ... }: {

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
    development.enable = true;
    desktop = {
      enable = true;
      monitors = {
        "HDMI-A-1" = {
          wallpaper = "bg_left.png";
          persistentWorkspaces = [ 4 5 6 ];
        };
        "DP-1" = {
          wallpaper = "bg_center.png";
          persistentWorkspaces = [ 1 2 3 ];
        };
        "DP-3" = {
          wallpaper = "bg_right.png";
          persistentWorkspaces = [ 7 8 9 ];
        };
      };
    };

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
  };
}
