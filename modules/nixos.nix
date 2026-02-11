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
  ++ lib.pipe ./. [
    (lib.filesystem.listFilesRecursive)
    (lib.lists.filter (lib.strings.hasSuffix "nixos.nix"))
    (lib.lists.filter (path: path != ./nixos.nix))
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
