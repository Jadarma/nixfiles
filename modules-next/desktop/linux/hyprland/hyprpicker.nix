{ pkgs, ... }:
{

  # Install packages.
  home.packages = with pkgs; [
    hyprpicker
    wl-clipboard
  ];

  # Add keybinds.
  # TODO: Consider adding a secondary keybind that prompts for other formats.
  wayland.windowManager.hyprland.settings = {
    bind = [
      "SUPER + CONTROL, C, exec, hyprpicker --autocopy --no-fancy --format=hex"
    ];
  };
}
