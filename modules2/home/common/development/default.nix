{ config, lib, ... }:
let cfg = config.nixfiles.home.development; in {

  imports = [
    ./direnv.nix
  ];

  options = {
    nixfiles.home.development = {
      enable = lib.mkEnableOption "Platform-agnostic CLI setup.";
    };
  };

  config = lib.mkIf cfg.enable {

    # Enable all imported modules by default, if not overriden by global config.
    nixfiles.home.development = {
      direnv.enable = lib.mkDefault true;
    };
  };
}
