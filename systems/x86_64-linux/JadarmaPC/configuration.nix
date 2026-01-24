{ pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./vfio.nix
  ];

  networking.hostName = "JadarmaPC";

  # Nixfiles
  nixfiles = {
    enable = true;

    user = {
      name = "dan";
      displayName = "Dan Cîmpianu";
      homeDirectory = "/home/dan";
      uid = 1000;
      gid = 1000;

      # Enable auto-login, root drive is encrypted.
      autoLogin = true;

      # Extra apps and packages.
      packages = with pkgs; [
        evince
        kdePackages.ark
        keepassxc
        pcmanfm
        signal-desktop
        spotify
        vesktop
        viewnior
      ];
    };

    desktop = {
      enable = true;
      monitors = {
        "DP-1" = {
          resolution = "2560x1440@144";
          position = "0x0";
          persistentWorkspaces = [
            4
            5
            6
          ];
          wallpaper = "bg_left.png";
        };
        "HDMI-A-1" = {
          resolution = "2560x1440@144";
          position = "2560x0";
          persistentWorkspaces = [
            1
            2
            3
          ];
          wallpaper = "bg_center.png";
        };
        "DP-2" = {
          resolution = "2560x1440@144";
          position = "5120x0";
          persistentWorkspaces = [
            7
            8
            9
          ];
          wallpaper = "bg_right.png";
        };
      };
    };

    development = {
      enable = true;
      nixfiles.enable = true;
      jetbrains.idea.enable = true;
      jetbrains.android.enable = true;
    };

    programs = {
      defaultCli.enable = true;
      defaultGui.enable = true;
      cava.enable = true;
    };

    services = {
      homelab = {
        enable = true;
        shares."/mnt/vault" = {
          dataset = "pool/vault";
        };
      };
    };

    state = {
      homeManager = "24.11";
      system = "24.11";
    };
  };
}
