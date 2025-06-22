{
  username,
  pkgs,
}: {
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
      package = pkgs.yabai;
    };
    skhd = {
      enable = true;
      package = pkgs.skhd;
    };
    sketchybar = {
      enable = true;
      config = ''
        #!/usr/bin/env lua

        HOME_DIR = '/Users/' .. '${username}'
        local log_file = io.open(HOME_DIR .. '/.config/sketchybar_config/logloglog', 'w')
        log_file:write 'loading config\n'

        package.cpath = package.cpath .. ';' .. '${pkgs.sbarlua}/lib/lua/5.4/sketchybar.so'
        package.path = package.path
        	.. ';'
        	.. HOME_DIR
        	.. '/.config/sketchybar_config/?/init.lua'
        	.. ';'
        	.. HOME_DIR
        	.. '/.config/sketchybar_config/?.lua'
        print 'path:'
        print(package.path .. '\n')
        print 'cpath:'
        print(package.cpath)

        log_file:write('cpath: ' .. package.cpath .. '\n' .. 'path: ' .. package.path .. '\n')
        log_file:close()

        -- load the sketchybar-package and prepare the helper binaries
        require 'sbar_conf'
      '';
      package = pkgs.sketchybar;
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
