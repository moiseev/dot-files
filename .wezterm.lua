local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.color_scheme = 'Catppuccin Mocha'
config.window_background_opacity = 0.9
config.macos_window_background_blur = 20

config.font = wezterm.font 'JetBrains Mono'
config.font_size = 14.0

return config
