{ config, lib, ... }:
let cfg = config.nixfiles.home.development; in {
  imports = [
    # Common extensions.
    ./gpg.nix

    # Darwin-exclusive.
    ./containers.nix
  ];

  config = lib.mkIf cfg.enable {
    nixfiles.home.development.containers.enable = lib.mkDefault true;
  };
}
