{
  config,
  osConfig,
  lib,
  ...
}:
let
  cfg = osConfig.nixfiles.development.jvm;
in
lib.mkIf cfg.enable {
  programs.java = {
    enable = true;
    package = cfg.package;
  };

  programs.gradle = {
    enable = true;
    # The HM module uses relative strings, but I want to reuse variables, dammit!
    home = lib.strings.removePrefix "${config.home.homeDirectory}/" "${config.xdg.dataHome}/gradle";
  };

  home.sessionVariables = {
    # Homedir cleanup.
    KONAN_DATA_DIR = "${config.xdg.dataHome}/konan";
  };
}
