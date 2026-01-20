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
          bat.enable = mkDefault true;
          eza.enable = mkDefault true;
          htop.enable = mkDefault true;
          neofetch.enable = mkDefault true;
          ripgrep.enable = mkDefault true;
          starship.enable = mkDefault true;
        };
      };
      defaultGui = mkIf (config.nixfiles.programs.defaultGui.enable) {
        nixfiles.programs = {
          firefox.enable = mkDefault true;
          ghostty.enable = mkDefault true;
          qalculate.enable = mkDefault true;
          zathura.enable = mkDefault true;
        };
      };
    in
    mkIf config.nixfiles.enable (mkMerge [
      defaultCli
      defaultGui
    ]);
}
