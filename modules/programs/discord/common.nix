# Discord
# Necessary evil to have friends these days.
{ config, lib, ... }:
{
  options.nixfiles.programs.discord = {
    enable = lib.mkEnableOption "Discord";
  };

  config = lib.mkIf config.nixfiles.programs.qalculate.enable {
    assertions = [
      {
        assertion = config.nixfiles.desktop.enable == true;
        message = ''
          Discord is a graphical application but no desktop UI is enabled.
            Fix: nixfiles.desktop.enable = true
        '';
      }
    ];
  };
}
