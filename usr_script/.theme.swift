#!/usr/bin/swift
let dark = ("dark", """
# Colors (PaperColor - Dark)
colors:
    # Default colors
    primary:
        background: '0x1c1c1c'
        foreground: '0x808080'

    cursor:
        text: '0x1c1c1c'
        cursor: '0x808080'

    # Normal colors
    normal:
        black: '0x1c1c1c'
        red: '0xaf005f'
        green: '0x5faf00'
        yellow: '0xd7af5f'
        blue: '0x5fafd7'
        magenta: '0x808080'
        cyan: '0xd7875f'
        white: '0xd0d0d0'

    # Bright colors
    bright:
        black: '0x585858'
        red: '0x5faf5f'
        green: '0xafd700'
        yellow: '0xaf87d7'
        blue: '0xffaf00'
        magenta: '0xffaf00'
        cyan: '0x00afaf'
        white: '0x5f8787'
""")
let light = ("light", """
# Colors (PaperColor - Light)
colors:
    # Default colors
    primary:
        background: '0xeeeeee'
        foreground: '0x444444'

    cursor:
        text: '0xeeeeee'
        cursor: '0x444444'

    # Normal colors
    normal:
        black: '0xeeeeee'
        red: '0xaf0000'
        green: '0x008700'
        yellow: '0x5f8700'
        blue: '0x0087af'
        magenta: '0x878787'
        cyan: '0x005f87'
        white: '0x444444'

    # Bright colors
    bright:
        black: '0xbcbcbc'
        red: '0xd70000'
        green: '0xd70087'
        yellow: '0x8700af'
        blue: '0xd75f00'
        magenta: '0xd75f00'
        cyan: '0x005faf'
        white: '0x005f87'
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
