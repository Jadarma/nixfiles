{
  osConfig,
  lib,
  pkgs,
  ...
}:
# TODO: It's dead, Jim. Force disable for now, investigate a migration.
# osConfig.nixfiles.programs.neofetch.enable
lib.mkIf false {

  home.packages = [ pkgs.neofetch ];

  xdg.configFile = {
    "neofetch/config.conf".source = ./neofetch.conf;
    "neofetch/logo.txt".source = ./logo.txt;
  };
}
