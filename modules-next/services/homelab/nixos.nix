{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.nixfiles.services.homelab;
  nasmount = pkgs.writeShellApplication {
    name = "nasmount";
    text = (builtins.readFile ./nasmount.sh);
  };

  homelabconf = pkgs.writeShellApplication {
    name = "homelabconf";
    text = (builtins.readFile ./homelabconf.sh);
    runtimeInputs = with pkgs; [
      sshfs-fuse
      (vscode-with-extensions.override {
        vscode = vscodium;
        vscodeExtensions = with vscode-extensions; [
          tobiasalthoff.atom-material-theme
          vscode-icons-team.vscode-icons
          jnoortheen.nix-ide
          mkhl.direnv
          timonwong.shellcheck
          ethansk.restore-terminals
        ];
      })
    ];
  };

  homelabconfDesktop = pkgs.makeDesktopItem {
    name = "homelabconf-desktop";
    desktopName = "Homelab Conf";
    icon = "nix-snowflake";
    comment = "Open a code editor to edit the homelab's Nix configs via SSH.";
    categories = [ "Application" ];
    exec = "${homelabconf}/bin/homelabconf";
    terminal = false;
  };

  mkNasNfsShare =
    share: with share; {
      device = "${host}:/mnt/${dataset}";
      fsType = "nfs";
      options = [
        "nfsvers=${nfsVersion}"
        "proto=tcp"
        "_netdev"
        "noauto"
        "nofail"
        "x-systemd.automount"
        "x-systemd.idle-timeout=600"
        "defaults"
        "noatime"
        (if readOnly then "ro" else "rw")
      ];
    };
in
lib.mkIf cfg.enable {
  environment.systemPackages = [
    nasmount
    homelabconf
    homelabconfDesktop
  ];
  fileSystems = lib.mapAttrs (mountpoint: mkNasNfsShare) cfg.shares;
}
