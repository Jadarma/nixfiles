# Nixfiles
# Provides a standalone editor for editing this repository.
{ config, lib, ... }:
let
  inherit (lib) mkEnableOption mkIf mkOption;
  cfg = config.nixfiles.development.nixfiles;
in
{
  options.nixfiles.development.nixfiles = {
    enable = mkEnableOption "Nixfiles";

    directory = mkOption {
      type = lib.types.path;
      default = "${config.nixfiles.user.homeDirectory}/repo/nixfiles";
      description = "The path to the nixfiles repo directory.";
    };
  };

  config = mkIf cfg.enable {
    assertions = [
      {
        assertion = config.nixfiles.desktop.enable == true;
        message = ''
          Nixfiles is a graphical application but no desktop UI is enabled.
            Fix: nixfiles.desktop.enable = true
        '';
      }
    ];
  };
}
