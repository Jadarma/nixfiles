{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.nixfiles.nixos.gui;
in
{

  options = {
    nixfiles.nixos.gui = {
      enable = lib.mkEnableOption "GUI Desktop (via Hyprland)";
    };
  };

  config = lib.mkIf cfg.enable {

    # Enable Hyprland.
    programs.hyprland.enable = true;
    xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };
}
