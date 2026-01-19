{
  config,
  lib,
  pkgs,
  ...
}:
lib.mkIf config.nixfiles.development.jetbrains.android.enable {

  # Kdoctor makes it easier to debug environment issues.
  users.users."${config.nixfiles.user.name}".packages = with pkgs; [ kdoctor ];

  # Also install XCode, to allow for multiplatform mobile development.
  homebrew.masApps.Xcode = 497799835;
}
