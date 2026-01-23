{
  config,
  lib,
  pkgs,
  ...
}:
lib.mkIf config.nixfiles.enable {

  # Explicitly define the already existing default.
  # Prefer a managed Nix configuration for ease of use and reproducibility.
  # You would disable this if, for instance, you want to use Determinate Nix instead.
  nix.enable = true;
  nix.package = pkgs.nix;

  nix.settings = {
    # Ensure Flakes are enabled, we need them.
    experimental-features = [
      "nix-command"
      "flakes"
    ];

    # Parallelize builds.
    cores = 0;
    max-jobs = "auto";

    # Enable sandboxed builds.
    sandbox = true;

    # Require signed binaries.
    require-sigs = true;
  };

  # Enable automatic store optimisation.
  nix.optimise.automatic = lib.mkDefault true;
  nix.gc = {
    automatic = lib.mkDefault true;
    options = "--delete-older-than 30d";
  };

  # Make unfree packages an opt-out instead of opt-in.
  nixpkgs.config.allowUnfree = lib.mkDefault true;

  # Add formatter and language server, useful for developing.
  environment.systemPackages = with pkgs; [
    nixfmt
    nixd
  ];
}
