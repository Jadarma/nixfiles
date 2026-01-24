# Steam
# Configure the Steam client and helper services for Linux Gaming.
{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.nixfiles.programs.steam = {
    enable = lib.mkEnableOption "Steam";
  };

  config = lib.mkIf config.nixfiles.programs.steam.enable {
    assertions = [
      {
        assertion = pkgs.stdenv.hostPlatform.isLinux;
        message = "Steam is only configured for Linux gaming, but this is not a NixOS machine.";
      }
      {
        assertion = config.nixfiles.desktop.enable == true;
        message = ''
          Steam requires graphics but no desktop UI is enabled.
            Fix: nixfiles.desktop.enable = true
        '';
      }
    ];
  };
}
