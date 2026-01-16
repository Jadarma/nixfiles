# GPG
# Key management and Yubikey / Smartcard integrations.
{ lib, ... }:
{
  options.nixfiles.development.gpg = {
    enable = lib.mkEnableOption "GPG";
  };
}
