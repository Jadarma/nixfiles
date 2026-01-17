# Desktop
# Umbrella module for desktop environments, GUI settings, and other needing a monitor.
{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib)
    mkEnableOption
    mkDefault
    mkIf
    mkMerge
    ;
in
{
  options.nixfiles.desktop = {
    enable = mkEnableOption "Graphical Desktop";
  };

  config = mkIf config.nixfiles.enable (mkMerge [

    # Macs always have a graphical desktop available.
    (mkIf pkgs.stdenv.isDarwin {
      nixfiles.desktop.enable = mkDefault true;
    })
  ]);
}
