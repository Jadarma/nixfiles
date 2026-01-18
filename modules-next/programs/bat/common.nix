# BAT
# A `cat` replacement.
{ lib, ... }:
{
  options.nixfiles.programs.bat = {
    enable = lib.mkEnableOption "Bat";
  };
}
