# List available recipes.
default:
  just --list --unsorted

# Issue a NixOS rebuild. Type is one of: switch, test, boot.
rebuild TYPE="switch":
    sudo nixos-rebuild {{TYPE}} --flake .#

# Update the flake lockfile.
update:
    nix flake update

# Run the Nix garbage collector.
gc:
    nix store gc

# Launch the code editor.
code:
    codium .
