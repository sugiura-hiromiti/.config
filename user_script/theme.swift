import AppKit

var appearance = NSApplication.shared.effectiveAppearance.name.rawValue
var appearance_is_light = true
if appearance.contains(
	"Dark") /* a == "NSAppearanceNameVibrantDark" || "NSAppearanceNameDarkAqua" ||
 "NSAppearanceNameAccessibilityHighContrastVibrantDark" ||
 "NSAppearanceNameAccessibilityHighContrastDarkAqua"
 */
{
	appearance_is = false
}

// let f = FileManager.default
// f.createFile(atPath: "/tmp/sys_appear.txt", contents: appearance_is.data(using: .utf8))
