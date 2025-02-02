{ config, pkgs, nixfiles, ... }: {
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
      kdoctor
    ];
  };

  # TODO: Development stuff.
  home.sessionVariables = rec {
    ANDROID_USER_HOME = "${config.xdg.dataHome}/android";
    ANDROID_HOME = "${ANDROID_USER_HOME}/sdk";
  };
}
