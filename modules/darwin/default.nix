{ config, lib, ... }:
let cfg = config.nixfiles.darwin.saneDefaults; in {
  imports = [
    ./homebrew.nix
    ./nix.nix
  ];

  options = {
    nixfiles.darwin.saneDefaults = {
      enable = lib.mkEnableOption "Common configs usually shared by all hosts.";
    };
  };

  config = lib.mkIf cfg.enable {
    nixfiles.darwin.homebrew.enable = lib.mkDefault true;
    nixfiles.darwin.nix.enable = lib.mkDefault true;
  };
}
