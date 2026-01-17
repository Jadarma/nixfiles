{ osConfig, lib, ... }:
lib.mkIf osConfig.nixfiles.enable {

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
      base01 = "2E3C43";
      base02 = "314549";
      base03 = "546E7A";
      base04 = "B2CCD6";
      base05 = "EEFFFF";
      base06 = "EEFFFF";
      base07 = "EAEAEA";
      base08 = "F07178";
      base09 = "F78C6C";
      base0A = "FFCB6B";
      base0B = "C3E88D";
      base0C = "89DDFF";
      base0D = "82AAFF";
      base0E = "C792EA";
      base0F = "FF5370";

      accent = "16A085";
    };
  };
}
