# Firefox
# The last decent web browser.
{ config, lib, ... }:
{
  options.nixfiles.programs.firefox = {
    enable = lib.mkEnableOption "Firefox";
  };

  config = lib.mkIf config.nixfiles.programs.firefox.enable {
    assertions = [
      {
        assertion = config.nixfiles.desktop.enable == true;
        message = ''
          Firefox is a graphical application but no desktop UI is enabled.
            Fix: nixfiles.desktop.enable = true
        '';
      }
    ];
  };
}
