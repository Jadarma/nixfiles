# Android
# Mobile development with Android Studio.
{ config, lib, ... }:
let
  inherit (lib) mkEnableOption mkIf mkDefault;
  cfg = config.nixfiles.development.jetbrains.android;
in
{
  options.nixfiles.development.jetbrains.android = {
    enable = mkEnableOption "Android Studio";
  };

  config = mkIf cfg.enable {
    # Enable JVM dependency by default.
    nixfiles.development.jvm.enable = mkDefault true;

    # Sanity checks.
    assertions = [
      {
        assertion = config.nixfiles.desktop.enable == true;
        message = ''
          Android Studio is a graphical application but no desktop UI is enabled.
            Fix: nixfiles.desktop.enable = true
        '';
      }
      {
        assertion = config.nixfiles.development.jvm.enable == true;
        message = ''
          Android Studio requires a JDK.
            Fix: nixfiles.development.jvm.enable = true
        '';
      }
    ];
  };
}
