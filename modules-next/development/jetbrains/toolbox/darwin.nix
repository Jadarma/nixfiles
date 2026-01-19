# Jetbrains Toolbox
# Useful only on Darwin to get official binaries that work.
# On NixOS, they should be taken from Nixpkgs to get Nix-patched version.
# This module auto-enables itself if any IDE would require it.
{ config, lib, ... }:
let
  cfg = config.nixfiles.development.jetbrains;
  enable = cfg.idea.enable || cfg.android.enable;
in
lib.mkIf enable {
  # On Darwin we prefer to take directly from Toolbox.
  homebrew.casks = [
    {
      name = "jetbrains-toolbox";
      greedy = true;
    }
  ];
}
