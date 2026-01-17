# Common
# Imports all Nixfiles modules relevant for all systems, and define the actual options of the `nixfiles` module.
{
  config,
  lib,
  nix-colors,
  ...
}:
{
  # A hardcoded list of all modules that should be imported on either platform.
  # TODO: Automate by recursively iterating and finding all common.nix files.
  imports = [
    ./core/nix/common.nix
    ./core/shell/common.nix
    ./core/user/common.nix
    ./core/state/common.nix
    ./desktop/common.nix
    ./development/common.nix
    ./development/direnv/common.nix
    ./development/git/common.nix
    ./development/gpg/common.nix
    ./programs/common.nix
    ./programs/ghostty/common.nix
    ./programs/starship/common.nix
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

      # A hardcoded list of all modules that should be imported for Home Manager.
      # TODO: Automate by recursively iterating and finding all home.nix files.
      users."${config.nixfiles.user.name}".imports = [
        ./core/shell/home.nix
        ./core/theme/home.nix
        ./core/xdg/home.nix
        ./development/direnv/home.nix
        ./development/git/home.nix
        ./development/gpg/home.nix
        ./programs/ghostty/home.nix
        ./programs/starship/home.nix
      ];
    };
  };
}
