local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.color_scheme = 'Catppuccin Mocha'
config.window_background_opacity = 0.95
config.window_close_confirmation = 'NeverPrompt'
config.macos_window_background_blur = 20

config.font = wezterm.font 'JetBrains Mono'
config.font_size = 14.0

config.default_prog = { '/opt/homebrew/bin/fish', '-l' }

wezterm.on('gui-startup', function (cmd)
  local tab, pane, window = wezterm.mux.spawn_window(cmd or {})
  window:gui_window():maximize()
end)

config.hide_tab_bar_if_only_one_tab = true

return config
