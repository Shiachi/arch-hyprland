-- my programs

local terminal    = "kitty"
local fileManager = "nemo"
local menu        = "rofi -show drun"
local kitty_script = "~/.config/hypr/hyprland/scripts/kitty.sh"

-- keybinds

local mainMod = "SUPER" -- Sets "Windows" key as main modifier

-- Example binds, see https://wiki.hypr.land/Configuring/Basics/Binds/ for more
hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(kitty_script))
hl.bind(mainMod .. " + SHIFT + R", hl.dsp.exec_cmd("~/.config/waybar/scripts/launch.sh"))
local closeWindowBind = hl.bind(mainMod .. " + C", hl.dsp.window.close())
-- closeWindowBind:set_enabled(false)
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))    -- dwindle only

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key,             hl.dsp.focus({ workspace = i}))
    hl.bind(mainMod .. " + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i }))
end

-- Example special workspace (scratchpad)
hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Screenshot
hl.bind("Print", hl.dsp.exec_cmd("grimblast copysave area output.png"))
hl.bind(mainMod .. " + P", hl.dsp.exec_cmd("grimblast copysave active output.png"))
hl.bind(mainMod .. " + CTRL + P", hl.dsp.exec_cmd("grimblast copy area output.png"))

-- Media key
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("playerctl next"))
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("playerctl previous"))

-- input

hl.config({
    input = {
        kb_layout = "us",
        accel_profile = "flat",
        force_no_accel = 1,
        scroll_method = "on_button_down",
        follow_mouse = 1,
        sensitivity = 0, 

        touchpad = {
            natural_scroll = true, 
            disable_while_typing = true,
            clickfinger_behavior = true,
            scroll_factor = 0.7,
        }
    }
})