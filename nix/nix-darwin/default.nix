{
  user,
  arch,
  os,
  pkgs,
  ...
}: {
  security = {
    pam = {
      services = {
        sudo_local = {
          enable = false;
        };
      };
    };
  };
  fonts = {
    packages = [
      pkgs.nerd-fonts.meslo-lg
    ];
  };
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "uninstall";
    };
    brews = [
      # "FelixKratz/formulae/sketchybar"
      # "koekeishiya/formulae/yabai"
      # "koekeishiya/formulae/skhd"
      "sqlite"
    ];
    casks = [
      "karabiner-elements"
      "amazon-q"
      "crystalfetch"
      "slack"
      "homerow"
      # "mouseless"
    ];
    taps = [
      # "koekeishiya/formulae"
      "FelixKratz/formulae"
    ];
    masApps = {
      "Wallpaper Play" = 1638457121;
      "Logic Pro" = 634148309;
      "Obsidian Web Clipper" = 6720708363;
      # "Vimlike" = 1584519802;
    };
  };
  nix = {
    enable = false;
  };
  system = {
    primaryUser = user;
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
