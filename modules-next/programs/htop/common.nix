# HTop
# A TUI Task Manager / Process Monitor
{ lib, ... }:
{
  options.nixfiles.programs.htop = {
    enable = lib.mkEnableOption "HTop";
  };
}
