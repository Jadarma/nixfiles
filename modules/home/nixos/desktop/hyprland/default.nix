{ config, lib, pkgs, ... }@inputs:
let cfg = config.nixfiles.home.desktop; in {
  # TODO: IS this the way?
  config = lib.mkIf cfg.enable (lib.mkMerge [
    (import ./hyprcursor.nix inputs)
    (import ./hypridle.nix inputs)
    (import ./hyprland.nix inputs)
    (import ./hyprlock.nix inputs)
    (import ./hyprpaper.nix inputs)
    (import ./hyprpicker.nix inputs)
  ]);
}
