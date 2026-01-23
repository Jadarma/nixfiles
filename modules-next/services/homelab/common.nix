{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkEnableOption mkOption mkIf;
  inherit (lib.types)
    attrsOf
    submodule
    nonEmptyStr
    bool
    ;
in
{
  options.nixfiles.services.homelab = {
    enable = mkEnableOption "Enable connecting to the Homelab NFS shares.";

    shares = mkOption {
      description = "An attribute set defining network shares to mount. Keys are mountpoint path.";
      type = attrsOf (
        submodule (
          { ... }:
          {
            options = {
              dataset = mkOption {
                description = "The ZFS dataset associated with the network share.";
                example = "pool/dataset";
                type = nonEmptyStr;
              };
              host = mkOption {
                description = "The hostname or IP of the TrueNAS instance serving the network share.";
                type = nonEmptyStr;
                default = "nas";
              };
              readOnly = mkOption {
                description = "Whether the share should not be permitted to modify data on the server.";
                type = bool;
                default = false;
              };
              nfsVersion = mkOption {
                description = "The NFS version to use.";
                type = nonEmptyStr;
                default = "4.2";
              };
            };
          }
        )
      );
      default = { };
    };
  };

  config = mkIf config.nixfiles.services.homelab.enable {
    assertions = [
      {
        assertion = pkgs.stdenv.hostPlatform.isLinux;
        message = "Homelab integration is only supported on Linux.";
      }
    ];
  };
}
