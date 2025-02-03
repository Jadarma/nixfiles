{ config, lib, ... }:
let cfg = config.nixfiles.home.programs.zathura; in {
  options = {
    nixfiles.home.programs.zathura = {
      enable = lib.mkEnableOption "Zathura (Minimalist PDF Viewer)";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.zathura = {
      enable = true;

      mappings = {
        b = "toggle_statusbar";
      };

      options = with config.colorScheme.palette; {

        # girara
        n-completion-items = 15;
        completion-bg = "#${base00}";
        completion-fg = "#${base04}";
        completion-group-bg = "#${base01}";
        completion-group-fg = "#${base04}";
        completion-highlight-bg = "#${accent}";
        completion-highlight-fg = "#${base00}";
        default-bg = "#${base00}";
        default-fg = "#${base04}";
        exec-command = "";
        font = "monospace normal 14";
        guioptions = "shv";
        inputbar-bg = "#${base02}";
        inputbar-fg = "#${accent}";
        notification-bg = "#${base02}";
        notification-fg = "#${base04}";
        notification-error-bg = "#${base08}";
        notification-error-fg = "#${base00}";
        notification-warning-bg = "#${base0A}";
        notification-warning-fg = "#${base00}";
        statusbar-bg = "#${base01}";
        statusbar-fg = "#${base04}";
        statusbar-h-padding = 8;
        statusbar-v-padding = 8;
        window-icon = "";
        window-height = 600;
        window-width = 800;

        # zathura
        abort-clear-search = true;
        adjust-open = "best-fit";
        advance-pages-per-row = false;
        continuous-hist-save = false;
        database = "sqlite";
        dbus-raise-window = true;
        dbus-service = true;
        double-click-follow = true;
        filemonitor = "glib";
        first-page-column = "1:1";
        highlight-active-color = "rgba(195,232,141,0.5)"; # base0B 50% - Transparency doesn't work with hex values :(
        highlight-color = "rgba(255,203,107,0.2)"; # base0A 20%
        highlight-fg = "#${base0B}";
        highlighter-modifier = "shift";
        incremental-search = true;
        index-active-bg = "#${accent}";
        index-active-fg = "#${base00}";
        index-bg = "#${base00}";
        index-fg = "#${base04}";
        link-hadjust = true;
        link-zoom = true;
        page-cache-size = 30;
        page-padding = 8;
        page-right-to-left = false;
        page-thumbnail-size = 4194304;
        pages-per-row = 1;
        recolor = true;
        recolor-darkcolor = "#${base07}";
        recolor-keephue = false;
        recolor-lightcolor = "#${base00}";
        recolor-reverse-video = true;
        render-loading = true;
        render-loading-bg = "#${base00}";
        render-loading-fg = "#${base04}";
        sandbox = "none";
        scroll-full-overlap = 0;
        scroll-hstep = -1;
        scroll-step = 40;
        scroll-page-aware = false;
        scroll-wrap = false;
        search-hadjust = true;
        selection-clipboard = "clipboard";
        selection-notification = false;
        signature-error-color = "#${base07}";
        signature-success-color = "#${base0B}";
        signature-warning-color = "#${base09}";
        show-directories = true;
        show-hidden = false;
        show-recent = 10;
        show-signature-information = true;
        statusbar-basename = false;
        statusbar-home-tilde = true;
        statusbar-page-percent = false;
        synctex = true;
        synctex-edit-modifier = "ctrl";
        synctex-editor-command = "";
        vertical-center = false;
        window-icon-document = false;
        window-title-basename = false;
        window-title-home-tilde = true;
        window-title-page = false;
        zoom-center = false;
        zoom-max = 1000;
        zoom-min = 10;
        zoom-step = 10;
      };
    };
  };
}
