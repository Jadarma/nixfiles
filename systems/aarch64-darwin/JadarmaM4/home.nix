{ config, pkgs, ... }: {

  home = {
    username = "dan";
    homeDirectory = "/Users/dan";
    stateVersion = "24.11";

    # Extra apps and packages.
    packages = with pkgs; [
      kdoctor
    ];
  };

  nixfiles.home = {
    cli.enable = true;
    development.enable = true;

    programs = {
      firefox.enable = true;
      ghostty.enable = true;
      neofetch.enable = true;
    };
  };

  # TODO: Development stuff.
  home.sessionVariables = rec {
    ANDROID_USER_HOME = "${config.xdg.dataHome}/android";
    ANDROID_HOME = "${ANDROID_USER_HOME}/sdk";
  };
}
