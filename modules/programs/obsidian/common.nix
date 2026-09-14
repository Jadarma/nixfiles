# Obsidian
# Fancy markdown note taking.
{ config, lib, ... }:
{
  options.nixfiles.programs.obsidian = {
    enable = lib.mkEnableOption "Obsidian";
  };

  config = lib.mkIf config.nixfiles.programs.obsidian.enable {
    assertions = [
      {
        assertion = config.nixfiles.desktop.enable == true;
        message = ''
          Obsidian is a graphical application but no desktop UI is enabled.
            Fix: nixfiles.desktop.enable = true
        '';
      }
    ];
  };
}
