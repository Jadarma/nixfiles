{ pkgs, config, nix-colors, ... }: {
  imports = [
    nix-colors.homeManagerModules.default
  ];

  # Material theme, best theme.
  colorScheme = nix-colors.colorSchemes.material;

  # Configure the GTK Theme.
  # Note that while you could use `nix-colors` to autogenerate a Materia GTK theme, I found that the color scheme is a bit off.
  # Since I don't plan on ever changing away from the Material theme, use the proper Adapta theme, which will also make it easier to align with QT apps.
  gtk = {
    enable = true;

    cursorTheme = {
      name = "Catppuccin-Macchiato-Dark-Cursors";
      package = pkgs.catppuccin-cursors.macchiatoDark;
    };

    iconTheme = {
      name = "Papirus-Adapta-Nokto-Maia";
      package = pkgs.papirus-maia-icon-theme;
    };

    theme = {
      name = "Adapta-Nokto-Eta";
      package = pkgs.adapta-gtk-theme;
    };

    gtk3.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };

    gtk4.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };
  };

  home.sessionVariables.GTK_THEME = "Adapta-Nokto-Eta";

  # Configure QT to use Kvantum with the Adapta Dark theme, which will look close to the GTK theme.
  qt = {
    enable = true;
    style.name = "kvantum";
    platformTheme = "qtct";
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
