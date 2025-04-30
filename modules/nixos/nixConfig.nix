{ config, lib, ... }:
let cfg = config.nixfiles.nixos.nixConfig; in {

  options = {
    nixfiles.nixos.nixConfig = {
      enable = lib.mkEnableOption "Nix (Settings)";
    };
  };

  config = lib.mkIf cfg.enable {
    # Enable Nix Flakes.
    nix.settings.experimental-features = lib.mkDefault [ "nix-command" "flakes" ];

    # Make administrators trusted users.
    nix.settings.trusted-users = [ "root" "@wheel" ];

    # Make unfree an opt-out instead of opt-in.
    nixpkgs.config.allowUnfree = lib.mkDefault true;

    # Run garbage collection periodically.
    nix.gc = lib.mkDefault {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };

    # Enable compatibility with (some) non-nix binaries.
    programs.nix-ld.enable = lib.mkDefault true;
  };
}
