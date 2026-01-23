{
  config,
  osConfig,
  lib,
  ...
}:
lib.mkIf osConfig.nixfiles.development.jetbrains.android.enable {

  # Homedir cleanup.
  home.sessionVariables = rec {
    ANDROID_USER_HOME = "${config.xdg.dataHome}/android";
    ANDROID_HOME = "${ANDROID_USER_HOME}/sdk";
  };
}
