{ config, lib, ... }:
let cfg = config.nixfiles.home.gaming; in {

  config = lib.mkIf cfg.enable {
    # TODO: Follow https://github.com/flightlessmango/MangoHud/issues/1283
    programs.mangohud = {
      enable = true;

      settings = with config.colorScheme.palette; {
        # Bindings
        reload_cfg = "Shift_L+F4";
        toggle_fps_limit = "Shift_L+F1"; # Note: Does nothing when running via GameScope.
        toggle_logging = "Shift_L+F2";
        toggle_hud = "Shift_R+F12";
        toggle_hud_position = "Shift_R+F11";

        # Theme
        cellpadding_y = 0;
        alpha = 1.0;

        text_color = base04;
        text_outline = true;
        text_outline_thickness = 1.0;

        background_color = base00;

        gpu_color = base0B;
        frametime_color = base0B;
        cpu_color = base0D;
        ram_color = base0E;
        vram_color = base0E;
        engine_color = base09;
        wine_color = base0C;
        io_color = base0C;
        network_color = base0C;
        battery_color = base04;
        media_player_color = base04;

        cpu_load_change = true;
        cpu_load_value = "70,90";
        cpu_load_color = "${base0B},${base0A},${base08}";

        gpu_load_change = true;
        gpu_load_value = "50,80";
        gpu_load_color = "${base0B},${base0A},${base08}";

        fps_color_change = true;
        fps_value = "60,120";
        fps_color = "${base08},${base0A},${base0B}";

        # FPS
        fps_sampling_period = 1000;
        fps_limit = "144,120,90,60,0";
        fps_limit_method = "early";

        # Other
        permit_upload = false;
        preset = "0,1,2";
      };
    };

    xdg.configFile."MangoHud/presets.conf" = {
      source = ./presets.conf;
      force = true;
    };
  };
}
