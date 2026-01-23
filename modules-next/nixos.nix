# NixOS
# Imports all Nixfile modules relevant for a NixOS system.
{
  config,
  lib,
  pkgs,
  home-manager,
  ...
}:
{
  imports = [
    home-manager.nixosModules.home-manager
    ./common.nix
  ]
  # A hardcoded list of all modules that should be imported on NixOS systems.
  # TODO: Automate by recursively iterating and finding all nixos.nix files.
  ++ [
    ./core/nix/nixos.nix
    ./core/system/linux/nixos.nix
    ./core/user/nixos.nix
    ./desktop/linux/mako/nixos.nix
    ./development/containers/nixos.nix
    ./development/jetbrains/android/nixos.nix
    ./development/jetbrains/idea/nixos.nix
    ./gaming/steam/nixos.nix
    ./services/homelab/nixos.nix
  ];

  config = lib.mkIf config.nixfiles.enable {
    assertions = [
      {
        assertion = pkgs.stdenv.isLinux;
        message = "The `modules/nixos.nix` module should only be imported in NixOS configurations.";
      }
    ];
  };
}
