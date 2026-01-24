{ config, pkgs, ... }:
{

  imports = [
    ./hardware-configuration.nix
  ];

  networking.hostName = "playgroundVM";

  # Nixfiles
  nixfiles = {
    enable = true;

    user = {
      name = "dan";
      displayName = "Dan Cîmpianu";
      homeDirectory = "/home/dan";
      uid = 1000;
      gid = 1000;

      # Enable auto-login, this is a VM.
      autoLogin = true;
    };

    desktop = {
      enable = true;
      monitors = {
        "HDMI-A-1" = {
          resolution = "2560x1440@144";
          position = "0x0";
          wallpaper = "bg_left.png";
          persistentWorkspaces = [
            4
            5
            6
          ];
        };
        "DP-1" = {
          resolution = "2560x1440@144";
          position = "2560x0";
          extraArgs = {
            vrr = "2";
          };
          wallpaper = "bg_center.png";
          persistentWorkspaces = [
            1
            2
            3
          ];
        };
        "DP-3" = {
          resolution = "2560x1440@144";
          position = "5120x0";
          wallpaper = "bg_right.png";
          persistentWorkspaces = [
            7
            8
            9
          ];
        };
      };
    };

    development = {
      enable = true;
      nixfiles.enable = true;
    };

    gaming.enable = true;

    programs = {
      defaultCli.enable = true;
      defaultGui.enable = true;
      cava.enable = true;
    };

    state = {
      homeManager = "23.11";
      system = "23.11";
    };
  };

  # Install system-wide packages.
  environment.systemPackages = with pkgs; [
    pciutils
    git
  ];

  users.users."${config.nixfiles.user.name}".packages = with pkgs; [
    evince
    kdePackages.filelight
    kdePackages.ark
    keepassxc
    pcmanfm
    vesktop
    viewnior
  ];

  # Stram Audio to Host
  services.pipewire.extraConfig.pipewire-pulse."30-network-stream-sender" = {
    "pulse.cmd" = [
      {
        cmd = "load-module";
        args = "module-tunnel-sink server=tcp:10.10.10.10:4713 reconnect_interval_ms=5000";
      }
    ];
  };
}
