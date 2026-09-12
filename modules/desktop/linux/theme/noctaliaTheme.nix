# Configures Noctalia with a custom theme.
{ scheme }: with scheme.palette;
{
  dark = {
    mPrimary = "#${accent}";
    mOnPrimary = "#${base01}";
    mSecondary = "#${base0B}";
    mOnSecondary = "#${base01}";
    mTertiary = "#${base0D}";
    mOnTertiary = "#${base01}";
    mError = "#${base0F}";
    mOnError = "#${base00}";

    mSurface = "#${base00}";
    mOnSurface = "#${base05}";
    mSurfaceVariant = "#${base02}";
    mOnSurfaceVariant = "#${base04}";

    mOutline = "#${base01}";
    mShadow = "#${shadow}";
    # TODO: These seem to not do anything. Noctalia instead uses tertiary, so adopt the behavior for now.
    mHover = "#${base0D}";
    mOnHover = "#${base01}";

    terminal = rec {

      backgroud = "#${base00}";
      foreground = "#${base05}";
      cursor = "#${base07}";
      cursorText = "#${base00}";
      selectionBg = "#${base05}";
      selectionFg = "#${base00}";

      normal = {
        black = "#${base03}";
        red = "#${base08}";
        green = "#${base0B}";
        yellow = "#${base0A}";
        blue = "#${base0D}";
        magenta = "#${base0E}";
        cyan = "#${base0C}";
        white = "#${base05}";
      };

      bright = normal;
    };
  };
}
