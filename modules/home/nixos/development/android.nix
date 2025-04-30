{ config, osConfig, lib, pkgs, ... }:
let cfg = config.nixfiles.home.development.android; in {

  options = {
    nixfiles.home.development.android = {
      enable = lib.mkEnableOption "Android Development";
    };
  };

  config = lib.mkIf cfg.enable {
    assertions = [
      {
        assertion = osConfig.nixfiles.nixos.android.enable;
        message = "
          The 'nixfiles.home.development.android' module requires NixOS integration!
           └ To fix, set 'nixfiles.nixos.android.enable = true' in your NixOS configuration.
        ";
      }
    ];

    home.packages = with pkgs; [ android-studio ];

    home.sessionVariables = rec {
      ANDROID_USER_HOME = "${config.xdg.dataHome}/android";
      ANDROID_HOME = "${ANDROID_USER_HOME}/sdk";
    };
  };
}
