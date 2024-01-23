{ pkgs, config, lib, ... }: {

  # The HomeManager module for GPG uses `Gnome3` as pinentry flavor, therefore this is required for compatibility when not using Gnome.
  services.dbus.packages = [ pkgs.gcr ];

  # If for whatever reason Gnome exists, ensure the keyring service is never enabled, otherwise it will override the `SSH_AUTH_SOCK`
  # variable that would've been set by the GPG Agent.
  services.gnome.gnome-keyring.enable = lib.mkForce false;

  # NOTE: No idea whether the following are actually required, but keeping them as sanity checks. ---------------------

  # Enable the PCSC-Lite daemon for better smartcard compatibility.
  services.pcscd.enable = true;

  # Add udev rules for smartcards.
  hardware.gpgSmartcards.enable = true;
}
