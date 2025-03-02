{ config, lib, ... }:
let cfg = config.nixfiles.home.programs.ghostty; in {
  options = {
    nixfiles.home.programs.ghostty = {
      enable = lib.mkEnableOption "Ghostty (Terminal)";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.ghostty = {
      enable = true;

      clearDefaultKeybinds = true;
      enableZshIntegration = true;
      enableBashIntegration = true;
      installBatSyntax = false;
      installVimSyntax = false;

      settings = {

        theme = "nixfiles";
        selection-invert-fg-bg = true;
        cursor-style = "block";
        shell-integration-features = "no-cursor";
        window-padding-x = 16;
        window-padding-y = 16;
        window-vsync = true;
        resize-overlay = "never";
        confirm-close-surface = false;

        font-family = "JetBrains Mono";
        font-size = lib.mkOptionDefault 12;
        font-thicken = true;
        font-thicken-strength = 128;
        font-feature = [
          "+calt"
          "+liga"
          "+dlig"
        ];

        keybind = [
          # Maintenance
          "ctrl+shift+r=reload_config"
          "ctrl+alt+i=inspector:toggle"

          # Window Management
          "super+shift+q=quit"
          "ctrl+w=close_surface"
          "ctrl+shift+w=close_tab"

          "ctrl+n=new_tab"
          "ctrl+shift+n=new_window"

          "ctrl+tab=next_tab"
          "ctrl+shift+tab=previous_tab"
          "alt+right=next_tab"
          "alt+left=previous_tab"
          "alt+shift+right=move_tab:1"
          "alt+shift+left=move_tab:-1"

          "alt+physical:one=goto_tab:1"
          "alt+physical:two=goto_tab:2"
          "alt+physical:three=goto_tab:3"
          "alt+physical:four=goto_tab:4"
          "alt+physical:five=goto_tab:5"
          "alt+physical:six=goto_tab:6"
          "alt+physical:seven=goto_tab:7"
          "alt+physical:eight=goto_tab:8"
          "alt+physical:nine=goto_tab:9"

          # Split Management
          "ctrl+t=new_split:right"
          "ctrl+shift+t=new_split:down"
          "ctrl+shift+up=goto_split:up"
          "ctrl+shift+down=goto_split:down"
          "ctrl+shift+left=goto_split:left"
          "ctrl+shift+right=goto_split:right"
          "ctrl+alt+up=resize_split:up,10"
          "ctrl+alt+down=resize_split:down,10"
          "ctrl+alt+left=resize_split:left,10"
          "ctrl+alt+right=resize_split:right,10"
          "ctrl+alt+equal=equalize_splits"
          "ctrl+f=toggle_split_zoom"

          # Cursor Navigation
          "ctrl+home=scroll_to_top"
          "home=scroll_to_top"
          "end=scroll_to_bottom"
          "page_up=scroll_page_up"
          "page_down=scroll_page_down"

          "alt+left=text:\x1B\x62"
          "alt+right=text:\x1B\x66"
          "alt+shift+left=text:\x01"
          "alt+shift+right=text:\x05"

          "ctrl+shift+l=clear_screen"

          # Utility
          "ctrl+a=select_all"
          "ctrl+shift+c=copy_to_clipboard"
          "ctrl+shift+v=paste_from_clipboard"
          "ctrl+equal=increase_font_size:1"
          "ctrl+minus=decrease_font_size:1"
          "ctrl+shift+equal=reset_font_size"
        ];
      };

      themes."nixfiles" = with config.colorScheme.palette; {
        background = "#${base00}";
        foreground = "#${base05}";
        cursor-color = "#${base05}";
        cursor-text = "#${base00}";
        selection-background = "#${base05}";
        selection-foreground = "#${base00}";
        palette = [
          "0=#${base03}"
          "8=#${base03}"
          "1=#${base08}"
          "9=#${base08}"
          "2=#${base0B}"
          "10=#${base0B}"
          "3=#${base0A}"
          "11=#${base0A}"
          "4=#${base0D}"
          "12=#${base0D}"
          "5=#${base0E}"
          "13=#${base0E}"
          "6=#${base0C}"
          "14=#${base0C}"
          "7=#${base05}"
          "15=#${base05}"
        ];
      };
    };

    # Update environment to specify which terminal is used.
    home.sessionVariables.TERMINAL = "ghostty";

    # Hyprland integration (Linux Only)
    wayland.windowManager.hyprland.settings = {
      exec-once = [
        "ghostty --gtk-single-instance=true --quit-after-last-window-closed=false --initial-window=false"
      ];
      bind = [
        "SUPER, RETURN, exec, ghostty --gtk-single-instance=true"
      ];
    };
  };
}
