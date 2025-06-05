local icons = {
	battery = {
		_10 = '\u{c007a}',
		_20 = '\u{c007b}',
		_30 = '\u{c007c}',
		_40 = '\u{c007d}',
		_50 = '\u{c007e}',
		_60 = '\u{F3}\u{B0}\u{81}\u{BF}',
		_70 = '\u{F3}\u{B0}\u{82}\u{80}',
		_80 = '\u{F3}\u{B0}\u{82}\u{81}',
		_90 = '\u{F3}\u{B0}\u{82}\u{82}',
		_100 = '\u{F3}\u{B0}\u{81}\u{B9}',
		charging = '\u{F3}\u{B0}\u{82}\u{84}',
	},
	error = '\u{EE}\u{AA}\u{87}',
}

require('helper.debug_util').print_table(icons)

return icons
