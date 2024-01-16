{ config, pkgs, ... }: {
  # Configure GPG and configure personally managed keys.
  programs.gpg = {
    enable = true;
    package = pkgs.gnupg;
    homedir = "${config.xdg.dataHome}/gnupg";

    publicKeys = [
      # Yubikey.
      {
        source = ./keys/0x36AA7D35E9D8197C.pub;
        trust = "ultimate";
      }
    ];
  };

  # Enable use of Yubikey for GPG and SSH via SmartCard.
  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    enableZshIntegration = true;
    pinentryFlavor = "gnome3";

    defaultCacheTtl = 60;
    maxCacheTtl = 120;
  };
}
