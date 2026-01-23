{
  config,
  osConfig,
  lib,
  pkgs,
  ...
}:
let
  cfg = osConfig.nixfiles.development.gpg;
  isDarwin = pkgs.hostPlatform.isDarwin;
in
lib.mkIf cfg.enable {
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

    # This helps macOS read the port but it seems to mess up Linux detection.
    scdaemonSettings = lib.mkIf isDarwin {
      reader-port = "Yubico Yubi";
    };
  };

  # Enable use of Yubikey for GPG and SSH via SmartCard.
  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    enableZshIntegration = true;
    pinentry.package = if isDarwin then pkgs.pinentry_mac else pkgs.pinentry-gnome3;

    defaultCacheTtl = 60;
    maxCacheTtl = 120;
  };

  home.sessionVariables = {
    # Explicitly set the SSH_AUTH_SOCK variable.
    # Without it, macOS will take precedence, since HM only sets this variable if it is not already set.
    # There is also some funky stuff with Gnome on NixOS.
    SSH_AUTH_SOCK = lib.mkForce "${config.programs.gpg.homedir}/S.gpg-agent.ssh";
  };
}
