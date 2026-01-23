inputs@{
  lib,
  config,
  osConfig,
  pkgs,
  ...
}:
lib.mkIf (osConfig.nixfiles.desktop.enable && pkgs.stdenv.hostPlatform.isLinux) (
  lib.mkMerge [
    (import ./hyprcursor.nix inputs)
    (import ./hypridle.nix inputs)
    (import ./hyprland.nix inputs)
    (import ./hyprlock.nix inputs)
    (import ./hyprpaper.nix inputs)
    (import ./hyprpicker.nix inputs)
  ]
)
