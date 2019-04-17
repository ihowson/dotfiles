-- hs.hotkey.bind({"cmd", "alt", "ctrl"}, "W", function()
  -- hs.notify.new({title="Hammerspoon", informativeText="Hello World"}):send()
  -- hs.alert.show("Hello World!")
-- end)

local logger = hs.logger.new("init.lua")

function reloadConfig(files)
    doReload = false
    for _,file in pairs(files) do
        if file:sub(-4) == ".lua" then
            doReload = true
        end
    end
    if doReload then
        hs.reload()
    end
end
myWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()
hs.alert.show("Config loaded")

hs.window.animationDuration = 0
hs.alert.defaultStyle.fadeInDuration = 0.0
-- hs.alert.defaultStyle.atScreenEdge = 1
hs.hotkey.alertDuration = 0.1

function _move(how)
  local win = hs.window.focusedWindow()
  if win == nil then
    return
  end

  win:moveToUnit(how)
end

function _compareById(a, b)
  return a:id() < b:id()
end

function _focusapp(name)
  local app = hs.application.get(name)
  -- local win = hs.window.focusedWindow()
  if app == nil then
    -- hs.alert.show("launch")
    hs.application.launchOrFocus(name)
  else
    if app:isFrontmost() then
      -- hs.alert.show("hide")
      -- app:hide()

      -- raise the next window
      -- hs.alert.show("hide")
      -- local switcher = hs.window.switcher.new{name}
      -- switcher:next()
      local windows = app:visibleWindows()
      local topwin = app:focusedWindow()
      local found = nil

      table.sort(windows, _compareById)
      for index, w in pairs(windows) do
        if w == topwin then
          found = index
        end
      end

      if found == nil then
        hs.alert.show("couldn't find active window")
        return
      end

      -- choose next window
      local nextwin = windows[found + 1]
      if nextwin == nil then
        nextwin = windows[1]
      end

      hs.alert.closeAll()
      hs.alert.show(nextwin:title(), hs.alert.defaultStyle, hs.screen.primaryScreen(), 1)
      nextwin:focus()
    else
      -- The issue here is that if you activate a hidden app, that's 'unhide', and that brings all of the windows back to the top.
      -- hs.alert.show("activate")
      app:activate(false)
    end
  end
end

hs.hotkey.bind('alt-shift', 'i', 'Fill', function() _move({0.0, 0.0, 1.0, 1.0}) end)
hs.hotkey.bind('alt-shift', 'u', 'Move TL', function() _move({0.0, 0.0, 0.5, 0.5}) end)
hs.hotkey.bind('alt-shift', 'j', 'Move BL', function() _move({0.0, 0.5, 0.5, 0.5}) end)
hs.hotkey.bind('alt-shift', 'o', 'Move TR', function() _move({0.5, 0.0, 0.5, 0.5}) end)
hs.hotkey.bind('alt-shift', 'l', 'Move BR', function() _move({0.5, 0.5, 0.5, 0.5}) end)

hs.hotkey.bind('alt-shift', 'h', 'Left half', function() _move({0.0, 0.0, 0.5, 1.0}) end)
hs.hotkey.bind('alt-shift', ';', 'Right half', function() _move({0.5, 0.0, 0.5, 1.0}) end)
hs.hotkey.bind('alt-shift', '8', 'Top half', function() _move({0.0, 0.0, 1.0, 0.5}) end)
hs.hotkey.bind('alt-shift', ',', 'Bottom half', function() _move({0.0, 0.5, 1.0, 0.5}) end)

hs.hotkey.bind('alt-shift', '7', 'Centre focus', function() _move({0.2, 0.0, 0.6, 1.0}) end)

hs.hotkey.bind('alt-shift', '[', 'Left 2/3', function() _move({0.0, 0.0, 0.66, 1.0}) end)
hs.hotkey.bind('alt-shift', ']', 'Right 1/3', function() _move({0.66, 0.0, 0.34, 1.0}) end)

hs.hotkey.bind('ctrl-shift', 'u', 'Top left third', function() _move({0.0, 0.0, 0.33, 0.5}) end)
hs.hotkey.bind('ctrl-shift', 'i', 'Top mid third', function() _move({0.33, 0.0, 0.33, 0.5}) end)
hs.hotkey.bind('ctrl-shift', 'o', 'Top right third', function() _move({0.66, 0.0, 0.33, 0.5}) end)
hs.hotkey.bind('ctrl-shift', 'j', 'Bottom left third', function() _move({0.0, 0.5, 0.33, 0.5}) end)
hs.hotkey.bind('ctrl-shift', 'k', 'Bottom mid third', function() _move({0.33, 0.5, 0.33, 0.5}) end)
hs.hotkey.bind('ctrl-shift', 'l', 'Bottom right third', function() _move({0.66, 0.5, 0.33, 0.5}) end)

