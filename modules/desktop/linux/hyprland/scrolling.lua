-- Configures Hyprland to be the ultimate scroller.
hl.config({
    general = {
        layout = "scrolling",
    },

    scrolling = {
        direction = "right",
    },
})

-- WORKSPACES ---------------------------------------------------------------------------------------------------------
-- The monitor display is an infinitely stretching 2D space.
-- The workspaces grant access to their own horizontal slice, and are stacked vertically.
-- Within each workspace, columns scroll horizontally.
-- SUPER + CTRL + <direction> allows switching between workspaces. Left-Right for monitors, Up-Down for workspaces.
-- Fittingly, the mouse can also be used to scroll between workspaces.
-----------------------------------------------------------------------------------------------------------------------
hl.config({ animations = { workspace_wraparound = false }})
hl.animation({ leaf = "workspaces", enabled = true, speed = 2.5, bezier = "easeOutQuart", style = "slidevert" })

for i = 1,9 do
    hl.bind(
        "SUPER + " .. i,
        hl.dsp.focus({ workspace = i }),
        { description = "Move to workspace #" .. i .. "." }
    )
end

hl.bind("SUPER + CTRL + left" , hl.dsp.focus({ monitor = "l"     }), { description = "Focus the next monitor to the left." })
hl.bind("SUPER + CTRL + right", hl.dsp.focus({ monitor = "r"     }), { description = "Focus the next monitor to the right." })
hl.bind("SUPER + CTRL + up"   , hl.dsp.focus({ workspace = "m-1" }), { description = "Focus the previous workspace on same monitor." })
hl.bind("SUPER + CTRL + down" , hl.dsp.focus({ workspace = "m+1" }), { description = "Focus the next workspace on same monitor." })


-- WINDOW MANAGEMENT --------------------------------------------------------------------------------------------------
-- Windows are arranged in an infinite strip made of columns. Every new window initially spawns as its own column.
-- Use SUPER + CTRL + SHIFT + <direction> to switch a window's column. If it is alone, it will be merged into the next
-- column; otherwise, the window will be pulled out of the existing column and given its own.
-- While columns are defined, windows cand be switched with SUPER + SHIFT + <direction>, noting that moving any window
-- in a column will move the entire column along.
-- Windows can also be moved outside of the current workspace, using SUPER + ALT + SHIFT + <direction>, where up-down
-- moves to the next workspace, and left-right between monitors.
-- Windows can also be sent to specific workspace By SUPER + SHIFT + [1-9].
-- A window can be closed with SUPER + SHIFT + Q.
-----------------------------------------------------------------------------------------------------------------------
hl.config({
    binds = {
        window_direction_monitor_fallback = false
    },
})

hl.bind("SUPER + SHIFT + Q"           , hl.dsp.window.close()                  , { description = "Close active window." })
hl.bind("SUPER + SHIFT + up"          , hl.dsp.window.swap({ direction = "u" }), { description = "Push active window up the column." })
hl.bind("SUPER + SHIFT + down"        , hl.dsp.window.swap({ direction = "d" }), { description = "Push active window down the column." })
hl.bind("SUPER + SHIFT + left"        , hl.dsp.layout("swapcol l")             , { description = "Push active column to the left." })
hl.bind("SUPER + SHIFT + right"       , hl.dsp.layout("swapcol r")             , { description = "Push active column to the right." })
hl.bind("SUPER + CTRL + SHIFT + left" , hl.dsp.layout("consume_or_expel prev") , { description = "Move active window in or out the column to the left." })
hl.bind("SUPER + CTRL + SHIFT + right", hl.dsp.layout("consume_or_expel next") , { description = "Move active window in or out the column to the right." })
hl.bind("SUPER + ALT + SHIFT + up"    , hl.dsp.window.move({ workspace="m-1" }), { description = "Move active window to the workspace above." })
hl.bind("SUPER + ALT + SHIFT + down"  , hl.dsp.window.move({ workspace="m+1" }), { description = "Move active window to the workspace below." })

-- TODO: Below contains a workaround for a bug. See https://github.com/hyprwm/Hyprland/discussions/16240
hl.bind(
    "SUPER + ALT + SHIFT + left",
    function() if hl.get_monitor('l') then hl.dispatch(hl.dsp.window.move({ monitor = 'l' })) end end,
    { description = "Move active window to another monitor to the left." }
)
hl.bind(
    "SUPER + ALT + SHIFT + right" ,
    function() if hl.get_monitor('r') then hl.dispatch(hl.dsp.window.move({ monitor = 'r' })) end end,
    { description = "Move active window to another monitor to the right." }
)

for i = 1,9 do
    hl.bind(
        "SUPER + SHIFT + " .. i,
        hl.dsp.window.move({ workspace = i }),
        { description = "Move active window to workspace #" .. i .. "." }
    )
end

-- WINDOW FOCUSING ----------------------------------------------------------------------------------------------------
-- Moving focus is simply SUPER + <direction>, and is fully restricted within a workspace.
-- The workspace strip does not wrap back, it only expands to fit more columns as needed.
-----------------------------------------------------------------------------------------------------------------------
hl.config({
    general = {
        no_focus_fallback = true,
    },
    scrolling = {
        wrap_focus = false,
        wrap_swapcol = false,
        follow_focus = true,
        follow_min_visible = 0.4,
    },
    binds = {
        workspace_center_on = true,
    },
});
hl.bind("SUPER + up"   , hl.dsp.focus({ direction = "up"    }), { description = "Focus window above." })
hl.bind("SUPER + down" , hl.dsp.focus({ direction = "down"  }), { description = "Focus window below." })
hl.bind("SUPER + left" , hl.dsp.layout("focus left")          , { description = "Focus window to the left." })
hl.bind("SUPER + right", hl.dsp.layout("focus right")         , { description = "Focus window to the right." })

