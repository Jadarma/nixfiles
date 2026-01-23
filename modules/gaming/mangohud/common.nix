# MangoHUD
# Provides benchmarking and diagnostics tooltip overlays.
{ lib, ... }:
{
  options.nixfiles.gaming.mangohud = {
    enable = lib.mkEnableOption "MangoHUD";
  };
}
