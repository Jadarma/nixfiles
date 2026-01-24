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
      *)          echo "Unknown system, cannot rebuild." && false;;
  esac

# Update the flake lockfile.
# On Darwin, also update the brew bundle.
update:
  #!/bin/sh
  nix flake update
  [ "$(uname -s)" = 'Darwin' ] && /opt/homebrew/bin/brew update --force

# Run the Nix garbage collector and try to reduce /nix/store disk usage.
cleanup:
  nix store gc
  nix store optimise

# Launch the code editor.
code:
  codium --user-data-dir ".vscode/data" --log 'off' --new-window --wait .
