{ config, lib, ... }:
let cfg = config.nixfiles.home.gaming; in {

  imports = [
    ./mangohud
  ];

  options = {
    nixfiles.home.gaming = {
      enable = lib.mkEnableOption "Gaming (Steam-based)";
    };
  };

  # TODO: Integrate with NixOS module when implemented.
  config = lib.mkIf cfg.enable { };
}
