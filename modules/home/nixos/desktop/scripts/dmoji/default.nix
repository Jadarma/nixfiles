{ config, lib, pkgs, ... }:
let cfg = config.nixfiles.home.desktop; in {
  config = lib.mkIf cfg.enable {

    home.packages = with pkgs; [
      (writeShellApplication
        {
          name = "dmoji";
          runtimeInputs = [
            curl
            frece
            jq
            libnotify
            wl-clipboard
            wofi
          ];
          text = builtins.readFile ./dmoji.sh;
        })
    ];

    # Hyprland integration.
    wayland.windowManager.hyprland.settings = {
      bind = [
        "SUPER, E, exec, dmoji"
      ];
    };
  };
}
