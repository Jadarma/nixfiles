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
  wayland.windowManager.hyprland.settings.bind = [
    {
      _args = [
        "XF86Calculator"
        (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("qalculate-gtk")'')
      ];
    }
  ];
}
