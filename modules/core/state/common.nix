# Ensures the state versions are set, which are important for proper system configurations.
# Technically, this shouldn't really be the jurisdiction of the Nixfiles, but I like the sanity check because I manage
# multiple systems.
{ config, lib, ... }:
let
  inherit (lib) mkOption mkIf;
  inherit (lib.types) oneOf str int;
  cfg = config.nixfiles.state;
in
{
  options.nixfiles.state = {
    homeManager = mkOption {
      description = "The latest HomeManager state version at the time of first install on the machine.";
      type = str;
      example = "25.11";
    };
    system = mkOption {
      description = "The latest NixOS or nix-darwin state version at the time of first install on the machine.";
      type = oneOf [
        str
        int
      ];
      example = "25.11";
    };
  };

  config = mkIf config.nixfiles.enable {
    system.stateVersion = cfg.system;
    home-manager.users."${config.nixfiles.user.name}".home.stateVersion = cfg.homeManager;
  };
}
