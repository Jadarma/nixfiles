{ config, lib, ... }:
let cfg = config.nixfiles.common.cli; in {

  imports = [
    ./bat.nix
    ./eza.nix
    ./starship.nix
    ./zsh.nix
  ];

  options = {
    nixfiles.common.cli = {
      enable = lib.mkEnableOption "Platform-agnostic CLI setup.";
    };
  };

  config = lib.mkIf cfg.enable {

    # Enable all imported modules by default, if not overriden by global config.
    nixfiles.common.cli = {
      bat.enable = lib.mkDefault true;
      eza.enable = lib.mkDefault true;
      starship.enable = lib.mkDefault true;
      zsh.enable = lib.mkDefault true;
    };
  };
}
