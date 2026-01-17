# Darwin
# Imports all Nixfile modules relevant for a nix-darwin system.
{
  config,
  lib,
  pkgs,
  home-manager,
  mac-app-util,
  ...
}:
{
  imports = [
    home-manager.darwinModules.home-manager
    ./common.nix
  ]
  # A hardcoded list of all modules that should be imported on Darwin systems.
  # TODO: Automate by recursively iterating and finding all darwin.nix files.
  ++ [
    ./core/nix/darwin.nix
    ./core/homebrew/darwin.nix
    ./core/user/darwin.nix
  ];

  config = lib.mkIf config.nixfiles.enable {

    # Import dependencies for external inputs.
    home-manager.sharedModules = [
      mac-app-util.homeManagerModules.default
    ];

    assertions = [
      {
        assertion = pkgs.stdenv.isDarwin;
        message = "The `modules/darwin.nix` module should only be imported in nix-darwin configurations.";
      }
      {
        assertion = pkgs.stdenv.hostPlatform.system == "aarch64-darwin";
        message = "x86 Macs are no longer supported. Please use an ARM device.";
      }
    ];
  };
}
