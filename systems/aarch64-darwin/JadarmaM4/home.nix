{ pkgs, lib, config, nixfiles, ... }: {
  imports = [
    "${nixfiles}/modules2/home/darwin"
    "${nixfiles}/modules/home/alacritty"
    "${nixfiles}/modules/home/theme/colorScheme.nix"
  ];

  nixfiles.home = {
    cli.enable = true;
    development.enable = true;
  };

  home = {
    username = "dan";
    homeDirectory = "/Users/dan";
    stateVersion = "24.11";

    # Extra apps and packages.
    packages = with pkgs; [
      colima
      docker-client
      kdoctor
    ];
  };

  # TODO: Make this an automatic config in the gpg module.
  xdg.userDirs.enable = lib.mkForce false;
  xdg.desktopEntries = lib.mkForce { };

  # TODO: Development stuff.
  home.sessionVariables = rec {
    ANDROID_USER_HOME = "${config.xdg.dataHome}/android";
    ANDROID_HOME = "${ANDROID_USER_HOME}/sdk";

    KONAN_DATA_DIR = "${config.xdg.dataHome}/konan";
    GRADLE_USER_HOME = "${config.xdg.dataHome}/gradle";
  };

  programs.java = {
    enable = true;
    package = pkgs.jdk21;
  };
}
