{ config, lib, pkgs, ... }:
let cfg = config.nixfiles.home.programs.ghostty; in {

  config = lib.mkIf cfg.enable {
    programs.ghostty = {
      # Ghostty package is broken for darwin. Install instead from Homebrew.
      package = lib.mkDefault pkgs.hello;

      settings = {
        auto-update = "off";
        fullscreen = true;

        font-size = lib.mkDefault 20;

        macos-icon = "custom-style";
        macos-icon-ghost-color = "#${config.colorScheme.palette.accent}";
        macos-icon-screen-color = "#${config.colorScheme.palette.base00}";
        macos-icon-frame = "aluminum"; # It's aluminium!

        keybind = [
          # Window Management
          "super+f=toggle_fullscreen"

          # Utility
          "super+c=copy_to_clipboard"
          "super+v=paste_from_clipboard"
        ];
      };
    };
  };
}
