{ pkgs, config, ... }: {

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
