{ ... }: {
  # Accept Android SDK license.
  nixpkgs.config.android_sdk.accept_license = true;

  # Enable ADB.
  programs.adb.enable = true;
}
