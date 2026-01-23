{ config, lib, ... }:
let cfg = config.nixfiles.nixos.saneDefaults; in {
  imports = [
    ./homelab
    ./bootloader.nix
    ./gui.nix
    ./internet.nix
    ./locale.nix
    ./sound.nix
    ./steam.nix
    ./usb.nix
  ];

  options = {
    nixfiles.nixos.saneDefaults = {
      enable = lib.mkEnableOption "Common configs usually shared by all hosts.";
    };
  };

  config = lib.mkIf cfg.enable {
    nixfiles.nixos.bootloader.enable = lib.mkDefault true;
    nixfiles.nixos.gui.enable = lib.mkDefault true;
    nixfiles.nixos.internet.enable = lib.mkDefault true;
    nixfiles.nixos.locale.enable = lib.mkDefault true;
    nixfiles.nixos.sound.enable = lib.mkDefault true;
    nixfiles.nixos.usb.enable = lib.mkDefault true;
  };
}
