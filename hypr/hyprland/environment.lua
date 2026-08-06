-- Wayland
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("AQ_DRM_DEVICES", "/dev/dri/amd-igpu")
hl.env("GDK_BACKEND", "wayland,x11")

-- Applications 
hl.env("XDG_DATA_DIRS", "$HOME/.local/share/flatpak/exports/share:/var/lib/flatpak/exports/share:/usr/local/share:/usr/share")

-- Themes & Misc 
hl.env("QT_QPA_PLATFORM", "wayland")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("XDG_MENU_PREFIX", "plasma-")

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("WLR_NO_HARDWARE_CURSORS", "1")

-- window rules
hl.window_rule({
  match = { 
    class = "^(org.qbittorrent.qBittorrent)$" 
  },
  workspace = "special:magic silent"
})