# IDEA
# Kotlin and JVM development with IntelliJ Idea Ultimate.
{ config, lib, ... }:
let
  inherit (lib) mkEnableOption mkIf mkDefault;
  cfg = config.nixfiles.development.jetbrains.idea;
in
{
  options.nixfiles.development.jetbrains.idea = {
    enable = mkEnableOption "IntelliJ Idea Ultimate";
  };

  config = mkIf cfg.enable {
    # Enable JVM dependency by default.
    nixfiles.development.jvm.enable = mkDefault true;

    # Sanity checks.
    assertions = [
      {
        assertion = config.nixfiles.desktop.enable == true;
        message = ''
          IntelliJ Idea is a graphical application but no desktop UI is enabled.
            Fix: nixfiles.desktop.enable = true
        '';
      }
      {
        assertion = config.nixfiles.development.jvm.enable == true;
        message = ''
          IntelliJ Idea requires a JDK.
            Fix: nixfiles.development.jvm.enable = true
        '';
      }
    ];
  };
}
