{ pkgs, ... }: {

  home = {
    username = "dan";
    homeDirectory = "/home/dan";
    stateVersion = "24.11";

    # Extra apps and packages.
    packages = with pkgs; [
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
    desktop = {
      enable = true;
      monitors = {
        "DP-1" = {
          resolution = "2560x1440@144";
          position = "0x0";
          persistentWorkspaces = [ 4 5 6 ];
          wallpaper = "bg_left.png";
        };
        "HDMI-A-1" = {
          resolution = "2560x1440@144";
          position = "2560x0";
          persistentWorkspaces = [ 1 2 3 ];
          wallpaper = "bg_center.png";
        };
        "DP-2" = {
          resolution = "2560x1440@144";
          position = "5120x0";
          persistentWorkspaces = [ 7 8 9 ];
          wallpaper = "bg_right.png";
        };
      };
    };
    development = {
      enable = true;
      android.enable = true;
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
}
