{ config, lib, ... }:
let cfg = config.nixfiles.nixos.saneDefaults; in {
  imports = [
    ./homelab
    ./android.nix
    ./bootloader.nix
    ./gpg.nix
    ./gui.nix
    ./internet.nix
    ./locale.nix
    ./nixConfig.nix
    ./shell.nix
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
    nixfiles.nixos.gpg.enable = lib.mkDefault true;
    nixfiles.nixos.gui.enable = lib.mkDefault true;
    nixfiles.nixos.internet.enable = lib.mkDefault true;
    nixfiles.nixos.locale.enable = lib.mkDefault true;
    nixfiles.nixos.shell.enable = lib.mkDefault true;
    nixfiles.nixos.sound.enable = lib.mkDefault true;
    nixfiles.nixos.nixConfig.enable = lib.mkDefault true;
    nixfiles.nixos.usb.enable = lib.mkDefault true;
  };
}
