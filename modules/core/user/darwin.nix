{ config, lib, ... }:
let
  cfg = config.nixfiles.user;
in
lib.mkIf config.nixfiles.enable {
  users.users."${cfg.name}" = {
    isHidden = false;
    gid = cfg.gid;
  };

  users.knownGroups = [ cfg.name ];
  system.primaryUser = cfg.name;
}
