{ config, lib, ... }:
let
  cfg = config.nixfiles.user;
in
lib.mkIf config.nixfiles.enable {
  users.users."${cfg.name}" = {
    isNormalUser = true;
    homeMode = 700;
    group = cfg.name;
    extraGroups = [ "wheel" ];
  };
}
