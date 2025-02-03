# Build a custom Materia theme.
# Specialized version of: https://github.com/Misterio77/nix-colors/blob/f84b4255d2c635c97378af20fa704561b9247435/lib/contrib/gtk-theme.nix
# Also probably useful, to test the theme once installed: `nix-shell -p gtk3.dev --run gtk3-widget-factory`
{ pkgs }:
{ scheme }:

let
  materiaTheme = with scheme; {
    name = "Materia-${slug}";
    inherit variant;

    background = palette.base00;
    foreground = palette.base05;

    menuBackground = palette.base01;
    menuForeground = palette.base05;

    surface = palette.base02;
    view = palette.base01;

    accent = if (palette ? accent) then palette.accent else palette.base0D;

    visited = palette.base0E;
    error = palette.base08;
    success = palette.base0B;
    warning = palette.base09;
  };
  rendersvg = pkgs.runCommand "rendersvg" { } ''
    mkdir -p $out/bin
    ln -s ${pkgs.resvg}/bin/resvg $out/bin/rendersvg
  '';
  materiaThemePackage = pkgs.stdenv.mkDerivation {
    name = "materia-${scheme.slug}";
    src = pkgs.fetchFromGitHub {
      owner = "nana-4";
      repo = "materia-theme";
      rev = "d7f59a37ef51f893c28b55dc344146e04b2cd52c";
      sha256 = "sha256-PnpFAmKEpfg3wBwShLYviZybWQQltcw7fpsQkTUZtww=";
    };
    buildInputs = with pkgs; [
      bc
      gtk4.dev
      meson
      ninja
      nodePackages.sass
      optipng
      rendersvg
      sassc
      which
    ];
    phases = [ "unpackPhase" "installPhase" ];
    installPhase = ''
      HOME=/build
      chmod 777 -R .
      patchShebangs .
      mkdir -p $out/share/themes
      mkdir bin
      sed -e 's/handle-horz-.*//' -e 's/handle-vert-.*//' -i ./src/gtk-2.0/assets.txt

      cat > /build/gtk-colors << EOF
        MATERIA_STYLE_COMPACT=true
        MATERIA_COLOR_VARIANT=${materiaTheme.variant}

        MATERIA_SURFACE=${materiaTheme.surface}
        MATERIA_VIEW=${materiaTheme.view}

        BG=${materiaTheme.background}
        FG=${materiaTheme.foreground}

        HDR_BG=${materiaTheme.menuBackground}
        HDR_FG=${materiaTheme.menuForeground}

        SEL_BG=${materiaTheme.accent}

        TERMINAL_COLOR5=${materiaTheme.visited}
        TERMINAL_COLOR9=${materiaTheme.error}
        TERMINAL_COLOR10=${materiaTheme.success}
        TERMINAL_COLOR11=${materiaTheme.warning}
      EOF

      echo "Changing colours:"
      ./change_color.sh --inkscape false --target "$out/share/themes" --output ${materiaTheme.name} /build/gtk-colors
      chmod 555 -R .
    '';
  };
in
{
  name = materiaTheme.name;
  package = materiaThemePackage;
}
