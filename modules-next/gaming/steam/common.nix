# Steam
# Configure the Steam client and helper services for Linux Gaming.
{ lib, ... }: {
  options.nixfiles.gaming.steam = {
    enable = lib.mkEnableOption "Steam";
  };
}
