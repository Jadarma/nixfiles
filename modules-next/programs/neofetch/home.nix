{
  osConfig,
  lib,
  pkgs,
  ...
}:
lib.mkIf osConfig.nixfiles.programs.neofetch.enable {

  home.packages = [ pkgs.neofetch ];

  xdg.configFile = {
    "neofetch/config.conf".source = ./neofetch.conf;
    "neofetch/logo.txt".source = ./logo.txt;
  };
}
