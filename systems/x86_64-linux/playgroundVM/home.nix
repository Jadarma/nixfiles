{ pkgs, ... }: {

  home = {
    username = "dan";
    homeDirectory = "/home/dan";
    stateVersion = "23.11";

    # Extra apps and packages.
    packages = with pkgs; [
      evince
      kdePackages.filelight
      kdePackages.ark
      keepassxc
      pcmanfm
      vesktop
      viewnior
    ];
  };

  nixfiles.home = {
    cli.enable = true;
    development.enable = true;
    gaming.enable = true;
    desktop = {
      enable = true;
      monitors = {
        "HDMI-A-1" = {
          resolution = "2560x1440@144";
          position = "0x0";
          wallpaper = "bg_left.png";
          persistentWorkspaces = [ 4 5 6 ];
        };
        "DP-1" = {
          resolution = "2560x1440@144";
          position = "2560x0";
          extraArgs = { vrr = "2"; };
          wallpaper = "bg_center.png";
          persistentWorkspaces = [ 1 2 3 ];
        };
        "DP-3" = {
          resolution = "2560x1440@144";
          position = "5120x0";
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
}
