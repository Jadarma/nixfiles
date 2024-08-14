{ pkgs, config, nix-colors, ... }: {
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

  # Configure the GTK Theme.
  # Note that while you could use `nix-colors` to autogenerate a Materia GTK theme, I found that the color scheme is a bit off.
  # Since I don't plan on ever changing away from the Material theme, use the proper Adapta theme, which will also make it easier to align with QT apps.
  gtk = {
    enable = true;

    # NOTE: Cursors are a bit finnicky, this should work but isn't enough.
    #       Check out `modules/home/hyprland/hyprcursor.nix` instead!
    # cursorTheme = {
    #   name = "catppuccin-macchiato-teal-cursors";
    #   package = pkgs.catppuccin-cursors.macchiatoTeal;
    # };

    iconTheme = {
      name = "Papirus-Adapta-Nokto-Maia";
      package = pkgs.papirus-maia-icon-theme;
    };

    theme = (import ./materiaGtkTheme.nix { inherit pkgs; }) { scheme = config.colorScheme; };
  };

  # Configure QT to use Kvantum with the Adapta Dark theme, which will look close to the GTK theme.
  qt = {
    enable = true;
    style.name = "kvantum";
    platformTheme.name = "qtct";
  };

  xdg.configFile."Kvantum/kvantum.kvconfig".text = ''
    [General]
    theme=KvAdaptaDark
  '';

  home.packages = with pkgs; [
    qt6Packages.qtstyleplugin-kvantum
    qt6.qtwayland
    adapta-kde-theme
  ];
}
