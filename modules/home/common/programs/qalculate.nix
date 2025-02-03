{ config, lib, pkgs, ... }:
let cfg = config.nixfiles.home.programs.qalculate; in {
  options = {
    nixfiles.home.programs.qalculate = {
      enable = lib.mkEnableOption "Qalculate (Calculator App)";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      libqalculate
      qalculate-gtk
    ];

    # Hyprland integration. (Linux Only)
    wayland.windowManager.hyprland.settings = {
      bind = [
        ", XF86Calculator, exec, qalculate-gtk"
      ];
    };
  };
}
