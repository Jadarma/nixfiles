{ pkgs, config, ... }: {

  # Create the nixfiles script.
  home.packages = with pkgs;
    let
      nixfiles = {
        name = "nixfiles";
        runtimeInputs = [ jq nix-direnv zsh ];
        text = builtins.readFile ./nixfiles.sh;
      };
    in
    [ (writeShellApplication nixfiles) ];

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
}
