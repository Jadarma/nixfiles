{ config, lib, pkgs, ... }:
let
  cfg = config.nixfiles.nixos.homelab;

  nasmount = pkgs.writeScriptBin "nasmount" (builtins.readFile ./nasmount.sh);

  mkNasNfsShare = share: with share; {
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
{
  options = {
    nixfiles.nixos.homelab = {
      enable = lib.mkEnableOption "Enable connecting to the Homelab NFS shares.";

      shares = lib.mkOption {
        description = "An attribute set defining network shares to mount. Keys are mountpoint path.";
        type = lib.types.attrsOf (lib.types.submodule ({ ... }: {
          options = {
            dataset = lib.mkOption {
              description = "The ZFS dataset associated with the network share.";
              example = "pool/dataset";
              type = lib.types.nonEmptyStr;
            };
            host = lib.mkOption {
              description = "The hostname or IP of the TrueNAS instance serving the network share.";
              type = lib.types.nonEmptyStr;
              default = "nas";
            };
            readOnly = lib.mkOption {
              description = "Whether the share should not be permitted to modify data on the server.";
              type = lib.types.bool;
              default = false;
            };
            nfsVersion = lib.mkOption {
              description = "The NFS version to use.";
              type = lib.types.nonEmptyStr;
              default = "4.2";
            };
          };
        }));
        default = { };
      };
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ nasmount ];
    fileSystems = lib.mapAttrs (mountpoint: mkNasNfsShare) cfg.shares;
  };
}
