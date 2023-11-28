#!/usr/bin/swift
let dark = ("dark", """
# Colors (Ayu Dark)
colors:
  # Default colors
  primary:
    background: '0x0A0E14'
    foreground: '0xB3B1AD'

  # Normal colors
  normal:
    black:   '0x01060E'
    red:     '0xEA6C73'
    green:   '0x91B362'
    yellow:  '0xF9AF4F'
    blue:    '0x53BDFA'
    magenta: '0xFAE994'
    cyan:    '0x90E1C6'
    white:   '0xC7C7C7'

  # Bright colors
  bright:
    black:   '0x686868'
    red:     '0xF07178'
    green:   '0xC2D94C'
    yellow:  '0xFFB454'
    blue:    '0x59C2FF'
    magenta: '0xFFEE99'
    cyan:    '0x95E6CB'
    white:   '0xFFFFFF'
""")
let light = ("light", """
# Colors (Ayu Light)
colors:
  # Default colors - taken from ayu-colors
  primary:
    background: '0xFCFCFC'
    foreground: '0x5C6166'

  # Normal colors - taken from ayu-iTerm
  normal:
    black:   '0x010101'
    red:     '0xe7666a'
    green:   '0x80ab24'
    yellow:  '0xeba54d'
    blue:    '0x4196df'
    magenta: '0x9870c3'
    cyan:    '0x51b891'
    white:   '0xc1c1c1'

  # Bright colors - pastel lighten 0.1 <normal> except black lighten with 0.2
  bright:
    black:   '0x343434'
    red:     '0xee9295'
    green:   '0x9fd32f'
    yellow:  '0xf0bc7b'
    blue:    '0x6daee6'
    magenta: '0xb294d2'
    cyan:    '0x75c7a8'
    white:   '0xdbdbdb'
""")

import AppKit
import Foundation

let home = ProcessInfo.processInfo.environment["HOME"]!

let cur = UserDefaults.standard
	.string(forKey: "AppleInterfaceStyle") == "Dark" ? dark : light

// print(cur)
FileManager.default.createFile(
	atPath: home + "/.local/share/usr/theme",
	contents: cur.0.data(using: .utf8)
)

FileManager.default.createFile(
	atPath: home + "/.config/alacritty/theme.yml",
	contents: cur.1.data(using: .utf8)
)
