{config, lib, pkgs, inputs, ...}:{
	imports=[
		../common
	];
	system = {
		stateVersion = 5;
		defaults = {
			NSGlobalDomain = {
				AppleICUForce24HourTime = true;
				# AppleInterfaceStyle = "Dark";
				AppleShowAllExtensions = true;
				AppleShowAllFiles = true;
				AppleShowScrollBars = "Automatic";
				AppleSpacesSwitchOnActivate = false;
				#InitialKeyRepeat = 15;
				#KeyRepeat = 2;
				#NSAutomaticWindwowAnimationsEnabled = false;
				NSTableViewDefaultSizeMode = 1;
				#HIHideMenuBar = true;
			};
			SoftwareUpdate = {
				AutomaticallyInstallMacOSUpdates = true;
			};
			dock = {
				autohide = true;
				# magnification = true;
				# magnificationSize = 64;
				orientation = "right";
				mineffect = "scale";
				mru-spaces = false;
				show-recents=false;
				static-only=true;
				wvous-bl-corner =4;
				# pinning = "start";
				# tilesize = 48;
			};
			finder = {
				FXPreferredViewStyle = "clmv";
				ShowPathbar = true;
				ShowStatusBar = true;
			};
			hitoolbox={
				#AppleFnUsageType="Do Nothing";
				#DisableConsoleAccess = false;
			};
			menuExtraClock={
				Show24Hour = true;
				ShowDate = 1;
			};
			spaces={
				spans-displays=false;
			};
		};
	};
}
