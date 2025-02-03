{ config, lib, ... }:
let cfg = config.nixfiles.home.development; in {

  imports = [
    ./gpg
    ./nixfiles
    ./direnv.nix
    ./git.nix
    ./jvm.nix
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
      git.enable = lib.mkDefault true;
      gpg.enable = lib.mkDefault true;
      jvm.enable = lib.mkDefault true;
      nixfiles.enable = lib.mkDefault true;
    };
  };
}
