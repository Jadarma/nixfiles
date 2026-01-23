# Linux Modules
# Import some OS-level configs for NixOS systems only.
{ ... }:
{
  imports = [
    ./bootloader.nix
    ./locale.nix
    ./networking.nix
    ./usb.nix
  ];
}
