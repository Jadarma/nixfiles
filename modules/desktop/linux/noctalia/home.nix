{
  lib,
  config,
  osConfig,
  pkgs,
  ...
}:
lib.mkIf (osConfig.nixfiles.desktop.enable && pkgs.stdenv.hostPlatform.isLinux) {

  programs.noctalia = {
    enable = true;

    # Noctalia is already installed system-wide. The HM module only coveres configuration.
    package = null;

    checkConfig = true;
  };

  wayland.windowManager.hyprland.settings = {

    # Start Noctalia with Hyprland.
    on = [
      {
        _args = [
          "hyprland.start"
          (lib.generators.mkLuaInline ''
            function()
              hl.exec_cmd("noctalia")
            end
          '')
        ];
      }
    ];

    # Keybinds
    bind =
      let
        hotkeys = [
          {
            keys = "SUPER + escape";
            ipcCommand = "panel-toggle session";
            description = "Open the power menu.";
          }
          {
            keys = "SUPER + D";
            ipcCommand = "panel-toggle launcher";
            description = "Open the application launcher.";
          }
          {
            keys = "SUPER + Tab";
            ipcCommand = "panel-toggle control-center";
            description = "Open the control center.";
          }
          {
            keys = "ALT + Tab";
            ipcCommand = "window-switcher";
            description = "Switch between windows.";
          }
          {
            keys = "SUPER + SHIFT + S";
            ipcCommand = "screenshot-region";
            description = "Screenshot a region";
          }
          {
            keys = "SUPER + CTRL + S";
            ipcCommand = "screenshot-annotate";
            description = "Annotate screen.";
          }
          {
            keys = "Print";
            ipcCommand = "screenshot-fullscreen pick";
            description = "Screenshot an entire display";
          }
          {
            keys = "XF86MonBrightnessUp";
            ipcCommand = "brightness-up";
            description = "Turn up the display brightness.";
            flags = {
              repeating = true;
              locked = true;
            };
          }
          {
            keys = "XF86MonBrightnessDown";
            ipcCommand = "brightness-down";
            description = "Turn down the display brightness.";
            flags = {
              repeating = true;
              locked = true;
            };
          }
        ];
        hyprFmt = it: {
          _args = [
            it.keys
            (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("noctalia msg ${it.ipcCommand}")'')
            ((it.flags or { }) // { description = it.description; })
          ];
        };
      in
      map hyprFmt hotkeys;

    layer_rule = [
      {
        name = "noctalia";
        match = {
          namespace = "^noctalia-(bar-.+|notification|dock|panel|attached-panel|osd|window-switcher)$";
        };
        no_anim = true;
        ignore_alpha = 0.5;
        blur = true;
        blur_popups = true;
      }
    ];
  };

  # TODO: Figure out a unified way to define lockscreen widgets, since they depend on monitor name and resolutions.
  #       Ideally fixed by: https://github.com/noctalia-dev/noctalia/issues/4141
  #       For now, chuck in a cleaned up version, monitor names don't clash (unless plugging ad-hoc external ones).
  xdg.configFile."noctalia/widgets.toml".source = ./widgets.toml;

  # Configure custon shell settings.
  programs.noctalia.settings = {

    desktop_widgets.enabled = true;
    hot_corners.enabled = false;
    calendar.enabled = false;

    accessibility = {
      ui_scale = 1.10;
      high_contrast = false;
    };

    control_center = {
      width = 800;
      show_session_button = true;
      show_shortcut_labels = true;

      sidebar = "full";
      sidebar_section = "compact";
      hidden_tabs = [ "screen-time" ];

      calendar = {
        show_events_card = false;
        show_week_numbers = true;
      };

      shortcuts = [
        { type = "media"; }
        { type = "caffeine"; }
        { type = "notification"; }
        { type = "nightlight"; }
        { type = "mic_mute"; }
        { type = "audio"; }
      ];
    };

    dock = {
      enabled = true;

      layer = "overlay";
      position = "bottom";
      reserve_space = false;
      auto_hide = true;
      active_monitor_only = true;

      launcher_icon = "grid-dots";
      launcher_position = "start";
      icon_size = 42;
      item_spacing = 4;
      show_dots = true;
      show_instance_count = false;

      shadow = true;
      background_opacity = 1.0;
      magnification = true;
      magnification_scale = 1.25;
      active_opacity = 1.0;
      active_scale = 1.0;
      inactive_opacity = 0.85;
      inactive_scale = 0.85;
      radius = 16;
      border_width = 0.0;
      concave_edge_corners = true;
    };

    idle = {
      pre_action_fade_seconds = 5.0;
      behavior_order = [
        "lock"
        "screen-off"
      ];

      behavior = {
        lock = {
          enabled = true;
          timeout = 300.0;
          action = "lock";
        };
        screen-off = {
          enabled = true;
          timeout = 360.0;
          locked_timeout = 60.0;
          action = "screen_off";
        };
      };
    };

    location = {
      address = lib.mkOptionDefault "Timișoara, Timiș";
      auto_locate = false;
      custom_schedule = true;
      sunrise = "07:00";
      sunset = "23:00";
    };

    lockscreen = {
      enabled = true;
      lock_before_suspend = true;
      wallpaper = "";
      blur_intensity = 0.15;
      blurred_desktop = false;
      allow_empty_password = false;
      fingerprint = false;
    };

    nightlight = {
      enabled = true;
      force = false;
      temperature_day = 6500;
      temperature_night = 4000;
    };

    notification = {
      enable_daemon = true;

      show_actions = true;
      show_app_name = true;
      max_visible = 0;
      collapse_on_dismiss = true;
      history_retention_hours = 48;
      keep_dismissed_in_history = true;

      layer = "top";
      position = "top_right";
      scale = 1.0;
      offset_x = 24;
      offset_y = 24;
      border = true;
      background_opacity = 1.0;
    };

    osd = {
      enabled = true;

      orientation = "horizontal";
      position = "bottom_right";
      position_vertical = "bottom_right";
      scale = 1.0;
      offset_x = 24;
      offset_y = 24;
      border = true;
      background_opacity = 1.0;
    };

    shell = {

      settings_show_advanced = true;
      time_format = "{:%H:%M}";
      date_format = "{:%A, %F}";
      launch_apps_as_systemd_services = true;
      animation.speed = 1.5;
      window_switcher.mru = true;

      offline_mode = false;
      telemetry_enabled = false;
      external_ip_enabled = false;
      clipboard_enabled = false;
      clipboard_keep_from_closed_apps = false;
      screen_time_enabled = false;
      setup_wizard_enabled = false;

      launcher = {
        app_grid = false;
        categories = false;
        compact = false;
        sort_by_usage = true;
        show_icons = true;
        show_app_actions = true;
        show_app_origin_indicator = false;

        provider_prefix = "/";
        providers = {
          calculator.global = false;
          calculator.prefix = "c";
          emoji.prefix = "e";
          session.prefix = "s";
        };

        auto_paste = "off";
        fetch_exchange_rates = false;
      };

      panel = {
        floating_layer = "top";
        borders = true;
        shadow = true;
        transparency_mode = "solid";
        list_item_background = false;

        control_center_placement = "attached";
        control_center_position = "center";
        launcher_placement = "attached";
        launcher_position = "center";
        session_placement = "attached";
        session_position = "auto";
        wallpaper_placement = "attached";
        wallpaper_position = "auto";
      };

      session = {
        grid = false;
        show_shortcuts = true;

        actions = [
          {
            enabled = true;
            action = "lock_and_suspend";
            label = "Suspend";
            glyph = "moon-stars";
            shortcut = "s";
          }
          {
            enabled = true;
            action = "lock";
            label = "Lock";
            glyph = "lock";
            shortcut = "l";
          }
          {
            enabled = true;
            action = "logout";
            label = "Log Off";
            glyph = "logout";
            variant = "outline";
            shortcut = "q";
          }
          {
            enabled = true;
            action = "shutdown";
            label = "Power Off";
            glyph = "power";
            variant = "destructive";
            shortcut = "p";
            countdown_seconds = 3.0;
          }
          {
            enabled = true;
            action = "reboot";
            label = "Reboot";
            glyph = "refresh";
            variant = "secondary";
            shortcut = "r";
            countdown_seconds = 3.0;
          }
          {
            enabled = true;
            action = "command";
            command = "systemctl reboot --firmware-setup";
            label = "Reboot to UEFI";
            glyph = "settings";
            variant = "outline";
            shortcut = "u";
            countdown_seconds = 3.0;
          }
        ];
      };

      screenshot = {
        copy_to_clipboard = true;
        save_to_file = true;
        directory = "${config.xdg.userDirs.extraConfig.SCREENSHOTS}";
        filename_pattern = "screenshot_%Y%m%d_%H%M%S";

        freeze_screen = true;
        show_cursor = false;
        remember_last_region = true;
        confirm_region = true;
        close_on_copy = true;
        annotate = false;
      };

      screen_corners = {
        enabled = true;
        size = 32;
      };

      shadow = {
        direction = "down";
        alpha = 0.35;
      };
    };

    system.monitor.enabled = true;

    wallpaper = {
      enabled = true;
      automation.enabled = false;

      directory = "${config.xdg.dataHome}/wallpapers";
      transition = [ "disc" ];

      default = {
        path = "${config.xdg.dataHome}/wallpapers/bg_center.png";
      };

      monitors = builtins.mapAttrs (k: v: {
        path = "${config.xdg.dataHome}/wallpapers/${v.wallpaper}";
      }) osConfig.nixfiles.desktop.monitors;
    };

    weather = {
      enabled = true;
      effects = true;
      unit = "metric";
      refresh_minutes = 30;
    };

    # Default Bar Settings
    bar = {
      order = [ "default" ];

      default = {
        enabled = true;

        margin_ends = 0;
        radius = 24;
        thickness = 38;
        widget_spacing = 8;
        capsule_thickness = 0.75;
        font_family = "JetBrainsMono NF";
        font_weight = 600;
        icon_color = "on_surface_variant";
        color = "on_surface_variant";

        start = [
          "workspaces"
          "active_window"
        ];
        center = [
          "visualizer_left"
          "clock"
          "visualizer_right"
        ];
        end = [
          "media"
          "privacy"
          "battery"
          "group:control"
          "group:sound"
          "group:stats"
          "group:connectivity"
          "group:other"
        ];

        dead_zone.actions = {
          right = "none";
        };

        capsule_group = [
          {
            id = "control";
            enabled = true;
            members = [
              "control-center"
              "brightness"
              "nightlight"
              "caffeine"
              "notifications"
              "screenshot"
            ];

            accordion = true;
            accordion_direction = "start";
            fill = "surface_variant";
            opacity = 1.0;
            padding = 6.0;
          }
          {
            id = "sound";
            enabled = true;
            members = [
              "volume"
              "input_volume"
              "output_volume"
            ];

            accordion = true;
            accordion_direction = "start";
            fill = "surface_variant";
            opacity = 1.0;
            padding = 6.0;
          }
          {
            id = "stats";
            enabled = true;
            members = [
              "sysmon"
              "cpu"
              "ram"
              "gpu"
              "power_profile"
            ];
            accordion = true;
            accordion_direction = "start";
            fill = "surface_variant";
            opacity = 1.0;
            padding = 6.0;
          }
          {
            id = "connectivity";
            enabled = true;
            members = [
              "network"
              "network_tx"
              "network_rx"
              "bluetooth"
            ];

            accordion = true;
            accordion_direction = "start";
            fill = "surface_variant";
            opacity = 1.0;
            padding = 6.0;
          }
          {
            id = "other";
            enabled = true;
            members = [
              "more"
              "tray"
              "settings"
              "session"
            ];

            accordion = true;
            accordion_direction = "start";
            fill = "surface_variant";
            opacity = 1.0;
            padding = 6.0;
          }
        ];
      };
    };

    # Custom Widget Overrides
    widget = {

      workspaces = {
        anchor = true;
        scale = 1.2;
        active_pill_size = 2.0;
        empty_color = "surface_variant";
        labels_only_when_occupied = true;
        font_weight = 800;
        scroll_repeat = "steps";
        actions.middle = "none";
      };

      active_window = {
        show_empty_label = false;
        interactive = false;
        title_scroll = "always";
        min_length = 180;
        max_length = 512;
        icon_size = 22;
      };

      clock = {
        anchor = true;
        format = "{:%H:%M}";
        tooltip_format = "{:%A, %F, %H:%M:%S}";
        font_scale = 1.15;
        capsule = true;
        capsule_fill = "surface";
        capsule_padding = 12;

        actions = {
          left = "panel-toggle control-center home";
          middle = "settings-open";
          right = "panel-toggle control-center calendar";
        };
      };

      visualizer_left = {
        type = "audio_visualizer";
        interactive = false;
        width = 64;
        bands = 32;
        color_1 = "surface_variant";
        color_2 = "primary";
        mirrored = false;
        reversed = true;
      };

      visualizer_right = {
        type = "audio_visualizer";
        interactive = false;
        width = 64;
        bands = 32;
        color_1 = "primary";
        color_2 = "surface_variant";
        mirrored = false;
        reversed = false;
      };

      more = {
        type = "custom_button";
        glyph = "dots-vertical";
        actions = {
          middle = "none";
        };
      };

      settings = {
        icon_color = "secondary";
        actions = {
          middle = "none";
        };
      };

      session = {
        icon_color = "error";
        actions = {
          middle = "none";
        };
      };

      network = {
        show_label = false;
        actions = {
          middle = "none";
        };
      };

      network_tx = {
        icon_color = "secondary";
        glyph = "arrow-move-down-filled";
        interactive = false;
        network_speed_compact = true;
      };

      network_rx = {
        icon_color = "secondary";
        glyph = "arrow-move-up-filled";
        interactive = false;
        network_speed_compact = true;
      };

      bluetooth = {
        icon_color = "secondary";
        actions = {
          middle = "none";
        };
      };

      sysmon = {
        visualization = "none";
        show_value = false;
        label_show_units = false;

        actions = {
          right = "panel-toggle control-center power";
          middle = "exec ghostty -e htop";
        };
      };

      cpu = {
        glyph = "cpu";
        icon_color = "secondary";
        interactive = false;
        stat = "cpu_usage";
      };

      ram = {
        glyph = "container";
        icon_color = "secondary";
        interactive = false;
        stat = "ram_pct";
      };

      gpu = {
        type = "sysmon";
        glyph = "gpu-usage";
        icon_color = "secondary";
        interactive = false;
        stat = "gpu_usage";
      };

      power_profile = {
        icon_color = "secondary";
        scroll_repeat = "gesture";
        actions = {
          middle = "none";
        };
      };

      volume = {
        show_label = false;
        actions = {
          middle = "exec pavucontrol";
        };
      };

      input_volume = {
        icon_color = "secondary";
        actions = {
          middle = "none";
        };
      };

      output_volume = {
        icon_color = "secondary";
        actions = {
          middle = "none";
        };
      };

      control-center = {
        glyph = "layout-dashboard";
        actions = {
          middle = "none";
        };
      };

      brightness = {
        icon_color = "secondary";
        show_label = false;
        actions = {
          middle = "dpms-off";
        };
      };

      nightlight = {
        icon_color = "secondary";
        actions = {
          left = "nightlight-force-toggle";
          middle = "nightlight-disable";
          right = "nightlight-toggle";
        };
      };

      caffeine = {
        icon_color = "secondary";
        actions = {
          middle = "none";
        };
      };

      notifications = {
        icon_color = "secondary";
        actions = {
          middle = "notification-clear-active";
        };
      };

      screenshot = {
        icon_color = "secondary";
        glyph = "border-corners";
        actions = {
          middle = "annotate";
        };
      };

      privacy = {
        hide_inactive = true;
        interactive = false;
        capsule = true;
        capsule_fill = "error";
        active_color = "on_error";
      };

      media = {
        hide_when_no_media = true;
        art_size = 24;
        min_length = 100;
        max_length = 256;
        title_scroll = "always";
        font_weight = 300;
        show_progress = true;
        scroll_repeat = "gesture";
      };

      battery = {
        color = "secondary";
        display_mode = "graphic";
        hide_when_full = true;
        show_label = false;
      };
    };
  };
}
