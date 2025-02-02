{ config, lib, ... }:
let cfg = config.nixfiles.common.cli; in {

  imports = [
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
      zsh.enable = lib.mkDefault true;
    };
  };
}
