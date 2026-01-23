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
    mkOption
    mkDefault
    mkIf
    mkMerge
    ;
  inherit (lib.types)
    submodule
    attrsOf
    listOf
    either
    str
    strMatching
    int
    float
    ;

in
{
  options.nixfiles.desktop = {
    enable = mkEnableOption "Graphical Desktop";

    monitors = mkOption {
      type = attrsOf (submodule {
        options = {
          resolution = mkOption {
            description = "Resolution and refresh rate.";
            type = strMatching "([0-9]+)x([0-9]+)@([0-9]+)";
            example = "2560x1440@144";
          };
          position = mkOption {
            description = "Monitor position.";
            type = strMatching "([0-9]+)x([0-9]+)";
            example = "0x0";
          };
          scale = mkOption {
            description = "Monitor scaling.";
            type = float;
            example = 1.25;
            default = 1.0;
          };
          extraArgs = mkOption {
            description = "Extra monitor args for Hyprland.";
            type = attrsOf str;
            example = {
              vrr = "2";
            };
            default = { };
          };
          persistentWorkspaces = mkOption {
            description = "Names of persistent workspaces to bind to this monitor. Values 1-9 have keybinds!";
            type = listOf (either str int);
            example = [
              1
              2
              3
            ];
            default = [ ];
          };
          wallpaper = mkOption {
            description = ''Path relative to "$XDG_CONFIG_DATA/wallpapers".'';
            type = str;
            default = "bg_center.png";
          };
        };
      });
      default = { };
    };
  };

  config = mkIf config.nixfiles.enable (mkMerge [

    # Macs always have a graphical desktop available.
    (mkIf pkgs.stdenv.isDarwin {
      nixfiles.desktop.enable = mkDefault true;
    })
  ]);
}
