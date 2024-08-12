{ lib, ... }: {

  # Enable Nix Flakes.
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Make unfree an opt-out instead of opt-in.
  nixpkgs.config.allowUnfree = lib.mkDefault true;

  # Run garbage collection periodically.
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };
}