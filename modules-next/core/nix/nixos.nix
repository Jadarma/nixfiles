{ config, lib, ... }:
lib.mkIf config.nixfiles.enable {

  # Enable compatibility layer with (some) non-nix binaries.
  programs.nix-ld.enable = true;

  # Make administrators trusted users.
  nix.settings.trusted-users = [ "@wheel" ];

  # Configure weekly automatic store optimisation jobs.
  nix.optimise.dates = "weekly";
  nix.gc.dates = "weekly";
}
