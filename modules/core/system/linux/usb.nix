# USB
# Enables some services for better integration with removable USB devices.
{ config, lib, ... }:
lib.mkIf config.nixfiles.enable {
  # Enable Rules for USB storage and auto-mounting.
  services.gvfs.enable = true;
  services.udisks2.enable = true;
}
