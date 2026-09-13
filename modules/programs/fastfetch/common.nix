# Fastfetch
# Decorative system information.
{ lib, ... }:
{
  options.nixfiles.programs.fastfetch = {
    enable = lib.mkEnableOption "FastFetch";
  };
}
