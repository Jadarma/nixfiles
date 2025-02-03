{ config, lib, ... }:
let cfg = config.nixfiles.home.development.nixfiles; in {

  config = lib.mkIf cfg.enable {
    # Create a desktop entry, for convenience.
    xdg.desktopEntries.nixfiles = {
      name = "Nixfiles";
      genericName = "NixOS Configs";
      icon = "nix-snowflake";
      comment = "Open a code editor to edit the system's Nix configs.";
      categories = [ "Application" ];
      exec = "nixfiles";
      terminal = false;
    };
  };
}
