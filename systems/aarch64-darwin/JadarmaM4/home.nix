{ pkgs, lib, config, nixfiles, ... }: {
  imports = [
    "${nixfiles}/modules/home/alacritty"
    "${nixfiles}/modules/home/bat"
    "${nixfiles}/modules/home/direnv"
    "${nixfiles}/modules/home/eza"
    "${nixfiles}/modules/home/git"
    "${nixfiles}/modules/home/gpg"
    "${nixfiles}/modules/home/scripts/nixfiles"
    "${nixfiles}/modules/home/starship"
    "${nixfiles}/modules/home/theme/colorScheme.nix"
    "${nixfiles}/modules/home/xdg"
    "${nixfiles}/modules/home/zsh"
  ];

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
  services.gpg-agent.pinentryPackage = lib.mkForce pkgs.pinentry_mac;
  xdg.userDirs.enable = lib.mkForce false;
  xdg.desktopEntries = lib.mkForce { };

  # TODO: Development stuff.
  home.sessionVariables = rec {
    ANDROID_USER_HOME = "${config.xdg.dataHome}/android";
    ANDROID_HOME = "${ANDROID_USER_HOME}/sdk";

    KONAN_DATA_DIR = "${config.xdg.dataHome}/konan";
    GRADLE_USER_HOME = "${config.xdg.dataHome}/gradle";

    # Seems like the macOS ones wins the battle.
    # Hardcoded for now but not ideal.
    SSH_AUTH_SOCK = "${config.xdg.dataHome}/gnupg/S.gpg-agent.ssh";
  };

  programs.java = {
    enable = true;
    package = pkgs.jdk21;
  };
}
