# linux/x86
{legacy}:
let
	common = (import ../common {inherit legacy;});
	x86 = (import ../../common/x86 {inherit legacy;});
in
	 common ++ x86 ++
	[
	legacy.discord
	legacy.minecraft
	legacy.slack
]

