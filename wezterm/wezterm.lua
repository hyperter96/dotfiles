local wezterm = require("wezterm")

-- this will hold the config
local config = wezterm.config_builder()

config.font = wezterm.font_with_fallback({ "Hack Nerd Font", "Noto Sans CJK SC", "Sarasa Mono SC" })
config.warn_about_missing_glyphs = false
config.colors = {
	foreground = "#CBE0F0",
	background = "#011423",
	cursor_bg = "#47FF9C",
	cursor_border = "#47FF9C",
	cursor_fg = "#011423",
	selection_bg = "#033259",
	selection_fg = "#CBE0F0",
	ansi = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#0FC5ED", "#a277ff", "#24EAF7", "#24EAF7" },
	brights = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#A277FF", "#a277ff", "#24EAF7", "#24EAF7" },
}

config.font_size = 11

config.window_decorations = "RESIZE"

config.window_background_opacity = 0.75
-- config.macos_window_background_blur = 20

local mux = wezterm.mux
wezterm.on("gui-startup", function(cmd)
	local tab, pane, window = mux.spawn_window(cmd or {})
	window:gui_window():maximize()
end)
return config
