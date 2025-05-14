{ config, lib, ... }:
let cfg = config.nixfiles.home.cli; in {

  imports = [
    ./bat.nix
    ./eza.nix
    ./ripgrep.nix
    ./starship.nix
    ./zsh.nix
  ];

  options = {
    nixfiles.home.cli = {
      enable = lib.mkEnableOption "Platform-agnostic CLI setup.";
    };
  };

  config = lib.mkIf cfg.enable {

    # Enable all imported modules by default, if not overriden by global config.
    nixfiles.home.cli = {
      bat.enable = lib.mkDefault true;
      eza.enable = lib.mkDefault true;
      ripgrep.enable = lib.mkDefault true;
      starship.enable = lib.mkDefault true;
      zsh.enable = lib.mkDefault true;
    };
  };
}
