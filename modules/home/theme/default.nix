{ pkgs, config, nix-colors, ... }: {
  imports = [
    nix-colors.homeManagerModules.default
  ];

  # Material theme, best theme.
  colorScheme = nix-colors.colorSchemes.material;
}
