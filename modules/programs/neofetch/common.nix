# Neofetch
# Decorative system information. Also abandonware, might consider fastfetch instead but it still does the job.
{ lib, ... }:
{
  options.nixfiles.programs.neofetch = {
    enable = lib.mkEnableOption "Neofetch";
  };
}
