RUN_TESTS = false
if RUN_TESTS then
  print('Running tests')
end
utility = nil
LOCALIZATION = nil
local STATE = {
  PATHS = {
    RESOURCES = nil
  },
  STACK = false,
  VARIANT = nil
}
local COMPONENTS = {
  STATUS = nil
}
log = function(...)
  if STATE.LOGGING == true then
    return print(...)
  end
end
HideStatus = function()
  return COMPONENTS.STATUS:hide()
end
Initialize = function()
  SKIN:Bang('[!Hide]')
  STATE.PATHS.RESOURCES = SKIN:GetVariable('@')
  dofile(('%s%s'):format(STATE.PATHS.RESOURCES, 'lib\\rainmeter_helpers.lua'))
  COMPONENTS.STATUS = require('shared.status')()
  local success, err = pcall(function()
    require('shared.enums')
    utility = require('shared.utility')
    utility.createJSONHelpers()
    COMPONENTS.SETTINGS = require('shared.settings')()
    LOCALIZATION = require('shared.localization')(COMPONENTS.SETTINGS)
    SKIN:Bang(('[!SetOption "WindowTitle" "Text" "%s"]'):format(LOCALIZATION:get('search_window_all_title', 'Search')))
    COMPONENTS.STATUS:hide()
    STATE.VARIANT = SKIN:GetVariable('Variant', nil)
    if STATE.VARIANT ~= nil and STATE.VARIANT ~= '' then
      STATE.VARIANT = ('\\%s'):format(STATE.VARIANT)
    else
      STATE.VARIANT = ''
    end
    return SKIN:Bang(('[!CommandMeasure "Script" "HandshakeSearch()" "#ROOTCONFIG#%s"]'):format(STATE.VARIANT))
  end)
  if not (success) then
    return COMPONENTS.STATUS:show(err, true)
  end
end
Update = function() end
Handshake = function(stack)
  local success, err = pcall(function()
    if stack then
      SKIN:Bang(('[!SetOption "WindowTitle" "Text" "%s"]'):format(LOCALIZATION:get('search_window_current_title', 'Search (current games)')))
    end
    STATE.STACK = stack
    local meter = SKIN:GetMeter('WindowShadow')
    local skinWidth = meter:GetW()
    local skinHeight = meter:GetH()
    local mainConfig = utility.getConfig(('%s%s'):format(SKIN:GetVariable('ROOTCONFIG'), STATE.VARIANT))
    local monitorIndex = nil
    if mainConfig ~= nil then
      monitorIndex = utility.getConfigMonitor(mainConfig) or 1
    else
      monitorIndex = 1
    end
    local x, y = utility.centerOnMonitor(skinWidth, skinHeight, monitorIndex)
    SKIN:Bang(('[!Move "%d" "%d"]'):format(x, y))
    SKIN:Bang('[!Show]')
    return SKIN:Bang('[!CommandMeasure "Input" "ExecuteBatch 1"]')
  end)
  if not (success) then
    return COMPONENTS.STATUS:show(err, true)
  end
end
SetInput = function(str)
  local success, err = pcall(function()
    SKIN:Bang(('[!CommandMeasure "Script" "Search(\'%s\', %s)" "#ROOTCONFIG#%s"]'):format(str:sub(1, -2), tostring(STATE.STACK), STATE.VARIANT))
    return SKIN:Bang('[!DeactivateConfig]')
  end)
  if not (success) then
    return COMPONENTS.STATUS:show(err, true)
  end
end
CancelInput = function()
  local success, err = pcall(function()
    return SKIN:Bang('[!DeactivateConfig]')
  end)
  if not (success) then
    return COMPONENTS.STATUS:show(err, true)
  end
end
