# RIPGREP
# A better version of grep.
{ lib, ... }:
{
  options.nixfiles.programs.ripgrep = {
    enable = lib.mkEnableOption "RipGrep";
  };
}
