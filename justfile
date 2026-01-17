# List available recipes.
default:
  just --list --unsorted

# Issue a NixOS rebuild.
# Type is one of: switch, test, boot for NixOS.
#                 switch, check for nix-darwin.
rebuild TYPE="switch":
  #!/bin/sh
  unameOut="$(uname -s)"
  case "${unameOut}" in
      Linux*)     sudo nixos-rebuild {{TYPE}} --flake .#;;
      Darwin*)    sudo darwin-rebuild {{TYPE}} --flake .#;;
      *)          machine="Unknown system, cannot rebuild."
  esac

# Update the flake lockfile.
update:
    nix flake update

# Run the Nix garbage collector.
gc:
    nix store gc

# Launch the code editor.
code:
    codium .
