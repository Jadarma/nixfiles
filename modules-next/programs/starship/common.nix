# Starship
# Customisable terminal prompt.
{ lib, ... }:
{
  options.nixfiles.programs.starship = {
    enable = lib.mkEnableOption "Starship";
  };
}
