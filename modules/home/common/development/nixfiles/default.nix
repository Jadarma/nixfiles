{ config, lib, pkgs, ... }:
let cfg = config.nixfiles.home.development.nixfiles; in {
  options = {
    nixfiles.home.development.nixfiles = {
      enable = lib.mkEnableOption "Nixfiles Helper Script";

      dir = lib.mkOption {
        type = lib.types.str;
        default = "${config.home.homeDirectory}/repo/nixfiles";
        description = "The path to the nixfiles repo dir.";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    # Create the nixfiles script.
    home.packages = with pkgs;
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
      NIXFILES_DIR = cfg.dir;
    };
  };
}
