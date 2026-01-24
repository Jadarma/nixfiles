{ config, lib, ... }:
let
  cfg = config.nixfiles.user;
in
lib.mkIf config.nixfiles.enable {
  users.users."${cfg.name}" = {
    isNormalUser = true;
    homeMode = "750";
    group = cfg.name;
    extraGroups = [ "wheel" ];
  };

  services.displayManager.autoLogin = lib.mkIf cfg.autoLogin {
    enable = true;
    user = config.nixfiles.user.name;
  };
}
