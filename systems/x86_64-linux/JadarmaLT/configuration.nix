{ pkgs, ... }:
{

  imports = [
    ./hardware-configuration.nix
  ];

  networking.hostName = "JadarmaLT";

  # Nixfiles
  nixfiles = {
    enable = true;

    user = {
      name = "dan";
      displayName = "Dan Cîmpianu";
      homeDirectory = "/home/dan";
      uid = 1000;
      gid = 1000;

      # Enable auto-login.
      # This device uses full-disk encryption, a password was already required to boot it.
      # The second password of the single user is therefore just annoying.
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
        "eDP-1" = {
          resolution = "1920x1080@60";
          position = "0x0";
        };
      };
    };

    development = {
      enable = true;
      nixfiles.enable = true;
    };

    programs = {
      defaultCli.enable = true;
      defaultGui.enable = true;
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
      homeManager = "24.05";
      system = "24.05";
    };
  };
}
