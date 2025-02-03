{ config, lib, ... }:
let cfg = config.nixfiles.darwin.nix; in {

  options = {
    nixfiles.darwin.nix = {
      enable = lib.mkEnableOption "Nix Store Configs";
    };
  };

  config = lib.mkIf cfg.enable {

    # Automatically run garbage collection every week.
    nix.gc = lib.mkDefault {
      automatic = true;
      interval = { Hour = 0; Minute = 0; Weekday = 0; };
      options = "--delete-older-than 30d";
    };

    # Automatically run the nix store optimiser every week.
    nix.optimise = lib.mkDefault {
      automatic = true;
      interval = { Hour = 0; Minute = 0; Weekday = 0; };
    };

    # Allow non-free packages.
    nixpkgs.config.allowUnfree = lib.mkDefault true;
  };
}
