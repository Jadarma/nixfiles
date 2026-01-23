# Hyprland
# Tiling window manager.
{
  config,
  lib,
  pkgs,
  ...
}:
lib.mkIf config.nixfiles.desktop.enable {
  programs.hyprland.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
}
