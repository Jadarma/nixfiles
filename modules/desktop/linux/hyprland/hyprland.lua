-- CONFIG
hl.config({

    general = {
        border_size = 2,
        gaps_in = 5,
        gaps_out = 10,
        gaps_workspaces = 5,
        float_gaps = 5,

        layout = "dwindle",

        no_focus_fallback = false,
        resize_on_border = true,
        extend_border_grab_area = 15,
        hover_icon_on_border = true,

        allow_tearing = false,
        resize_corner = 3,

        snap = {
            enabled = true,
            window_gap = 10,
            monitor_gap = 10,
            border_overlap = false,
            respect_gaps = true,
        },
    },

    dwindle = {
        preserve_split = true,
        force_split = 2,
        smart_split = false,
    },

    master = {
        mfact = 0.5,
        new_status = "slave",
        orientation = "left",
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
        workspace_wraparound = true,
    },

    input = {
        kb_layout = "ro",
        numlock_by_default = true,
        follow_mouse = 1,
        mouse_refocus = false,
    },

    misc = {
        disable_hyprland_logo = true,
        disable_splash_rendering = true,
        mouse_move_enables_dpms = true,
        key_press_enables_dpms = true,
        animate_manual_resizes = true,
    },

    binds = {
        allow_workspace_cycles = true,
        workspace_center_on = 1,
        movefocus_cycles_fullscreen = false,
        window_direction_monitor_fallback = true,
        allow_pin_fullscreen = true,
        drag_threshold = 10,
    },

    cursor = {
        inactive_timeout = 15,
    },

    ecosystem = {
        no_update_news = false,
        no_donation_nag = true,
    },
})

-- ANIMATIONS ---------------------------------------------------------------------------------------------------------
hl.curve("easeOutQuart", { type = "bezier", points = { { 0.25, 1.0 }, { 0.5, 1.0 } } })

hl.animation({ leaf = "global"           , enabled = true, speed = 4, bezier = "easeOutQuart",                     })
hl.animation({ leaf = "windowsOut"       , enabled = true, speed = 4, bezier = "easeOutQuart", style = "popin 25%" })
hl.animation({ leaf = "windowsIn"        , enabled = true, speed = 4, bezier = "easeOutQuart", style = "popin 25%" })
hl.animation({ leaf = "windowsMove"      , enabled = true, speed = 2, bezier = "easeOutQuart", style = "slide"     })
hl.animation({ leaf = "layers"           , enabled = true, speed = 2, bezier = "easeOutQuart", style = "fade"      })
hl.animation({ leaf = "fade"             , enabled = true, speed = 2, bezier = "easeOutQuart",                     })
hl.animation({ leaf = "border"           , enabled = true, speed = 1, bezier = "easeOutQuart",                     })
hl.animation({ leaf = "specialWorkspace" , enabled = true, speed = 4, bezier = "easeOutQuart", style = "slidevert" })

-- KEYBINDINGS --------------------------------------------------------------------------------------------------------

hl.bind("SUPER + SHIFT + Q", hl.dsp.window.close()     , { description = "Close active window." })
hl.bind("SUPER + F"        , hl.dsp.window.fullscreen(), { description = "Put the focused windo in full-screen." })

-- Layouts

hl.bind(
    "SUPER + L",
    function() hl.config({ general = { layout = "dwindle" } }) end,
    { description = "Switch to dwindle layout." }
)

hl.bind(
    "SUPER + SHIFT + L",
    function() hl.config({ general = { layout = "master" } }) end,
    { description = "Switch to master layout." }
)

hl.bind(
    "SUPER + M",
    function() hl.config({ general = { layout = "monocle" } }) end,
    { description = "Switch to dwindle layout." }
)

hl.bind(
    "SUPER + R",
    hl.dsp.layout("togglesplit"),
    { description = "Toggle split (in dwindle layout)" }
)

hl.bind(
    "SUPER + V",
    hl.dsp.window.float({ action = "toggle" }),
    { description = "Toggle floating for the active window." }
)

