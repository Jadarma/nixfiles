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
      pcmanfm
      protonup-ng
      signal-desktop
      spotify
      vesktop
      viewnior
    ];
  };

  nixfiles.home = {
    cli.enable = true;
    development.enable = true;
    desktop = {
      enable = true;
      monitors = {
        "eDP-1" = {
          resolution = "1920x1080@60";
          position = "0x0";
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
