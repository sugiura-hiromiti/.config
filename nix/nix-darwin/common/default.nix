{
  username,
  pkgs,
}:
{
  fonts = {
    packages = [
      pkgs.nerd-fonts.meslo-lg
    ];
  };
  nix = {
    enable = false;
  };
  services = {
    yabai = {
      enable = true;
      enableScriptingAddition = true;
    };
	 skhd={
	 enable=true;
	 };
	 sketchybar={
	 enable=true;
	 };
  };
  system = {
    primaryUser = username;
    stateVersion = 6;
    defaults = {
      NSGlobalDomain = {
        AppleICUForce24HourTime = true;
        AppleShowAllExtensions = true;
        AppleShowAllFiles = true;
        InitialKeyRepeat = 8;
        KeyRepeat = 1;
        NSAutomaticCapitalizationEnabled = false;
        NSAutomaticDashSubstitutionEnabled = false;
        NSAutomaticPeriodSubstitutionEnabled = false;
        NSAutomaticSpellingCorrectionEnabled = false;
        NSAutomaticWindowAnimationsEnabled = false;
        NSDocumentSaveNewDocumentsToCloud = false;
        NSTableViewDefaultSizeMode = 1;
        _HIHideMenuBar = true;
        "com.apple.mouse.tapBehavior" = 1;
        # "com.apple.trackpad.scaling" = 5;
      };
      SoftwareUpdate = {
        AutomaticallyInstallMacOSUpdates = true;
      };
      dock = {
        autohide = true;
        mru-spaces = false;
        orientation = "right";
        static-only = true;
        tilesize = 16;
        wvous-bl-corner = 4;
        wvous-br-corner = 1;
        wvous-tl-corner = 1;
        wvous-tr-corner = 1;
      };
      WindowManager = {
        # EnableStandardClickToShowDesktop=
      };
      # add custom pref as you like
      # CustomSystemPreferences = {};
      # CustomUserPreferences = {};
      finder = {
        FXPreferredViewStyle = "clmv";
        ShowPathbar = true;
      };
      menuExtraClock = {
        Show24Hour = true;
      };
      trackpad = {
        Clicking = true;
        FirstClickThreshold = 0;
        SecondClickThreshold = 0;
      };
    };
  };
}