hl.bind(
    "SUPER + SHIFT + V",
    hl.dsp.window.pin({ action = "toggle" }),
    { description = "Toggle pinning the active floating window." }
)

hl.bind(
    "SUPER + P",
    hl.dsp.window.pseudo({ action = "toggle" }),
    { description = "Toggle pseudotiling for the active window." }
)

-- Workspace Switching

for i = 1,9 do
    hl.bind(
        "SUPER + " .. i,
        hl.dsp.focus({ workspace = i }),
        { description = "Move to workspace #" .. i .. "." }
    )
    hl.bind(
        "SUPER + SHIFT + " .. i,
        hl.dsp.window.move({ workspace = i }),
        { description = "Move active window to workspace #" .. i .. "." }
    )
end

hl.bind("SUPER + left" , hl.dsp.focus({ direction = "left"  }), { description = "Move focus towards window to the left." })
hl.bind("SUPER + right", hl.dsp.focus({ direction = "right" }), { description = "Move focus towards window to the right." })
hl.bind("SUPER + up"   , hl.dsp.focus({ direction = "up"    }), { description = "Move focus towards window above." })
hl.bind("SUPER + down" , hl.dsp.focus({ direction = "down"  }), { description = "Move focus towards window below." })

hl.bind("SUPER + SHIFT + left" , hl.dsp.window.swap({ direction = "left"  }), { description = "Swap active window with window to the left." })
hl.bind("SUPER + SHIFT + right", hl.dsp.window.swap({ direction = "right" }), { description = "Swap active window with window to the right." })
hl.bind("SUPER + SHIFT + up"   , hl.dsp.window.swap({ direction = "up"    }), { description = "Swap active window with window above." })
hl.bind("SUPER + SHIFT +down"  , hl.dsp.window.swap({ direction = "down"  }), { description = "Swap active window with window below." })

hl.bind("SUPER + CTRL + left" , hl.dsp.focus({ workspace = "r-1" }), { description = "Move to the previous workspace." })
hl.bind("SUPER + CTRL + right", hl.dsp.focus({ workspace = "r+1" }), { description = "Move to the next workspace." })

-- Resizing
hl.bind("SUPER + ALT + right", hl.dsp.window.resize({ x = 25 , y = 0  , relative = true}), { description = "Increase the horizontal size of the active window." })
hl.bind("SUPER + ALT + left" , hl.dsp.window.resize({ x = -25, y = 0  , relative = true}), { description = "Decrease the horizontal size of the active window." })
hl.bind("SUPER + ALT + up"   , hl.dsp.window.resize({ x = 0  , y = -25, relative = true}), { description = "Increase the vertical size of the active window." })
hl.bind("SUPER + ALT + down" , hl.dsp.window.resize({ x = 0  , y = 25 , relative = true}), { description = "Decrease the vertical size of the active window." })

-- Mouse bindings
hl.bind("SUPER + mouse:272", hl.dsp.window.drag()  , { mouse = true, description = "Drag and move active window." })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true, description = "Drag and resize active window." })

hl.bind("SUPER + mouse_up"    , hl.dsp.focus({ workspace = "e-1" }), { description = "Move to the previous workspace." })
hl.bind("SUPER + mouse_down"  , hl.dsp.focus({ workspace = "e+1" }), { description = "Move to the next workspace." })

-- LAYER RULES --------------------------------------------------------------------------------------------------------

hl.layer_rule({
    name = "Notification slide";
    match = { namespace = "notifications"; };
    animation = "slide";
})

hl.workspace_rule({ workspace = "w[tv1]s[false]", gaps_out = 0, gaps_in = 0 })
hl.workspace_rule({ workspace = "f[1]s[false]", gaps_out = 0, gaps_in = 0 })
hl.window_rule({ match = { float = false, workspace = "w[tv1]s[false]" }, border_size = 0, rounding = 0 })
hl.window_rule({ match = { float = false, workspace = "f[1]s[false]" }, border_size = 0, rounding = 0 })