hs.hotkey.bind('alt', 'a', 'Airmail 3', function() _focusapp('Airmail 3') end)
hs.hotkey.bind('alt', ';', 'Atom', function() _focusapp('Atom') end)
hs.hotkey.bind('alt', 'l', 'Google Chrome', function() _focusapp('Google Chrome') end)
hs.hotkey.bind('alt', 'i', 'Visual Studio Code', function() _focusapp('Visual Studio Code') end)
hs.hotkey.bind('alt', 'm', 'Cog', function() _focusapp('Cog') end)
hs.hotkey.bind('alt', 'f', 'Finder', function() _focusapp('Finder') end)
hs.hotkey.bind('alt', '.', 'Firefox', function() _focusapp('Firefox') end)
hs.hotkey.bind('alt', 'e', 'Forklift', function() _focusapp('Forklift') end)
hs.hotkey.bind('alt', 'q', 'Microsoft Outlook', function() _focusapp('Microsoft Outlook') end)
hs.hotkey.bind('alt', 'p', 'Preview', function() _focusapp('Preview') end)
hs.hotkey.bind('alt', 'o', 'Safari', function() _focusapp('Safari') end)
hs.hotkey.bind('alt', "'", 'Slack', function() _focusapp('Slack') end)
hs.hotkey.bind('alt', 's', 'Spotify', function() _focusapp('Spotify') end)
hs.hotkey.bind('alt', 'j', 'ST2', function() _focusapp('ST2') end)
hs.hotkey.bind('alt', 'k', 'Sublime Text 3', function() _focusapp('Sublime Text') end)
hs.hotkey.bind('alt', '\\', 'Terminal', function() _focusapp('Terminal') end)
hs.hotkey.bind('alt', 'd', 'WhatsApp', function() _focusapp('WhatsApp') end)
hs.hotkey.bind('alt', 'return', 'iTerm', function() _focusapp('iTerm') end)

hs.hotkey.bind('alt-shift', 'k', 'Next screen', function()
  local win = hs.window.focusedWindow()
  if win == nil then
    return
  end

  win:moveToScreen(win:screen():next())
end)

function dump(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. dump(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
end

hs.hotkey.bind('alt-shift', '/', 'Gather windows', function()
  local win = hs.window.focusedWindow()
  if win == nil then
    return
  end

  local app = win:application()
  if app == nil then
    hs.alert.show("no app?")
    return
  end

  for k, w in pairs(app:allWindows()) do
    w:move(win:frame(), win:screen())
  end
end)


-- border = nil
-- function drawBorder()
--     if border then
--         border:delete()
--     end

--     local win = hs.window.focusedWindow()
--     if win == nil then return end

--     local f = win:frame()
--     local fx = f.x - 2
--     local fy = f.y - 2
--     local fw = f.w + 4
--     local fh = f.h + 4

--     border = hs.drawing.rectangle(hs.geometry.rect(fx, fy, fw, fh))
--     border:setStrokeWidth(5)
--     border:setStrokeColor({["red"]=0.75,["blue"]=0.14,["green"]=0.03,["alpha"]=0.80})
--     border:setRoundedRectRadii(5.0, 5.0)
--     border:setStroke(true):setFill(false)
--     border:setLevel("floating")
--     border:show()
-- end

-- drawBorder()
-- windows = hs.window.filter.new(nil)
-- windows:subscribe(hs.window.filter.windowFocused, function () drawBorder() end)
-- windows:subscribe(hs.window.filter.windowUnfocused, function () drawBorder() end)
-- windows:subscribe(hs.window.filter.windowMoved, function () drawBorder() end)

-- TODO: you might also want keystrokes to focus window under quadrant 1,2,3,4

-- function toggleWindowFocus(windowName)
--     return function()
--         window = hs.window.filter.new(windowName):getWindows()[1]
--         if hs.window.focusedWindow() == window then
--             window = windowHistory
--         end

--         windowHistory = hs.window.focusedWindow()
--         hs.mouse.setAbsolutePosition(window:frame().center)
--         window:focus()
--     end
-- end
