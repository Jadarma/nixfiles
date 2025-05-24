{ config, lib, pkgs, ... }:
let
  cfg = config.nixfiles.home.development.gpg;
in
{
  config = lib.mkIf cfg.enable {

    # This seems to be needed to get the Yubikey to be read, but it's not required on Linux.
    programs.gpg.scdaemonSettings = {
      reader-port = "Yubico Yubi";
    };

    # Override the pinentry for Darwin.
    services.gpg-agent.pinentry.package = lib.mkForce pkgs.pinentry_mac;

    # Without this enabled, macOS will take precedence, since HM only sets this variable if it is not already set.
    home.sessionVariables = {
      SSH_AUTH_SOCK = "${config.programs.gpg.homedir}/S.gpg-agent.ssh";
    };
  };
}
