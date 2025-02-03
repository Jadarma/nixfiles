{ config, lib, ... }:
let cfg = config.nixfiles.home.desktop; in {

  imports = [
    ./hyprland
    ./mako
    ./scripts
    ./theme
    ./waybar
    ./wofi
  ];

  options = {
    nixfiles.home.desktop = {
      enable = lib.mkEnableOption "Desktop Environment Bundle (Hyprland-based)";
    };
  };

  # TODO: Integrate with NixOS module when implemented.
  config = lib.mkIf cfg.enable { };
}
