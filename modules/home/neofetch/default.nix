{ pkgs, config, ... }: {

  home.packages = [ pkgs.neofetch ];

  xdg.configFile = {
    "neofetch/config.conf".source = ./neofetch.conf;
    "neofetch/logo.txt".source = ./logo.txt;
  };
}
