{
  lib,
  config,
  osConfig,
  pkgs,
  ...
}:
lib.mkIf (osConfig.nixfiles.desktop.enable && pkgs.stdenv.hostPlatform.isLinux) {

  # Cursor theme.
  home.pointerCursor = {
    package = pkgs.catppuccin-cursors.macchiatoTeal;
    name = "catppuccin-macchiato-teal-cursors";
    size = 32;
    gtk.enable = true;
    hyprcursor.enable = true;
  };

  # Use custom theme for Noctalia.
  programs.noctalia = {

    customPalettes.nixfiles = (import ./noctaliaTheme.nix) { scheme = config.colorScheme; };

    settings.theme = {
      mode = "dark";
      source = "custom";
      custom_palette = "nixfiles";

      templates = {
        enable_builtin_templates = false;
        enable_community_templates = false;
      };
    };
  };

  # Use custom theme for Hyprland.
  wayland.windowManager.hyprland.settings.config = with config.colorScheme.palette; {
    misc.background_color = "rgb(${base00})";
    general.col = {
      active_border = "rgb(${accent})";
      inactive_border = "rgb(${base01})";
    };
    decoration.shadow = {
      color = "rgba(${accent}11)";
      color_inactive = "rgba(${shadow}ee)";
    };
  };

  # Configure the GTK Theme.
  # Note that while you could use `nix-colors` to autogenerate a Materia GTK theme, I found that the color scheme is a bit off.
  # Since I don't plan on ever changing away from the Material theme, use the proper Adapta theme, which will also make it easier to align with QT apps.
  gtk = {
    enable = true;

    iconTheme = {
      name = "Papirus-Adapta-Nokto-Maia";
      package = pkgs.papirus-maia-icon-theme;
    };

    theme = (import ./materiaGtkTheme.nix { inherit pkgs; }) { scheme = config.colorScheme; };

    # TODO: State version 26.05 changed this behavior. Keep current behavior and investigate later.
    gtk4.theme = config.gtk.theme;
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

  # Color picker.
  wayland.windowManager.hyprland.settings.bind = [
    {
      _args = [
        "SUPER + CONTROL + C"
        (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("hyprpicker --autocopy --no-fancy --format=hex")'')
      ];
    }
  ];

  # Required package dependencies.
  home.packages = with pkgs; [
    qt6Packages.qtstyleplugin-kvantum
    qt6.qtwayland
    adapta-kde-theme
    hyprpicker
  ];
}
