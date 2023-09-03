-- TODO: you should create a window filter for Code windows per https://www.reddit.com/r/hammerspoon/comments/nzo4ty/hswindowfilterdefaultgetwindows_is_slow/

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
    app = hs.application.find(name)
    if app == nil then
    -- hs.alert.show("launch")
      hs.application.launchOrFocus(name)
    end
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

-- switcher_browsers = hs.window.switcher.new{'Code - Insiders'} -- specialized switcher for your dozens of browser windows :)

-- might be nice to have kitty-style resize controls like cmd-r, the T for Taller, S for Shorter, etc

function _codeWithProfile(profile)
  local app = hs.application.get('Code')

  if app == nil then
    hs.alert.show("launch")
    hs.application.launchOrFocus(name)
  else
    print(hs.inspect.inspect(app))

    local win = app:findWindow('[[' .. profile .. ']]')
    -- TODO: if the focused window matches, select the next matching window
    if win == nil then
      -- nothing with that profile found; just focus a random VSCode window
      _focusapp('Code')
    else
      win:focus()
    end
  end
end

hs.hotkey.bind('alt', 'j', 'KB', function() _codeWithProfile('KB') end)
hs.hotkey.bind('alt', 'i', 'NVIDIA', function() _codeWithProfile('Default') end)
hs.hotkey.bind('alt', 'u', 'dev', function() _codeWithProfile('dev') end)

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

hs.hotkey.bind('alt-shift', '[', 'Left 1/3', function() _move({0.0, 0.0, 0.33, 1.0}) end)
hs.hotkey.bind('alt-shift', ']', 'Right 2/3', function() _move({0.33, 0.0, 0.67, 1.0}) end)
hs.hotkey.bind('alt-shift', '0', 'Right 1/3', function() _move({0.67, 0.0, 0.33, 1.0}) end)
hs.hotkey.bind('alt-shift', '9', 'Left 2/3', function() _move({0.0, 0.0, 0.67, 1.0}) end)

hs.hotkey.bind('ctrl-shift', 'u', 'Top left third', function() _move({0.0, 0.0, 0.33, 0.5}) end)
hs.hotkey.bind('ctrl-shift', 'i', 'Top mid third', function() _move({0.33, 0.0, 0.33, 0.5}) end)
hs.hotkey.bind('ctrl-shift', 'o', 'Top right third', function() _move({0.66, 0.0, 0.33, 0.5}) end)
hs.hotkey.bind('ctrl-shift', 'j', 'Bottom left third', function() _move({0.0, 0.5, 0.33, 0.5}) end)
hs.hotkey.bind('ctrl-shift', 'k', 'Bottom mid third', function() _move({0.33, 0.5, 0.33, 0.5}) end)
hs.hotkey.bind('ctrl-shift', 'l', 'Bottom right third', function() _move({0.66, 0.5, 0.33, 0.5}) end)

hs.hotkey.bind('alt', 'a', 'Mimestream', function() _focusapp('Mimestream') end)
hs.hotkey.bind('alt', 'l', 'Google Chrome', function() _focusapp('Google Chrome') end)
hs.hotkey.bind('alt', 'f', 'Finder', function() _focusapp('Finder') end)
hs.hotkey.bind('alt', 'h', 'Safari', function() _focusapp('Safari') end)
hs.hotkey.bind('alt', 'e', 'ForkLift', function() _focusapp('ForkLift') end)
hs.hotkey.bind('alt', 'q', 'Gmail', function() _focusapp('Gmail') end)
hs.hotkey.bind('alt', 'p', 'Preview', function() _focusapp('Preview') end)
hs.hotkey.bind('alt', 'o', 'Brave Browser', function() _focusapp('Brave Browser') end)
hs.hotkey.bind('alt', "'", 'Google Chat', function() _focusapp('Google Chat') end)
hs.hotkey.bind('alt', 's', 'Music', function() _focusapp('Music') end)
hs.hotkey.bind('alt', 'n', 'Google Meet', function() _focusapp('Google Meet') end)
hs.hotkey.bind('alt', '\\', 'Terminal', function() _focusapp('Terminal') end)
hs.hotkey.bind('alt', '.', 'Parsec', function() _focusapp('Parsec') end)
hs.hotkey.bind('alt', 'd', 'WhatsApp', function() _focusapp('WhatsApp') end)
hs.hotkey.bind('alt', 'return', 'kitty', function() _focusapp('kitty') end)

