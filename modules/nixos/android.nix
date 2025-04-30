{ config, lib, ... }:
let cfg = config.nixfiles.nixos.android; in {

  options = {
    nixfiles.nixos.android = {
      enable = lib.mkEnableOption "Android Integration";
    };
  };

  config = lib.mkIf cfg.enable {
    # Accept Android SDK license.
    nixpkgs.config.android_sdk.accept_license = true;

    # Enable ADB.
    programs.adb.enable = true;
  };
}
