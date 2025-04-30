{ config, lib, ... }:
let cfg = config.nixfiles.nixos.internet; in {

  options = {
    nixfiles.nixos.internet = {
      enable = lib.mkEnableOption "Internet & Networking (via NetworkManager)";
    };
  };

  config = lib.mkIf cfg.enable {
    networking = {
      # Enables DHCP on each ethernet and wireless interface.
      useDHCP = lib.mkDefault true;

      # Enable network manager. Remember to add your user to the `networkmanager` group as well.
      networkmanager.enable = lib.mkDefault true;
    };

    # Enable the NM Applet for GUI-based network editing.
    programs.nm-applet.enable = config.nixfiles.nixos.gui.enable;
  };
}
