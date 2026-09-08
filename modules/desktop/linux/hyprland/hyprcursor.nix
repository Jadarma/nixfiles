{ pkgs, ... }:
{

  # Cursor workaround.
  # See https://wiki.hyprland.org/Nix/Hyprland-on-Home-Manager/#fixing-problems-with-themes
  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.catppuccin-cursors.macchiatoTeal;
    name = "catppuccin-macchiato-teal-cursors";
    size = 32;
  };

  # Set HyprCursor env vars.
  wayland.windowManager.hyprland.settings.env = [
    {
      _args = [
        "HYPRCURSOR_THEME"
        "catppuccin-macchiato-teal-cursors"
      ];
    }
    {
      _args = [
        "HYPRCURSOR_SIZE"
        "32"
      ];
    }
  ];
}
