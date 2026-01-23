# Qalculate
# Advanced calculator app.
{ config, lib, ... }:
{
  options.nixfiles.programs.qalculate = {
    enable = lib.mkEnableOption "Qalculate";
  };

  config = lib.mkIf config.nixfiles.programs.qalculate.enable {
    assertions = [
      {
        assertion = config.nixfiles.desktop.enable == true;
        message = ''
          Qalculate is a graphical application but no desktop UI is enabled.
            Fix: nixfiles.desktop.enable = true
        '';
      }
    ];
  };
}
