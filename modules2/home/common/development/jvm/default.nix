{ config, lib, pkgs, ... }:
let cfg = config.nixfiles.home.development.jvm; in {
  options = {
    nixfiles.home.development.jvm = {
      enable = lib.mkEnableOption "Java Development";
    };
  };

  config = lib.mkIf cfg.enable {

    programs.java = {
      enable = true;
      package = pkgs.jdk21;
    };

    programs.gradle = {
      enable = true;
      # The HM module uses relative strings, but I want to reuse variables, dammit!
      home = lib.strings.removePrefix "${config.home.homeDirectory}/" "${config.xdg.dataHome}/gradle";
    };

    home.sessionVariables = {
      KONAN_DATA_DIR = "${config.xdg.dataHome}/konan";
    };
  };
}
