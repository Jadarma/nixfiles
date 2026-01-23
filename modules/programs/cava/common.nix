# Cava
# Console-based Audio Visualizer.
{ lib, ... }:
{
  options.nixfiles.programs.cava = {
    enable = lib.mkEnableOption "Cava";
  };
}
