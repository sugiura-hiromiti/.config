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
