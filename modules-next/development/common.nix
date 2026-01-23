# Development
# Umbrella module for programming / development tools and use-cases.
{ config, lib, ... }:
let
  inherit (lib)
    mkEnableOption
    mkDefault
    mkForce
    mkIf
    mkMerge
    ;
  cfg = config.nixfiles.development;
in
{
  options.nixfiles.development = {
    enable = mkEnableOption "Development";
  };

  config =
    let
      # If development is enabled, enable some sane defaults as well.
      ifEnabled = mkIf (cfg.enable) {
        nixfiles.development = {
          direnv.enable = mkDefault true;
          git.enable = mkDefault true;
          gpg.enable = mkDefault true;
          nixfiles.enable = mkDefault config.nixfiles.desktop.enable;
        };
      };

      # If development is disabled, force disable related modules, even if user enabled them manually.
      ifDisabled = mkIf (!cfg.enable) {
        nixfiles.development = {
          containers.enable = mkForce false;
          direnv.enable = mkForce false;
          git.enable = mkForce false;
          gpg.enable = mkForce false;
          jetbrains.idea.enable = mkForce false;
          jetbrains.android.enable = mkForce false;
          jvm.enable = mkForce false;
          nixfiles.enable = mkForce false;
        };
      };
    in
    mkIf config.nixfiles.enable (mkMerge [
      ifEnabled
      ifDisabled
    ]);
}
