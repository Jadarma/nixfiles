{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib)
    mkEnableOption
    mkDefault
    mkForce
    mkIf
    mkMerge
    ;

  cfg = config.nixfiles.gaming;
in
{
  options.nixfiles.gaming = {
    enable = mkEnableOption "Gaming";
  };

  config =
    let
      # If gaming is enabled, enable some sane defaults as well.
      ifEnabled = mkIf (cfg.enable) {

        nixfiles.gaming = {
          steam.enable = mkDefault true;
          mangohud.enable = mkDefault true;
        };

        assertions = [
          {
            assertion = pkgs.stdenv.hostPlatform.isLinux;
            message = "Gaming is only configured for Linux, but this is not a NixOS machine.";
          }
          {
            assertion = config.nixfiles.desktop.enable == true;
            message = ''
              Gaming requires graphics but no desktop UI is enabled.
                Fix: nixfiles.desktop.enable = true
            '';
          }
        ];
      };

      # If gaming is disabled, force disable related modules, even if user enabled them manually.
      ifDisabled = mkIf (!cfg.enable) {
        nixfiles.gaming = {
          steam.enable = mkForce false;
          mangohud.enable = mkForce false;
        };
      };
    in
    mkIf config.nixfiles.enable (mkMerge [
      ifEnabled
      ifDisabled
    ]);
}
