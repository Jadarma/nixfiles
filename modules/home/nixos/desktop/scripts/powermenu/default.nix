{ config, lib, pkgs, ... }:
let cfg = config.nixfiles.home.desktop; in {
  config = lib.mkIf cfg.enable {

    home.packages = with pkgs; [
      (writeShellApplication
        {
          name = "powermenu";
          runtimeInputs = [ wofi ];
          text = builtins.readFile ./powermenu.sh;
        })
    ];

    # Hyprland integration.
    wayland.windowManager.hyprland.settings = {
      bind = [
        "SUPER, escape, exec, powermenu"
      ];
    };
  };
}
