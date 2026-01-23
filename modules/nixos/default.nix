{ config, lib, ... }:
let cfg = config.nixfiles.nixos.saneDefaults; in {
  imports = [
    ./homelab
    ./gui.nix
    ./internet.nix
    ./sound.nix
    ./steam.nix
  ];

  options = {
    nixfiles.nixos.saneDefaults = {
      enable = lib.mkEnableOption "Common configs usually shared by all hosts.";
    };
  };

  config = lib.mkIf cfg.enable {
    nixfiles.nixos.gui.enable = lib.mkDefault true;
    nixfiles.nixos.internet.enable = lib.mkDefault true;
    nixfiles.nixos.sound.enable = lib.mkDefault true;
  };
}
