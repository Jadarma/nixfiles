# Git
# Source code management tool.
{ lib, ... }:
{
  options.nixfiles.development.git = {
    enable = lib.mkEnableOption "Git";
  };
}
