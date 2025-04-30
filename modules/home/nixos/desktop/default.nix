{ config, osConfig, lib, ... }:
let cfg = config.nixfiles.home.desktop; in {

  imports = [
    ./hyprland
    ./mako
    ./scripts
    ./theme
    ./waybar
    ./wofi
  ];

  options = {
    nixfiles.home.desktop = {
      enable = lib.mkEnableOption "Desktop Environment Bundle (Hyprland-based)";
    };
  };

  config = lib.mkIf cfg.enable {
    assertions = [
      {
        assertion = osConfig.nixfiles.nixos.gui.enable;
        message = "
          The 'nixfiles.home.desktop' module requires NixOS integration!
           └ To fix, set 'nixfiles.nixos.gui.enable = true' in your NixOS configuration.
        ";
      }
    ];
  };
}
