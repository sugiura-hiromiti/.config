--[[
 a: variable lifecycle
 this `init.lua` is a single scope and any object which is local to `init.lua` is available for GC.
 Thus, if we want to create object which survive for until we reload our config,
 or quit Hammerspoon, capture as global object like this
 myWatcher=hs.pathwatcher.new(...):start()
]]
-- d: see here for detalis|> http://www.hammerspoon.org/go/
-- # awesome Spoons|> http://www.hammerspoon.org/Spoons/ReloadConfiguration.html

-- # window manipulation
SIZE = 35

-- ## window position
hs.hotkey.bind({ 'cmd' }, ';', function()
	-- `w` and `f` should be local to function. because of focused window and it's frame is different for each call
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

-- # multi window layout
-- # window filter

-- # config reload
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

-- # menubar item
-- # reach to application events

-- # reach to wi-fi events
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

-- # reach to USB events
-- # run osascript

hs.hotkey.bind({ 'cmd', 'shift' }, 'p', function()
	os.execute 'pip'
	hs.notify.new({ title = 'HammerSpoon', informativeText = 'pipped!' }):send()
end)

-- make sure that this line is bottom of file
hs.notify.new({ title = 'HammerSpoon', informativeText = 'config loaded' }):send()
