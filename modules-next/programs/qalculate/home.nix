{
  osConfig,
  lib,
  pkgs,
  ...
}:
lib.mkIf osConfig.nixfiles.programs.qalculate.enable {

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
}
