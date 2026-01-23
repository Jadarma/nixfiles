# Darwin Modules
# Import some OS-level configs for nix-darwin systems only.
{ ... }:
{
  imports = [
    ./homebrew.nix
  ];
}
