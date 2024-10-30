{ pkgs, config, ... }: {

  home = {
    packages = with pkgs; [
      git-crypt
      jetbrains.idea-ultimate
      # android-studio
    ];

    # Home declutter.
    sessionVariables = rec {
      ANDROID_USER_HOME = "${config.xdg.dataHome}/android";
      ANDROID_HOME = "${ANDROID_USER_HOME}/sdk";

      KONAN_DATA_DIR = "${config.xdg.dataHome}/konan";
      GRADLE_USER_HOME = "${config.xdg.dataHome}/gradle";
    };
  };

  programs.java = {
    enable = true;
    package = pkgs.jdk21;
  };
}
