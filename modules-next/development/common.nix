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
          git.enable = mkDefault true;
          gpg.enable = mkDefault true;
        };
      };

      # If development is disabled, force disable related modules, even if user enabled them manually.
      ifDisabled = mkIf (!cfg.enable) {
        nixfiles.development = {
          git.enable = mkForce false;
          gpg.enable = mkDefault false;
        };
      };
    in
    mkMerge [
      ifEnabled
      ifDisabled
    ];
}
