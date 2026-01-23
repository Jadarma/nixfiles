{ config, lib, ... }:
lib.mkIf config.nixfiles.enable {
  # Use network manager as main networking service.
  networking.networkmanager.enable = true;

  # Allow the main user to manage the network.
  users.groups."networkmanager".members = [ config.nixfiles.user.name ];

  # Enable the NM Applet for GUI-based network editing.
  programs.nm-applet.enable = config.nixfiles.desktop.enable;
}
