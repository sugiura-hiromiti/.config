-- # window manipulation
SIZE = 35

-- ## window position
hs.hotkey.bind({ 'cmd' }, ';', function()
	local w = hs.window.focusedWindow()
	local f = w:frame()
	f.x = f.x - SIZE
	w:setFrame(f)
end)
hs.hotkey.bind({ 'cmd' }, "'", function()
	local w = hs.window.focusedWindow()
	local f = w:frame()
	f.x = f.x + SIZE
	w:setFrame(f)
end)
hs.hotkey.bind({ 'cmd' }, '[', function()
	local w = hs.window.focusedWindow()
	local f = w:frame()
	f.y = f.y - SIZE
	w:setFrame(f)
end)
hs.hotkey.bind({ 'cmd' }, '/', function()
	local w = hs.window.focusedWindow()
	local f = w:frame()
	f.y = f.y + SIZE
	w:setFrame(f)
end)

-- ## window size
hs.hotkey.bind({ 'cmd', 'shift' }, ';', function()
	local w = hs.window.focusedWindow()
	local f = w:frame()
	f.w = f.w - SIZE
	w:setFrame(f)
end)
hs.hotkey.bind({ 'cmd', 'shift' }, "'", function()
	local w = hs.window.focusedWindow()
	local f = w:frame()
	f.w = f.w + SIZE
	w:setFrame(f)
end)
hs.hotkey.bind({ 'cmd', 'shift' }, '[', function()
	local w = hs.window.focusedWindow()
	local f = w:frame()
	f.h = f.h - SIZE
	w:setFrame(f)
end)
hs.hotkey.bind({ 'cmd', 'shift' }, '/', function()
	local w = hs.window.focusedWindow()
	local f = w:frame()
	f.h = f.h + SIZE
	w:setFrame(f)
end)

-- # reach to wi-fi eventnits
LastSSID = hs.wifi.currentNetwork()
function SSIDChangedCallback()
	NewSSID = hs.wifi.currentNetwork()
	if NewSSID == 'mywifi' and LastSSID ~= 'mywifi' then
		hs.audiodevice.defaultOutputDevice():setVolume(10)
	elseif NewSSID ~= 'mywifi' and LastSSID == 'mywifi' then
		hs.audiodevice.defaultOutputDevice():setVolume(0)
	end
	LastSSID = NewSSID
end

WifiWatcher = hs.wifi.watcher.new(SSIDChangedCallback)
WifiWatcher:start()

-- # wezterm hotkey
local double_press = require 'shift_double_press'

local open_wezterm = function()
	local app_name = 'Alacritty'
	local app = hs.application.get(app_name)

	if app == nil then
		hs.application.open(app_name)
	end

	ID = hs.window('zsh'):id()

	if app == nil or app:isHidden() or not (app:isFrontmost()) then
		hs.application.launchOrFocus(app_name)
	else
		app:hide()
	end
end

double_press.timeFrame = 0.3
double_press.action = open_wezterm

--local app_watch = hs.application.watcher
--ZshHolder = app_watch.new(function(name, event, app)
--	if
--		name == 'zsh'
--		or event == app_watch.activated
--		or event == app_watch.launched
--		or event == app_watch.launching
--	then
--		ID = hs.window('zsh'):id()
--		local w = hs.window(ID)
--		local f = w:frame()
--		f.x, f.y, f.w, f.h = 840.0, 25.0, 840.0, 1025.0
--		w:setFrame(f)
--	end
--end)
--ZshHolder:start()

-- make sure that this line is bottom of file
function Reload(files)
	DoReload = false
	for _, file in pairs(files) do
		if file:sub(-4) == '.lua' then
			DoReload = true
		end
	end
	if DoReload then
		hs.reload()
	end
end

ConfigWatcher = hs.pathwatcher.new(os.getenv 'HOME' .. '/.hammerspoon/', Reload):start()
hs.notify.new({ title = 'HammerSpoon', informativeText = 'config loaded' }):send()
