{
  lib,
  osConfig,
  pkgs,
  ...
}:
let
  inherit (lib) flatten concatMapStringsSep;
  inherit (lib.attrsets) mapAttrs mapAttrsToList;
  cfg = osConfig.nixfiles.desktop.monitors;
in
lib.mkIf (osConfig.nixfiles.desktop.enable && pkgs.stdenv.hostPlatform.isLinux) {

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;

    systemd = {
      enable = true;
      variables = [ "--all" ];
    };

    configType = "lua";
    extraConfig = concatMapStringsSep "\n" builtins.readFile [
      ./style.lua
      ./scrolling.lua
    ];

    settings = {

      config = {

        general = {
          allow_tearing = false;
        };

        input = {
          numlock_by_default = true;
        };

        misc = {
          mouse_move_enables_dpms = true;
          key_press_enables_dpms = true;
        };

        ecosystem = {
          no_update_news = false;
          no_donation_nag = true;
        };
      };

      monitor =
        let
          fallback = {
            output = "";
            mode = "preffered";
            position = "auto";
            scale = 1;
          };
          fmtMonitor =
            monitor: props:
            props.extraArgs
            // {
              output = monitor;
              mode = props.resolution;
              position = props.position;
              scale = lib.strings.floatToString props.scale;
            };
        in
        (mapAttrsToList fmtMonitor cfg) ++ [ fallback ];

      workspace_rule =
        let
          monitorToWorkspaces = mapAttrs (k: v: v.persistentWorkspaces) cfg;
          fmtLine = (
            k: v:
            map (it: {
              _args = [
                {
                  workspace = it;
                  monitor = k;
                  persistent = true;
                }
              ];
            }) v
          );
        in
        flatten (mapAttrsToList fmtLine monitorToWorkspaces);

      bind = [
        {
          _args = [
            "SUPER + F3"
            (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("pcmanfm")'')
            { description = "Launch file browser."; }
          ];
        }
      ];
    };
  };
}
