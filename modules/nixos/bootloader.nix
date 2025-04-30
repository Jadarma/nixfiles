{ config, lib, ... }:
let cfg = config.nixfiles.nixos.bootloader; in {

  options = {
    nixfiles.nixos.bootloader = {
      enable = lib.mkEnableOption "SystemD Boot (Bootloader)";
    };
  };

  config = lib.mkIf cfg.enable {
    boot.loader = {
      systemd-boot = {
        enable = true;
        editor = lib.mkDefault false;
        configurationLimit = lib.mkDefault 128;
      };

      efi.canTouchEfiVariables = lib.mkDefault true;
    };
  };
}
