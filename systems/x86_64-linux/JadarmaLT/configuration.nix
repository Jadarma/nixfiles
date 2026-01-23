{ config, pkgs, ... }: {

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
    };

    desktop = {
      enable = true;
    };

    development = {
      enable = true;
      nixfiles.enable = true;
    };

    programs = {
      defaultCli.enable = true;
      defaultGui.enable = true;
    };

    state = {
      homeManager = "24.05";
      system = "24.05";
    };
  };

  # Enable auto-login.
  # This device uses full-disk encryption, a password was already required to boot it.
  # The second password of the single user is therefore just annoying.
  services.displayManager.autoLogin = {
    enable = true;
    user = config.nixfiles.user.name;
  };

  # Nixfiles -- Legacy
  nixfiles.nixos = {
    saneDefaults.enable = true;
    homelab = {
      enable = true;
      shares."/mnt/vault" = { dataset = "pool/vault"; };
    };
  };

  # User account.
  users.users.dan.extraGroups = [ "networkmanager" ];
  home-manager.users.dan = {

    # Extra apps and packages.
    home.packages = with pkgs; [
      evince
      kdePackages.ark
      keepassxc
      pcmanfm
      protonup-ng
      signal-desktop
      spotify
      vesktop
      viewnior
    ];

    nixfiles.home.desktop = {
      enable = true;
      monitors = {
        "eDP-1" = {
          resolution = "1920x1080@60";
          position = "0x0";
        };
      };
    };
  };
}