-- WINDOW RESIZING ----------------------------------------------------------------------------------------------------
-- The default column size is half the screen, and can be changed with SUPER + ALT + [1,2,3] for number of columns.
-- Pressing SUPER + R will resize the current column, cycling between predefined fractional values.
-- Alternatively, SUPER + Space will make the current column cover the entire screen.
-- Individual windows can be more precisely resized with SUPER + ALT + <direction>.
-- Finally, SUPER + SHIFT + R evenly resizez all the columns that are currently into view.
-----------------------------------------------------------------------------------------------------------------------
hl.config({
    scrolling = {
        column_width = 0.5,
        explicit_column_widths = "0.33, 0.5, 0.66",
        focus_fit_method = 1, -- 0 = Center, 1 = Fit
        fullscreen_on_one_column = true,
    },
})

hl.bind(
    "SUPER + ALT + 1",
    function()
        hl.dispatch(hl.dsp.layout("colresize 1.0"))
        hl.config({ scrolling = { column_width = 1.0 }})
    end,
    { description = "Expand the current column to the full-width of the screen, and make all future windows the same." }
)

hl.bind(
    "SUPER + ALT + 2",
    function()
        hl.dispatch(hl.dsp.layout("colresize 0.5"))
        hl.config({ scrolling = { column_width = 0.5 }})
    end,
    { description = "Resize the current column be half of the screen, and make all future windows the same." }
)

hl.bind(
    "SUPER + ALT + 3",
    function()
        hl.dispatch(hl.dsp.layout("colresize 0.333"))
        hl.config({ scrolling = { column_width = 0.333 }})
    end,
    { description = "Resize the current column to a third of the screen, and make all future windows the same." }
)

hl.bind("SUPER + Space"  , hl.dsp.layout("colresize 1.0")  , { description = "Expand the current column to fit the screen." })
hl.bind("SUPER + R"      , hl.dsp.layout("colresize +conf"), { description = "Cycle through predefined column sizes." })
hl.bind("SUPER + ALT + R", hl.dsp.layout("fit visible")    , { description = "Resizes visible columns to evenly split the screen." })

hl.bind("SUPER + ALT + right", hl.dsp.layout("colresize +0.025"), { repeating = true, description = "Increase the horizontal size of the active column." })
hl.bind("SUPER + ALT + left" , hl.dsp.layout("colresize -0.025"), { repeating = true, description = "Decrease the horizontal size of the active column." })

hl.bind("SUPER + ALT + up"   , hl.dsp.window.resize({ x = 0, y =  25, relative = true}), { repeating = true, description = "Increase the vertical size of the active window." })
hl.bind("SUPER + ALT + down" , hl.dsp.window.resize({ x = 0, y = -25, relative = true}), { repeating = true, description = "Decrease the vertical size of the active window." })

-- MOUSE BINDINGS -----------------------------------------------------------------------------------------------------
-- A window can be moved with SUPER + LeftClick and resized with SUPER + RightClick.
-- Workspaces (on the same monitor) can be switched between one another with SUPER + <Scroll>.
-----------------------------------------------------------------------------------------------------------------------
hl.config({
    general = {
        resize_on_border = true,
        hover_icon_on_border = true,
        extend_border_grab_area = 15,
        resize_corner = 0,
    },
    input = {
        follow_mouse = 1,
        mouse_refocus = true,
    },
    binds = {
        drag_threshold = 10,
    },
    cursor = {
        inactive_timeout = 15,
    },
    misc = {
        always_follow_on_dnd = true,
        animate_manual_resizes = true,
    },
})

hl.bind("SUPER + mouse:272", hl.dsp.window.drag()  , { mouse = true, description = "Drag and move active window." })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true, description = "Drag and resize active window." })

hl.bind("SUPER + mouse_up"  , hl.dsp.focus({ workspace = "m+1" }), { description = "Focus the previous workspace on same monitor." })
hl.bind("SUPER + mouse_down", hl.dsp.focus({ workspace = "m-1" }), { description = "Focus the next workspace on same monitor." })

--- FLOATING AND FULLSCREEN -------------------------------------------------------------------------------------------
-- A window can be made fullscreen with SUPER + F.
-- A window can be toggled floating with SUPER + V, then controlled via mouse.
-- To pin a window (floating and following focused monitor) use SUPER + SHIFT + V.
-----------------------------------------------------------------------------------------------------------------------
hl.config({
    binds = {
        allow_pin_fullscreen = true,
    },
})

hl.bind("SUPER + F", hl.dsp.window.fullscreen()                , { description = "Put the focused windo in full-screen." })
hl.bind("SUPER + V", hl.dsp.window.float({ action = "toggle" }), { description = "Toggle floating for the active window." })

hl.bind(
    "SUPER + SHIFT + V",
    function()
        hl.dispatch(hl.dsp.window.float({ action = "enable" }))
        hl.dispatch(hl.dsp.window.pin({ action = "enable" }))
    end,
    { description = "Float and pin the active window." }
)
