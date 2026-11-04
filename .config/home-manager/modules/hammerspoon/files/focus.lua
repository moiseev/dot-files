-- Keeps keyboard focus and the mouse pointer together.
--
-- 1. Focus follows mouse: once the pointer rests over a window for `delay`
--    seconds, that window is focused (and, as macOS requires, raised).
-- 2. Mouse follows focus: when focus moves to a window by other means
--    (Cmd-Tab, Cmd-`, a new window opening, a window snapped away from the
--    pointer), the pointer jumps to that window's center.
--
-- Ctrl+Opt+F toggles both on and off.

local toggleMods = { "ctrl", "alt" }

-- How long the pointer must rest before focus follows it. Moving across a
-- window on the way to another one shouldn't focus (and raise) it.
local delay = 2

-- After we warp the pointer, ignore mouse movement for this long, so the warp
-- itself can't make focus follow to some window overlapping the center.
local warpGrace = 0.3

local enabled = true
local ignoreMovesUntil = 0

local function windowUnderMouse()
  local pos = hs.mouse.absolutePosition()
  local el = hs.axuielement.systemWideElement():elementAtPosition(pos)
  if not el then return nil end
  local axWin = el.AXRole == "AXWindow" and el or el.AXWindow
  return axWin and axWin:asHSWindow()
end

local function containsMouse(win)
  -- absolutePosition() returns a plain {x, y} table, not an hs.geometry point.
  return hs.geometry.point(hs.mouse.absolutePosition()):inside(win:frame())
end

local function focusWindowUnderMouse()
  if not enabled or hs.timer.secondsSinceEpoch() < ignoreMovesUntil then return end
  -- Don't steal focus mid-drag or mid-selection.
  local buttons = hs.mouse.getButtons()
  if buttons.left or buttons.right then return end

  local win = windowUnderMouse()
  -- Skips the Dock, menu bar, menus, popovers, the desktop, launcher panels...
  if not win or not win:isStandard() then return end
  local focused = hs.window.focusedWindow()
  if focused and focused:id() == win:id() then return end
  win:focus()
end

local focusTimer = hs.timer.delayed.new(delay, focusWindowUnderMouse)

local mouseTap = hs.eventtap.new({ hs.eventtap.event.types.mouseMoved }, function()
  focusTimer:start() -- restarts the countdown on every move
  return false
end)

local function warpToFocused()
  if not enabled then return end
  local win = hs.window.focusedWindow()
  if not win or not win:isStandard() then return end
  if containsMouse(win) then return end -- e.g. it was focused by the mouse
  -- Mid-drag the pointer can sit just outside a window being resized.
  local buttons = hs.mouse.getButtons()
  if buttons.left or buttons.right then return end
  ignoreMovesUntil = hs.timer.secondsSinceEpoch() + warpGrace
  focusTimer:stop()
  hs.mouse.absolutePosition(win:frame().center)
end

-- Short debounce: lets the focused window settle after an app switch, and
-- coalesces the burst of moved/resized notifications from a snap.
local warpTimer = hs.timer.delayed.new(0.05, warpToFocused)

-- hs.window.filter doesn't reliably deliver windowFocused events, so watch the
-- frontmost app directly: app switches via the app watcher, and window switches
-- within it (Cmd-`, new windows, snaps) via an Accessibility observer.
local appObserver

local function observeApp(app)
  if appObserver then appObserver:stop(); appObserver = nil end
  if not app then return end
  local ok, obs = pcall(hs.axuielement.observer.new, app:pid())
  if not ok or not obs then return end
  local axApp = hs.axuielement.applicationElement(app)
  for _, n in ipairs({ "AXFocusedWindowChanged", "AXWindowMoved", "AXWindowResized" }) do
    pcall(obs.addWatcher, obs, axApp, n)
  end
  obs:callback(function() warpTimer:start() end):start()
  appObserver = obs
end

local appWatcher = hs.application.watcher.new(function(_, event, app)
  if event == hs.application.watcher.activated then
    observeApp(app)
    warpTimer:start()
  end
end)
appWatcher:start()
observeApp(hs.application.frontmostApplication())

-- macOS silently disables event taps now and then (e.g. after sleep).
local tapWatchdog = hs.timer.doEvery(5, function()
  if enabled and not mouseTap:isEnabled() then mouseTap:start() end
end)

local function setEnabled(on)
  enabled = on
  if on then mouseTap:start() else mouseTap:stop(); focusTimer:stop() end
end

hs.hotkey.bind(toggleMods, "f", function()
  setEnabled(not enabled)
  hs.alert.show("Focus ⇄ mouse sync: " .. (enabled and "on" or "off"))
end)

setEnabled(true)

-- Returned (and so kept alive by `package.loaded`) so the tap, watchers and
-- timers aren't garbage-collected.
return {
  setEnabled = setEnabled,
  mouseTap = mouseTap,
  focusTimer = focusTimer,
  warpTimer = warpTimer,
  appWatcher = appWatcher,
  observer = function() return appObserver end,
  tapWatchdog = tapWatchdog,
}
