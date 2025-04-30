{ config, lib, ... }:
let
  cfg = config.nixfiles.nixos.homelab.nfs;

  # Defines a lazy-mounted NFS Share on the homelab network.
  mkNfsShare = { name, readOnly ? false }: {
    device = "truenas:/mnt/ironwolf/${name}";
    fsType = "nfs4";
    options = [
      "defaults"
      "tcp"
      (if readOnly then "ro" else "rw")
      "noatime"
      "noauto"
      "x-systemd.automount"
      "x-systemd.idle-timeout=600"
    ];
  };
in
{
  options = {
    nixfiles.nixos.homelab.nfs.enable = lib.mkEnableOption "Enable connecting to the Homelab NFS shares.";
  };

  # TODO: Enable picking and choosing which shares to mount and where.
  config = lib.mkIf cfg.enable {
    fileSystems."/mnt/vault" = mkNfsShare { name = "vault"; };
    fileSystems."/mnt/pool" = mkNfsShare { name = "pool"; };
  };
}
