-- monitor
local monitor_1 = "desc:LG Electronics LG FULL HD 0x01010101"
local monitor_2 = "desc:LG Electronics LG FULL HD 707NTWGAZ337"

hl.monitor({ output = "desc:LG Electronics LG FULL HD 0x01010101"  , mode = "1920x1080", position = "0x0", scale = 1 })
hl.monitor({ output = "desc:LG Electronics LG FULL HD 707NTWGAZ337", mode = "1920x1080", position = "1920x0", scale = 1 })

-- windows and workspaces
for i = 1, 9, 2 do
    hl.workspace_rule({ workspace = tostring(i), monitor = monitor_1 })
end

for i = 2, 10, 2 do
    hl.workspace_rule({ workspace = tostring(i), monitor = monitor_2 })
end

local suppressMaximizeRule = hl.window_rule({
    -- Ignore maximize requests from all apps. You'll probably like this.
    name  = "suppress-maximize-events",
    match = { class = ".*" },

    suppress_event = "maximize",
})
-- suppressMaximizeRule:set_enabled(false)

hl.window_rule({
    -- Fix some dragging issues with XWayland
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },

    no_focus = true,
})

-- Hyprland-run windowrule
hl.window_rule({
    name  = "move-hyprland-run",
    match = { class = "hyprland-run" },

    move  = "20 monitor_h-120",
    float = true,
})
