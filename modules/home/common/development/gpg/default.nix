{ config, lib, pkgs, ... }:
let
  cfg = config.nixfiles.home.development.gpg;
in
{
  options = {
    nixfiles.home.development.gpg = {
      enable = lib.mkEnableOption "GnuPG + YubiKey";
    };
  };

  config = lib.mkIf cfg.enable {
    # Configure GPG and configure personally managed keys.
    programs.gpg = {
      enable = true;
      package = pkgs.gnupg;
      homedir = "${config.home.homeDirectory}/.gnupg";

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
      pinentryPackage = pkgs.pinentry-gnome3;

      defaultCacheTtl = 60;
      maxCacheTtl = 120;
    };
  };
}