hs.hotkey.bind('alt-shift', 'k', 'Next screen', function()
  local win = hs.window.focusedWindow()
  if win == nil then
    return
  end

  win:moveToScreen(win:screen():next())
end)

-- hs.hotkey.bind('ctrl-alt-cmd', '-', 'Zoom out', function()
hs.hotkey.bind('alt-cmd', '-', 'Zoom out', function()
  hs.alert.closeAll()

  local sc = hs.screen.primaryScreen()
  if sc == nil then
    return
  end

  local cm = sc:currentMode()
  -- print(hs.inspect(cm))
  -- print(hs.inspect(cm["w"]))

  bm = cm  -- 'bm' is 'best mode'

  for mode_name, nm in pairs(sc:availableModes()) do

    if nm['w'] > cm['w'] and ((bm['w'] > cm['w'] and nm['w'] < bm['w']) or (bm['w'] == cm['w'])) and
       nm['h'] > cm['h'] and ((bm['h'] > cm['h'] and nm['h'] < bm['h']) or (bm['h'] == cm['h'])) and
       nm['scale'] == 2 and
       nm['freq'] >= 60 and
       nm['depth'] >= 8 then

      bm = nm
    end
  end

  print("selected")
  print(hs.inspect(bm))
  hs.alert(hs.inspect(bm))

  -- sc:setMode{width=bm['w'], height=bm['h'], scale=bm['scale'], frequency=bm['freq'], depth=bm['depth']}
  print(bm['w'], bm['h'], bm['scale'])
  sc:setMode(bm['w'], bm['h'], bm['scale'], bm['freq'], bm['depth'])

--   width - A number containing the width in points of the new mode
-- height - A number containing the height in points of the new mode
-- scale - A number containing the scaling factor of the new mode (typically 1 for native pixel resolutions, 2 for HiDPI/Retina resolutions)
-- frequency - A number containing the vertical refresh rate, in Hertz of the new mode
-- depth - A number


  -- win:moveToScreen(win:screen():next())
end)

-- hs.hotkey.bind('ctrl-alt-cmd', '=', 'Zoom in', function()
hs.hotkey.bind('alt-cmd', '=', 'Zoom in', function()
  hs.alert.closeAll()
  local sc = hs.screen.primaryScreen()
  if sc == nil then
    return
  end

  local cm = sc:currentMode()
  -- print(hs.inspect(cm))
  -- print(hs.inspect(cm["w"]))

  bm = cm  -- 'bm' is 'best mode'

  for mode_name, nm in pairs(sc:availableModes()) do

    if nm['w'] < cm['w'] and ((bm['w'] < cm['w'] and nm['w'] > bm['w']) or (bm['w'] == cm['w'])) and
       nm['h'] < cm['h'] and ((bm['h'] < cm['h'] and nm['h'] > bm['h']) or (bm['h'] == cm['h'])) and
       nm['scale'] == 2 and
       nm['freq'] >= 60 and
       nm['depth'] >= 8 then

      bm = nm
    end
  end

  if bm['w'] < 1280 then
    hs.alert("NOPE TOO BIG")
  else
    hs.alert(hs.inspect(bm))
    print(bm['w'], bm['h'], bm['scale'])
    sc:setMode(bm['w'], bm['h'], bm['scale'], bm['freq'], bm['depth'])
  end

--   width - A number containing the width in points of the new mode
-- height - A number containing the height in points of the new mode
-- scale - A number containing the scaling factor of the new mode (typically 1 for native pixel resolutions, 2 for HiDPI/Retina resolutions)
-- frequency - A number containing the vertical refresh rate, in Hertz of the new mode
-- depth - A number


  -- win:moveToScreen(win:screen():next())
end)

hs.hotkey.bind('alt-shift', 'return', 'Close all notifications', function()
  hs.osascript.javascript([[
function run(input, parameters) {

  const appName = "";
  const verbose = true;

  const scriptName = "close_notifications_applescript";

  const CLEAR_ALL_ACTION = "Clear All";
  const CLEAR_ALL_ACTION_TOP = "Clear";
  const CLOSE_ACTION = "Close";

  const notNull = (val) => {
    return val !== null && val !== undefined;
  }

  const isNull = (val) => {
    return !notNull(val);
  }

  const systemVersion = () => {
    return Application("Finder").version().split(".").map(val => parseInt(val));
  }

  const systemVersionGreaterThanOrEqualTo = (vers) => {
    return systemVersion()[0] >= vers;
  }

  const isBigSurOrGreater = () => {
    return systemVersionGreaterThanOrEqualTo(11);
  }

  const V11_OR_GREATER = isBigSurOrGreater();
  const APP_NAME_MATCHER_ROLE = V11_OR_GREATER ? "AXStaticText" : "AXImage";
  const hasAppName = notNull(appName) && appName !== "";
  const appNameForLog = hasAppName ? ` [${appName}]` : "";

  const logs = [];
  const log = (message, ...optionalParams) => {
    let message_with_prefix = `${new Date().toISOString().replace("Z", "").replace("T", " ")} [${scriptName}]${appNameForLog} ${message}`;
    console.log(message_with_prefix, optionalParams);
    logs.push(message_with_prefix);
  }

  const logError = (message, ...optionalParams) => {
    log(`ERROR ${message}`, optionalParams);
  }

  const logErrorVerbose = (message, ...optionalParams) => {
    if (verbose) {
      log(`ERROR ${message}`, optionalParams);
    }
  }

  const logVerbose = (message) => {
    if (verbose) {
      log(message);
    }
  }

  const getLogLines = () => {
    return logs.join("\n");
  }

  const getSystemEvents = () => {
    let systemEvents = Application("System Events");
    systemEvents.includeStandardAdditions = true;
    return systemEvents;
  }

  const getNotificationCenter = () => {
    return getSystemEvents().processes.byName("NotificationCenter");
  }

  const getNotificationCenterGroups = () => {
    let notificationCenter = getNotificationCenter();
    if (notificationCenter.windows.length <= 0) {
      return [];
    }
    if (!V11_OR_GREATER) {
      return notificationCenter.windows();
    }
    return notificationCenter.windows[0].uiElements[0].uiElements[0].uiElements();
  }

  const isClearButton = (description, name) => {
    return description === "button" && name === CLEAR_ALL_ACTION_TOP;
  }

  const matchesAppName = (role, value) => {
    return role === APP_NAME_MATCHER_ROLE && value.toLowerCase() === appName.toLowerCase();
  }

  const notificationGroupMatches = (group) => {
    try {
      let description = group.description();
      if (V11_OR_GREATER && isClearButton(description, group.name())) {
        return true;
      }
      if (V11_OR_GREATER && description !== "group") {
        return false;
      }
      if (!V11_OR_GREATER) {
        let matchedAppName = !hasAppName;
        if (!matchedAppName) {
          for (let elem of group.uiElements()) {
            if (matchesAppName(elem.role(), elem.description())) {
              matchedAppName = true;
              break;
            }
          }
        }
        if (matchedAppName) {
          return notNull(findCloseActionV10(group, -1));
        }
        return false;
      }
      if (!hasAppName) {
        return true;
      }
      let firstElem = group.uiElements[0];
      return matchesAppName(firstElem.role(), firstElem.value());
    } catch (err) {
      logErrorVerbose(`Caught error while checking window, window is probably closed: ${err}`);
      logErrorVerbose(err);
    }
    return false;
  }

  const findCloseActionV10 = (group, closedCount) => {
    try {
      for (let elem of group.uiElements()) {
        if (elem.role() === "AXButton" && elem.title() === CLOSE_ACTION) {
          return elem.actions["AXPress"];
        }
      }
    } catch (err) {
      logErrorVerbose(`(group_${closedCount}) Caught error while searching for close action, window is probably closed: ${err}`);
      logErrorVerbose(err);
      return null;
    }
    log("No close action found for notification");
    return null;
  }

  const findCloseAction = (group, closedCount) => {
    try {
      if (!V11_OR_GREATER) {
        return findCloseActionV10(group, closedCount);
      }
      let checkForPress = isClearButton(group.description(), group.name());
      let clearAllAction;
      let closeAction;
      for (let action of group.actions()) {
        let description = action.description();
        if (description === CLEAR_ALL_ACTION) {
          clearAllAction = action;
          break;
        } else if (description === CLOSE_ACTION) {
          closeAction = action;
        } else if (checkForPress && description === "press") {
          clearAllAction = action;
          break;
        }
      }
      if (notNull(clearAllAction)) {
        return clearAllAction;
      } else if (notNull(closeAction)) {
        return closeAction;
      }
    } catch (err) {
      logErrorVerbose(`(group_${closedCount}) Caught error while searching for close action, window is probably closed: ${err}`);
      logErrorVerbose(err);
      return null;
    }
    log("No close action found for notification");
    return null;
  }

  const closeNextGroup = (groups, closedCount) => {
    for (let group of groups) {
      if (notificationGroupMatches(group)) {
        let closeAction = findCloseAction(group, closedCount);

        if (notNull(closeAction)) {
          try {
            closeAction.perform();
            return [true, 1];
          } catch (err) {
            logErrorVerbose(`(group_${closedCount}) Caught error while performing close action, window is probably closed: ${err}`);
            logErrorVerbose(err);
          }
        }
        return [true, 0];
      }
    }
    return false;
  }

  try {
    let notificationCenter = getNotificationCenter();
    if (notificationCenter.windows.length <= 0) {
      logError("No notifications found.");
      return getLogLines();
    }

    let groupsCount = getNotificationCenterGroups().filter(group => notificationGroupMatches(group)).length;

    if (groupsCount > 0) {
      logVerbose(`Closing ${groupsCount}${appNameForLog} notification group${(groupsCount > 1 ? "s" : "")}`);

      let startTime = new Date().getTime();
      let closedCount = 0;
      let maybeMore = true;
      let maxAttempts = 2;
      let attempts = 1;
      while (maybeMore && ((new Date().getTime() - startTime) <= (1000 * 30))) {
        try {
          let closeResult = closeNextGroup(getNotificationCenterGroups(), closedCount);
          maybeMore = closeResult[0];
          if (maybeMore) {
            closedCount = closedCount + closeResult[1];
          }
        } catch (innerErr) {
          if (maybeMore && closedCount === 0 && attempts < maxAttempts) {
            log(`Caught an error before anything closed, trying ${maxAttempts - attempts} more time(s).`)
            attempts++;
          } else {
            throw innerErr;
          }
        }
      }
    } else {
      throw Error(`No${appNameForLog} notifications found...`);
    }
  } catch (err) {
    logError(err);
    logError(err.message);
    getLogLines();
    throw err;
  }

  return getLogLines();
}
]])
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

-- set up your instance(s)
expose = hs.expose.new(nil,{showThumbnails=false}) -- default windowfilter, no thumbnails
expose_app = hs.expose.new(nil,{onlyActiveApplication=true}) -- show windows for the current application
expose_space = hs.expose.new(nil,{includeOtherSpaces=false}) -- only windows in the current Mission Control Space
expose_browsers = hs.expose.new{'Safari','Google Chrome'} -- specialized expose using a custom windowfilter
-- for your dozens of browser windows :)

-- then bind to a hotkey
hs.hotkey.bind('ctrl-cmd','e','Expose',function()expose:toggleShow()end)
hs.hotkey.bind('ctrl-cmd-shift','e','App Expose',function()expose_app:toggleShow()end)



border = nil
function drawBorder()
    if border and border.delete then
        border:delete()
    end

    local win = hs.window.focusedWindow()
    if win == nil then return end

    local f = win:frame()
    local fx = f.x - 2
    local fy = f.y - 2
    local fw = f.w + 4
    local fh = f.h + 4

    border = hs.drawing.rectangle(hs.geometry.rect(fx, fy, fw, fh))
    border:setStrokeWidth(5)
    border:setStrokeColor({["red"]=0, ["blue"]=0.6, ["green"]=0.8,["alpha"]=0.8})


    border:setRoundedRectRadii(5.0, 5.0)
    border:setStroke(true):setFill(false)
    border:setLevel("floating")
    border:show()
end

drawBorder()
windows = hs.window.filter.new(nil)
windows:subscribe(hs.window.filter.windowFocused, function () drawBorder() end)
windows:subscribe(hs.window.filter.windowUnfocused, function () drawBorder() end)
windows:subscribe(hs.window.filter.windowMoved, function () drawBorder() end)

-- TODO: you might also want keystrokes to focus window under quadrant 1,2,3,4

