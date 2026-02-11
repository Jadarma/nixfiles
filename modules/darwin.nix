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
  ++ lib.pipe ./. [
    (lib.filesystem.listFilesRecursive)
    (lib.lists.filter (lib.strings.hasSuffix "darwin.nix"))
    (lib.lists.filter (path: path != ./darwin.nix))
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
