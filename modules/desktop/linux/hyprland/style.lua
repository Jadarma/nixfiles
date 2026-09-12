hl.config({
    general = {
        border_size = 2,
        gaps_in = 5,
        gaps_out = 10,
        gaps_workspaces = 5,
        float_gaps = 5,

        snap = {
            enabled = true,
            window_gap = 10,
            monitor_gap = 10,
            border_overlap = false,
            respect_gaps = true,
        },
    },

    decoration = {
        rounding = 2,
        rounding_power = 2.0,
        active_opacity = 1.0,
        inactive_opacity = 1.0,
        fullscreen_opacity = 1.0,
        dim_modal = true,
        dim_inactive = false,
        dim_strength = 0.2,
        dim_special = 0.2,
        dim_around = 0.4,
        border_part_of_window = true,

        blur = {
            enabled = true,
            size = 3,
            passes = 1,
            ignore_opacity = false,
        },

        shadow = {
            enabled = true,
            range = 10,
            render_power = 1,
            offset = { 2, 4 },
            scale = 1.0,
        }
    },

    animations = {
        enabled = true,
    },

    misc = {
        disable_hyprland_logo = true,
        disable_splash_rendering = true,
    },
})

hl.curve("easeOutQuart", { type = "bezier", points = { { 0.25, 1.0 }, { 0.5, 1.0 } } })
hl.animation({ leaf = "global", enabled = true, speed = 2.5, bezier = "easeOutQuart" })
