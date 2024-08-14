{ config, pkgs, lib, ... }: {

  networking = {
    # Enables DHCP on each ethernet and wireless interface.
    useDHCP = lib.mkDefault true;

    # Enable network manager. Remember to add your user to the `networkmanager` group as well.
    networkmanager.enable = lib.mkDefault true;
  };

  # Enable the NM Applet for GUI-based network editing.
  programs.nm-applet.enable = lib.mkDefault true;
}
