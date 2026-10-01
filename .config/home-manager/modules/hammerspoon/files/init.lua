-- Enables the `hs` CLI (handy for debugging the config from a terminal).
require("hs.ipc")

-- `open hammerspoon://reload` reloads the config (bound in Leader Key: h -> r).
hs.urlevent.bind("reload", function() hs.reload() end)

require("wm")

hs.alert.show("Hammerspoon config loaded")
