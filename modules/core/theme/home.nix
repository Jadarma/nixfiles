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
      base00 = lib.mkDefault "263238";
      base01 = lib.mkDefault "2E3C43";
      base02 = lib.mkDefault "314549";
      base03 = lib.mkDefault "546E7A";
      base04 = lib.mkDefault "B2CCD6";
      base05 = lib.mkDefault "EEFFFF";
      base06 = lib.mkDefault "EEFFFF";
      base07 = lib.mkDefault "EAEAEA";
      base08 = lib.mkDefault "F07178";
      base09 = lib.mkDefault "F78C6C";
      base0A = lib.mkDefault "FFCB6B";
      base0B = lib.mkDefault "C3E88D";
      base0C = lib.mkDefault "89DDFF";
      base0D = lib.mkDefault "82AAFF";
      base0E = lib.mkDefault "C792EA";
      base0F = lib.mkDefault "FF5370";

      accent = lib.mkDefault "16A085";
    };
  };
}
