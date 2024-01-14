{ pkgs, config, nix-colors, ... }: {
  imports = [
    nix-colors.homeManagerModules.default
  ];

  # Material theme, best theme.
  colorScheme = nix-colors.colorSchemes.material;

  gtk = {
    enable = true;
    theme = {
      name = "Adapta-Nokto-Eta";
      package = pkgs.adapta-gtk-theme;
    };
  };
}
