{ config, lib, pkgs, ... }:
let cfg = config.nixfiles.home.gaming; in {

  config = lib.mkIf cfg.enable {
    # Add ProtonGE helper scripts.
    home.packages = with pkgs; [ protonup-ng ];
  };
}
