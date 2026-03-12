# Steko
# A simple and secure steganography CLI tool.
{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.nixfiles.programs.steko = {
    enable = lib.mkEnableOption "Steko";
  };

  config = lib.mkIf config.nixfiles.programs.steko.enable {
    nixfiles.user.packages = with pkgs; [ steko ];
  };
}
