{
  osConfig,
  lib,
  pkgs,
  ...
}:
let
  cfg = osConfig.nixfiles.development.nixfiles;
in
lib.mkIf cfg.enable {
  # Create the nixfiles script.
  home.packages =
    with pkgs;
    let
      nixfiles = {
        name = "nixfiles";
        runtimeInputs = [
          jq
          nix-direnv
          zsh
        ];
        text = builtins.readFile ./nixfiles.sh;
      };
    in
    [ (writeShellApplication nixfiles) ];

  # Expose the config location in an environment variable.
  home.sessionVariables = {
    NIXFILES_DIR = cfg.directory;
  };

  # Create a desktop entry, for convenience.
  xdg.desktopEntries.nixfiles = lib.mkIf pkgs.stdenv.targetPlatform.isLinux {
    name = "Nixfiles";
    genericName = "NixOS Configs";
    icon = "nix-snowflake";
    comment = "Open a code editor to edit the system's Nix configs.";
    categories = [ "Application" ];
    exec = "nixfiles";
    terminal = false;
  };
}
