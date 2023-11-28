global frontApp, frontAppName, windowTitle

set windowTitle to ""
tell application "System Events"
    set frontApp to first application process whose frontmost is true
    set frontAppName to name of frontApp
    tell process frontAppName
        tell (1st window whose value of attribute "AXMain" is true)
            set windowTitle to value of attribute "AXTitle"
        end tell
    end tell
end tell

if windowTitle is equal "sticky_alacritty" then
    set visible of (first window whose name contains "sticky_alacritty") to false
else
    set visible of (first window whose name contains "sticky_alacritty") to true
end if
