-- Raycast-style window management
-- Super = Cmd + Opt + Ctrl
--   Super+Left  : left half  (press again to cycle 1/2 -> 2/3 -> 1/3)
--   Super+Right : right half (press again to cycle 1/2 -> 2/3 -> 1/3)
--   Super+Up    : maximize
--   Super+Down  : restore the size/position from before the first Left/Right/Up

local super = { "cmd", "alt", "ctrl" }

hs.window.animationDuration = 0

local cycle = { 1 / 2, 2 / 3, 1 / 3 }

-- Gap (px) around snapped windows: full at screen edges, split in half on the
-- inner edge so two adjacent windows end up exactly `gap` apart. Maximize has none.
local gap = 4

-- Remembers the last action per window, so repeated presses cycle sizes.
local last = { id = nil, side = nil, index = 0 }

-- Per window id: the frame we last set, and the user's frame from before that.
local placed = {}
local original = {}

local function approxEqual(a, b)
  return math.abs(a - b) < 2
end

local function sameFrame(a, b)
  return a and b
      and approxEqual(a.x, b.x) and approxEqual(a.y, b.y)
      and approxEqual(a.w, b.w) and approxEqual(a.h, b.h)
end

-- Saves the window's current frame as the one to restore, unless the window is
-- still where we put it (then the frame from before our first move is kept).
local function rememberOriginal(win)
  local id = win:id()
  local frame = win:frame()
  if not sameFrame(frame, placed[id]) then
    original[id] = frame
  end
end

local function recordPlaced(win)
  placed[win:id()] = win:frame()
end

local function snap(side)
  local win = hs.window.focusedWindow()
  if not win then return end

  local screen = win:screen():frame()
  local frame = win:frame()
  rememberOriginal(win)

  -- Continue the cycle only if this is the same window, same side, and it
  -- still sits where we last put it (i.e. the user hasn't moved it since).
  local index = 1
  if last.id == win:id() and last.side == side and sameFrame(frame, last.frame) then
    index = last.index % #cycle + 1
  end

  local w = math.floor(screen.w * cycle[index])
  local x = side == "left" and screen.x or (screen.x + screen.w - w)
  local target = hs.geometry.rect(x, screen.y, w, screen.h)
  local outerX = side == "left" and gap or gap / 2
  target.x = target.x + outerX
  target.w = target.w - gap - gap / 2
  target.y = target.y + gap
  target.h = target.h - 2 * gap
  win:setFrame(target)

  recordPlaced(win)
  last = { id = win:id(), side = side, index = index, frame = win:frame() }
end

local function maximize()
  local win = hs.window.focusedWindow()
  if not win then return end
  rememberOriginal(win)
  win:maximize()
  recordPlaced(win)
  last = { id = nil, side = nil, index = 0 }
end

local function restore()
  local win = hs.window.focusedWindow()
  if not win then return end
  local id = win:id()
  if not original[id] then return end
  win:setFrame(original[id])
  original[id] = nil
  placed[id] = nil
  last = { id = nil, side = nil, index = 0 }
end

hs.hotkey.bind(super, "left", function() snap("left") end)
hs.hotkey.bind(super, "right", function() snap("right") end)
hs.hotkey.bind(super, "up", maximize)
hs.hotkey.bind(super, "down", restore)

return { snap = snap, maximize = maximize, restore = restore }
