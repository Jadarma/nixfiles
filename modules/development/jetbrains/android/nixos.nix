{
  config,
  lib,
  pkgs,
  ...
}:
lib.mkIf config.nixfiles.development.jetbrains.android.enable {
  # On Linux we pull the dependency directly, because we need the Nix-patched one.
  users.users."${config.nixfiles.user.name}".packages = with pkgs; [
    android-studio
  ];

  # Accept Android SDK license.
  nixpkgs.config.android_sdk.accept_license = true;

  # Enable ADB.
  programs.adb.enable = true;
  users.groups."adbusers".members = [ config.nixfiles.user.name ];
}
