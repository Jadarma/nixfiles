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

  # Set the profile picture.
  systemd.tmpfiles.rules = [
    "f+ /var/lib/AccountsService/users/${cfg.name} 0600 root root - [User]\\nIcon=/var/lib/AccountsService/icons/${cfg.name}\\n"
    "L+ /var/lib/AccountsService/icons/${cfg.name} - - - - ${./profile.png}"
  ];
}
