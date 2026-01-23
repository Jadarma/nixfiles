# EZA
# An `ls` replacement.
{ lib, ... }:
{
  options.nixfiles.programs.eza = {
    enable = lib.mkEnableOption "Eza";
  };
}
