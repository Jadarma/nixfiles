{ config, lib, ... }:
let cfg = config.nixfiles.common.cli; in {
  options = {
    nixfiles.common.cli.bat = {
      enable = lib.mkEnableOption "Better Cat (Bat)";
    };
  };

  config = lib.mkIf (cfg.enable && cfg.bat.enable) {
    programs.bat = {
      enable = true;

      config = {
        # Defer the color theme to the terminal.
        theme = "base16";

        # Configure how special characters are displayed. Note the italic-text refers to the ANSI decorators.
        tabs = "4";
        nonprintable-notation = "unicode";
        italic-text = "always";

        # Configure paging. A pager will automatically be used if the output cannot fit in the terminal.
        paging = "auto";
        pager = "less";

        # Apply stylings, but only when not piping.
        style = "numbers,header";
        decorations = "auto";
        color = "auto";
      };
    };
  };
}
