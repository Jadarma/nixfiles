# Ghostty
# A fast and featureful terminal emulator.
{ config, lib, ... }:
{
  options.nixfiles.programs.ghostty = {
    enable = lib.mkEnableOption "Ghostty";
  };

  config = lib.mkIf config.nixfiles.programs.ghostty.enable {
    assertions = [
      {
        assertion = config.nixfiles.desktop.enable == true;
        message = ''
          Ghostty is a graphical application but no desktop UI is enabled.
            Fix: nixfiles.desktop.enable = true
        '';
      }
    ];
  };
}
