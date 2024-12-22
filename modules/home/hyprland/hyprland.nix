{ lib, ... }: {
  wayland.windowManager.hyprland.settings = {

    # TODO: Use color scheme variables for the colors.
    # Colors
    "$background" = "rgb(263238)";
    "$accent" = "rgb(16a085)";
    "$darkest" = "rgb(1b2529)";
    "$shadow" = "rgba(1b2529ee)";
    "$shadow_active" = "rgba(16a08511)";
    "$anim_speed" = 4;

    general = {
      layout = "master";

      border_size = 2;

      gaps_in = 5;
      gaps_out = 10;
      gaps_workspaces = 5;

      allow_tearing = false;

      "col.active_border" = "$accent";
      "col.inactive_border" = "$darkest";
    };

    animations = {
      enabled = true;

      bezier = [
        "easeOutQuart, 0.25, 1, 0.5, 1"
      ];

      animation = [
        "global          , 1, 4  , easeOutQuart"
        "windowsOut      , 1, 4  , easeOutQuart, popin 25%"
        "windowsIn       , 1, 4  , easeOutQuart, popin 25%"
        "windowsMove     , 1, 2.5, easeOutQuart, slide"
        "layers          , 1, 2  , easeOutQuart, fade"
        "fade            , 1, 2  , easeOutQuart"
        "border          , 1, 1  , easeOutQuart"
        "specialWorkspace, 1, 4  , easeOutQuart, slidevert"
      ];
    };

    decoration = {
      rounding = 4;

      shadow = {
        enabled = true;
        range = 10;
        render_power = 1;
        offset = "2 4";

        color = "$shadow_active";
        color_inactive = "$shadow";
      };

      blur = {
        enabled = true;
        size = 3;
        passes = 1;
        special = true;
        vibrancy = 0.1696;
      };
    };

    input = {
      follow_mouse = 1;
      mouse_refocus = false;
      numlock_by_default = true;
      kb_layout = "ro";
    };

    cursor = {
      inactive_timeout = 15;
    };

    dwindle = {
      pseudotile = true;
      preserve_split = true;
      force_split = 2;
      smart_split = 0;
    };

    master = {
      mfact = 0.5;
      orientation = "left";
      new_status = "slave";
      inherit_fullscreen = true;
    };

    monitor = lib.mkDefault ",preffered,auto,auto";

    misc = {
      background_color = "$background";
      disable_hyprland_logo = true;
      disable_splash_rendering = true;
      force_default_wallpaper = 0;

      animate_manual_resizes = 1;
      animate_mouse_windowdragging = 1;

      focus_on_activate = true;
      new_window_takes_over_fullscreen = 2;
      mouse_move_enables_dpms = true;
      key_press_enables_dpms = true;
    };

    layerrule = [
      "animation slide, notifications"
    ];

    # Regular binds.
    bindd = [
      "SUPER + SHIFT, Q, Close active window., killactive"

      # Layouts
      "SUPER        , L, Switch to dwindle layout.             , exec, hyprctl keyword general:layout \"dwindle\""
      "SUPER + SHIFT, L, Switch to master layout.              , exec, hyprctl keyword general:layout \"master\""
      "SUPER        , F, Switch to fullscreen mode.            , fullscreen, 0"
      "SUPER        , M, Switch to monocle mode.               , fullscreen, 1"
      "SUPER        , R, Toggle split in dwindle layout.       , togglesplit"
      "SUPER        , V, Toggle floating the active window.    , togglefloating, active"
      "SUPER + SHIFT, V, Toggle pinning active floating window., pin, active"
      "SUPER        , P, Toggle pseudotiling for active window., pseudo"

      # Workspace switching.
      "SUPER        , 1         , Move to workspace 1.           , workspace, 1"
      "SUPER        , 2         , Move to workspace 2.           , workspace, 2"
      "SUPER        , 3         , Move to workspace 3.           , workspace, 3"
      "SUPER        , 4         , Move to workspace 4.           , workspace, 4"
      "SUPER        , 5         , Move to workspace 5.           , workspace, 5"
      "SUPER        , 6         , Move to workspace 6.           , workspace, 6"
      "SUPER        , 7         , Move to workspace 7.           , workspace, 7"
      "SUPER        , 8         , Move to workspace 8.           , workspace, 8"
      "SUPER        , 9         , Move to workspace 9.           , workspace, 9"
      "SUPER + CTRL , left      , Move to the previous workspace., workspace, r-1"
      "SUPER        , mouse_up  , Move to the previous workspace., workspace, e-1"
      "SUPER + CTRL , right     , Move to the next workspace.    , workspace, r+1"
      "SUPER        , mouse_down, Move to the previous workspace., workspace, e+1"
      "SUPER        , grave     , Show or hide the scratchpad.   , togglespecialworkspace, magic"

      # Window Focusing
      "SUPER      , left , Move focus towards the window to the left. , movefocus, l"
      "SUPER      , right, Move focus towards the window to the right., movefocus, r"
      "SUPER      , up   , Move focus towards the window above.       , movefocus, u"
      "SUPER      , down , Move focus towards the window below.       , movefocus, d"
      "ALT        , tab  , Move focus to the next window.             , cyclenext"
      "ALT + SHIFT, tab  , Move focus to the previous window.         , cyclenext, prev"

      # Window Moving
      "SUPER + SHIFT       , left , Swap active window with leftwards window. , swapwindow, l"
      "SUPER + SHIFT       , right, Swap active window with rightwards window., swapwindow, r"
      "SUPER + SHIFT       , up   , Swap active window with the window above. , swapwindow, u"
      "SUPER + SHIFT       , down , Swap active window with the window below. , swapwindow, d"
      "SUPER + SHIFT       , 1    , Move window to workspace 1.               , movetoworkspace, 1"
      "SUPER + SHIFT       , 2    , Move window to workspace 2.               , movetoworkspace, 2"
      "SUPER + SHIFT       , 3    , Move window to workspace 3.               , movetoworkspace, 3"
      "SUPER + SHIFT       , 4    , Move window to workspace 4.               , movetoworkspace, 4"
      "SUPER + SHIFT       , 5    , Move window to workspace 5.               , movetoworkspace, 5"
      "SUPER + SHIFT       , 6    , Move window to workspace 6.               , movetoworkspace, 6"
      "SUPER + SHIFT       , 7    , Move window to workspace 7.               , movetoworkspace, 7"
      "SUPER + SHIFT       , 8    , Move window to workspace 8.               , movetoworkspace, 8"
      "SUPER + SHIFT       , 9    , Move window to workspace 9.               , movetoworkspace, 9"
      "SUPER + SHIFT       , grave, Move window to scratchpad.                , movetoworkspace, special:magic"
      "SUPER + SHIFT + CTRL, left , Move window to previous workspace.        , movetoworkspace, r-1"
      "SUPER + SHIFT + CTRL, right, Move window to next workspace.            , movetoworkspace, r+1"
    ];

    # Repeatable binds.
    bindde = [
      "SUPER + ALT, right, Increase the horizontal size of the active window., resizeactive, 25 0"
      "SUPER + ALT, left , Decrease the horizontal size of the active window., resizeactive, -25 0"
      "SUPER + ALT, up   , Increase the vertical size of the active window.  , resizeactive, 0 -25"
      "SUPER + ALT, down , Decrease the vertical size of the active window.  , resizeactive, 0 25"
    ];

    # Mouse binds.
    binddm = [
      "SUPER, mouse:272, Move active window via mouse dragging.  , movewindow"
      "SUPER, mouse:273, Resize active window via mouse dragging., resizewindow"
    ];

  };

  # Extra config pasted as-is to the end of the configuration file.
  # Useful for stuff where order matters, such as binding submaps.
  wayland.windowManager.hyprland.extraConfig = ''
    # Replacement for Smart Gaps.
    workspace = w[tv1], gapsout:0, gapsin:0
    workspace = f[1], gapsout:0, gapsin:0
    windowrulev2 = bordersize 0, floating:0, onworkspace:w[tv1]
    windowrulev2 = rounding 0, floating:0, onworkspace:w[tv1]
    windowrulev2 = bordersize 0, floating:0, onworkspace:f[1]
    windowrulev2 = rounding 0, floating:0, onworkspace:f[1]
  '';
}
