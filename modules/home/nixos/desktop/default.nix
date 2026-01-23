{ config, osConfig, lib, ... }:
let
  cfg = config.nixfiles.home.desktop;
  inherit (lib) mkOption;
  inherit (lib.types) submodule attrsOf listOf either str strMatching int float;
in
{
  imports = [
    ./hyprland
  ];

  options = {
    nixfiles.home.desktop = {
      enable = lib.mkEnableOption "Desktop Environment Bundle (Hyprland-based)";
    };

    nixfiles.home.desktop.monitors = mkOption {
      type = attrsOf
        (submodule {
          options = {
            resolution = mkOption {
              description = "Resolution and refresh rate.";
              type = strMatching ''([0-9]+)x([0-9]+)@([0-9]+)'';
              example = "2560x1440@144";
            };
            position = mkOption {
              description = "Monitor position.";
              type = strMatching ''([0-9]+)x([0-9]+)'';
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
              example = { vrr = "2"; };
              default = { };
            };
            persistentWorkspaces = mkOption {
              description = "Names of persistent workspaces to bind to this monitor. Values 1-9 have keybinds!";
              type = listOf (either str int);
              example = [ 1 2 3 ];
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

  config = lib.mkIf cfg.enable {
    assertions = [
      {
        assertion = osConfig.nixfiles.nixos.gui.enable;
        message = "
          The 'nixfiles.home.desktop' module requires NixOS integration!
           └ To fix, set 'nixfiles.nixos.gui.enable = true' in your NixOS configuration.
        ";
      }
    ];
  };
}
