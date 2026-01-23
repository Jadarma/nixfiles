# Bootloader
# Configures systemd-boot.
{ config, lib, ... }:
lib.mkIf config.nixfiles.enable {
  boot.loader = {
    systemd-boot = {
      enable = true;

      # Prefer not to allow boot configuration to be modified.
      editor = lib.mkDefault false;

      # How many generations to keep.
      configurationLimit = lib.mkDefault 128;
    };

    efi.canTouchEfiVariables = lib.mkDefault true;
  };
}
