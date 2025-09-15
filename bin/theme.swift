#!swift
import AppKit

var appearance = NSApplication.shared.effectiveAppearance.name.rawValue
var theme = "light"
if appearance.contains(
	"Dark") /* a == "NSAppearanceNameVibrantDark" || "NSAppearanceNameDarkAqua" ||
 "NSAppearanceNameAccessibilityHighContrastVibrantDark" ||
 "NSAppearanceNameAccessibilityHighContrastDarkAqua"
 */
{
	theme = "dark"
}

print(theme)

// let f = FileManager.default
// f.createFile(atPath: "/tmp/sys_appear.txt", contents: appearance_is.data(using: .utf8))
