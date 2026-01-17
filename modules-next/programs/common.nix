{ config, lib, ... }:
let
  inherit (lib)
    mkEnableOption
    mkDefault
    mkIf
    mkMerge
    ;
in
{
  options.nixfiles.programs = {
    defaultCli.enable = mkEnableOption "common CLI programs for QoL";
    defaultGui.enable = mkEnableOption "common GUI applications.";
  };

  config =
    let
      defaultCli = mkIf (config.nixfiles.programs.defaultCli.enable) {
        nixfiles.programs = {
          starship.enable = mkDefault true;
        };
      };
      defaultGui = mkIf (config.nixfiles.programs.defaultGui.enable) {
        nixfiles.programs = {
          ghostty.enable = mkDefault true;
        };
      };
    in
    mkIf config.nixfiles.enable (mkMerge [
      defaultCli
      defaultGui
    ]);
}
