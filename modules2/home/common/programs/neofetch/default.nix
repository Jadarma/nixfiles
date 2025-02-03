{ config, lib, pkgs, ... }:
let cfg = config.nixfiles.home.programs.neofetch; in {
  options = {
    nixfiles.home.programs.neofetch = {
      enable = lib.mkEnableOption "Neofetch";
    };
  };

  config = lib.mkIf cfg.enable {

    home.packages = [ pkgs.neofetch ];

    xdg.configFile = {
      "neofetch/config.conf".source = ./neofetch.conf;
      "neofetch/logo.txt".source = ./logo.txt;
    };
  };
}
