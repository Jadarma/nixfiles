# Fonts
# Installs some default fonts.
{
  config,
  lib,
  pkgs,
  ...
}:
lib.mkIf config.nixfiles.enable {

  fonts.packages = with pkgs.nerd-fonts; [
    jetbrains-mono
    noto
  ];
}
