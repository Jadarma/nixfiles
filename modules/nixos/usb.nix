{ config, lib, ... }:
let cfg = config.nixfiles.nixos.usb; in {

  options = {
    nixfiles.nixos.usb = {
      enable = lib.mkEnableOption "USB Storage";
    };
  };

  config = lib.mkIf cfg.enable {
    # Enable Rules for USB storage and auto-mounting.
    services.gvfs.enable = true;
    services.udisks2.enable = true;
  };
}
