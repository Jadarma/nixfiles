# Common
# Imports all Nixfiles modules relevant for all systems, and define the actual options of the `nixfiles` module.
{
  config,
  lib,
  nix-colors,
  ...
}:
{
  imports = lib.pipe ./. [
    (lib.filesystem.listFilesRecursive)
    (lib.lists.filter (lib.strings.hasSuffix "common.nix"))
    (lib.lists.filter (path: path != ./common.nix))
  ];

  options = {
    nixfiles = {
      enable = lib.mkEnableOption "Whether to enable the Nixfiles module.";
    };
  };

  config = lib.mkIf config.nixfiles.enable {
    # Configure Home Manager.
    home-manager = {
      # Ensure packages between HomeManager and the system are in sync.
      useGlobalPkgs = lib.mkForce true;

      # Allow adding user packages from home.nix.
      useUserPackages = lib.mkForce true;

      # Import dependencies for external inputs.
      sharedModules = [
        nix-colors.homeManagerModules.default
      ];

      users."${config.nixfiles.user.name}".imports = lib.pipe ./. [
        (lib.filesystem.listFilesRecursive)
        (lib.lists.filter (lib.strings.hasSuffix "home.nix"))
      ];
    };
  };
}
