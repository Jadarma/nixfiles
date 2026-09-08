{ pkgs, lib, ... }:
{

  # Install packages.
  home.packages = with pkgs; [
    hyprpicker
    wl-clipboard
  ];

  # Add keybinds.
  # TODO: Consider adding a secondary keybind that prompts for other formats.
  wayland.windowManager.hyprland.settings.bind = [
    {
      _args = [
        "SUPER + CONTROL + C"
        (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("hyprpicker --autocopy --no-fancy --format=hex")'')
      ];
    }
  ];
}
