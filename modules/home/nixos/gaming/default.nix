{ config, osConfig, lib, ... }:
let cfg = config.nixfiles.home.gaming; in {

  imports = [
    ./mangohud
  ];

  options = {
    nixfiles.home.gaming = {
      enable = lib.mkEnableOption "Gaming Integrations (Steam-based)";
    };
  };

  config = lib.mkIf cfg.enable {
    assertions = [
      {
        assertion = osConfig.nixfiles.nixos.steam.enable;
        message = "
          The 'nixfiles.home.gaming' module requires NixOS integration!
           └ To fix, set 'nixfiles.nixos.steam.enable = true' in your NixOS configuration.
        ";
      }
    ];
  };
}
