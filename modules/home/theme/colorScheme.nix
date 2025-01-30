{ nix-colors, ... }: {

  imports = [
    nix-colors.homeManagerModules.default
  ];

  # Material theme, best theme.
  # Imported from: https://github.com/tinted-theming/schemes/blob/spec-0.11/base16/material.yaml
  # And slightly modified to suit my whims :)
  colorScheme = {
    name = "Material";
    slug = "material";
    author = "Nate Peterson";
    variant = "dark";
    palette = {
      base00 = "263238";
      base01 = "2e3c43";
      base02 = "314549";
      base03 = "546e7a";
      base04 = "b2CCd6";
      base05 = "eeffff";
      base06 = "eeffff";
      base07 = "eaeaea";
      base08 = "f07178";
      base09 = "f78C6C";
      base0A = "ffCb6b";
      base0B = "c3e88d";
      base0C = "89ddff";
      base0D = "82aaff";
      base0E = "C792EA";
      base0F = "FF5370";

      accent = "16A085";
    };
  };
}
