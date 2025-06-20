{}: {
  system = {
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
        _HIHideMenuBar = false;
        "com.apple.mouse.tapBehavior" = 1;
        "com.apple.trackpad.scaling" = 5;
      };
      SoftwareUpdate = {
        AutomaticallyInstallMacOSUpdates = true;
      };
      dock = {
        autohide = true;
      };
      WindowManager = {
        # EnableStandardClickToShowDesktop=
      };
      # add custom pref as you like
      # CustomSystemPreferences = {};
      # CustomUserPreferences = {};
    };
  };
}
