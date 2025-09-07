{ config, lib, pkgs, ... }:
let
  cfg = config.nixfiles.nixos.homelab;
  # Defines a lazy-mounted NFS Share on the homelab network.
  mkNasNfsShare =
    { dataset
    , host ? "nas"
    , nfsVersion ? "4.2"
    , readOnly ? false
    }: {
      device = "${host}:/mnt/${dataset}";
      fsType = "nfs";
      options = [
        "nfsvers=${nfsVersion}"
        "proto=tcp"
        "_netdev"
        "noatime"
        "noauto"
        "nofail"
        "defaults"
        (if readOnly then "ro" else "rw")
        "x-systemd.automount"
        "x-systemd.idle-timeout=600"
      ];
    };

  nasmount = pkgs.writeScriptBin "nasmount" (builtins.readFile ./nasmount.sh);
in
{
  options = {
    nixfiles.nixos.homelab.enable = lib.mkEnableOption "Enable connecting to the Homelab NFS shares.";
  };

  config = lib.mkIf cfg.enable {
    # TODO: Enable picking and choosing which shares to mount and where.
    fileSystems."/mnt/vault" = mkNasNfsShare { dataset = "pool/vault"; };

    environment.systemPackages = [ nasmount ];
  };
}
