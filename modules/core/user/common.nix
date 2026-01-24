# User
# Configures the main (and only) user account of the Nixfiles.
{ config, lib, ... }:
let
  inherit (lib) mkOption mkIf;
  inherit (lib.types) str int path bool listOf package;
  cfg = config.nixfiles.user;
in
{
  options.nixfiles.user = {
    name = mkOption {
      description = "The main user of the system.";
      type = str;
      example = "john";
    };

    displayName = mkOption {
      description = "The formatted full name or display name of the user.";
      type = str;
      example = "John Doe";
    };

    homeDirectory = mkOption {
      description = "The absolute path to the home directory of the user.";
      type = path;
      example = "/path/to/home/john";
    };

    uid = mkOption {
      description = "The account UID. Recommended to use 1000 on Linux and 501 on Darwin.";
      type = int;
      example = 1000;
    };

    gid = mkOption {
      description = "The primary group's GID. Ideally it would be the same as the UID.";
      type = int;
      example = 1000;
    };

    autoLogin = mkOption {
      description = ''
        Whether to automatically login on boot without requiring a password.
        Recommended only when using a VM or root drive is encrypted.
        Only affects NixOS targets.
      '';
      type = bool;
      example = true;
      default = false;
    };

    packages = mkOption {
      description = "List of extra packages to be installed for the user.";
      type = listOf package;
      default = [];
    };
  };

  config = mkIf config.nixfiles.enable {

    # Set the main system user.
    users.users."${cfg.name}" = {
      name = cfg.name;
      home = cfg.homeDirectory;
      description = cfg.displayName;
      createHome = true;
      uid = cfg.uid;
      packages = cfg.packages;
    };

    # Create a primary group for the user as well.
    users.groups."${cfg.name}" = {
      gid = cfg.gid;
      members = [ cfg.name ];
    };

    # Configure HomeManager for the user.
    home-manager.users."${cfg.name}" = {
      home.username = cfg.name;
      home.homeDirectory = cfg.homeDirectory;
    };
  };
}
