# Zathura
# Minimalist PDF viewer.
{ config, lib, ... }:
{
  options.nixfiles.programs.zathura = {
    enable = lib.mkEnableOption "Zathura";
  };

  config = lib.mkIf config.nixfiles.programs.zathura.enable {
    assertions = [
      {
        assertion = config.nixfiles.desktop.enable == true;
        message = ''
          Zathura is a graphical application but no desktop UI is enabled.
            Fix: nixfiles.desktop.enable = true
        '';
      }
    ];
  };
}
