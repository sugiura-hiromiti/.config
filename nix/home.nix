{
  inputs,
  user,
  os,
  arch,
  home,
  system,
  user-system,
  fenix,
  lib,
  config,
  pkgs,
  awww,
  ...
}:
let
  mypkgs = import ./pkg {
    inherit user;
    inherit os;
    inherit arch;
    inherit system;
    inherit pkgs;
    inherit fenix;
    inherit awww;
  };
in
{
  imports = [
  ];
  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };
  home = {
    username = user;
    homeDirectory = home;
    stateVersion = "25.11";
    sessionVariables = {
      # SBARLUA_DYLIB_PATH = if os == "darwin" then "${pkgs.sbarlua.out}" else "";
      MYSQLCLIENT_LIB_DIR = "${pkgs.libmysqlclient.out}/lib/mariadb";
      MYSQLCLIENT_VERSION = "${pkgs.libmysqlclient.version}";
      LIBSQLITE = "${pkgs.sqlite.out}/lib/libsqlite3.so";
    };
    file = {
      ".gitconfig" = {
        target = ".gitconfig";
        source = ../.gitconfig;
      };
      ".gitconfig_p" = {
        target = ".gitconfig_p";
        source = ../.gitconfig_p;
      };
      ".npmrc" = {
        target = ".npmrc";
        source = ../.npmrc;
      };
      "ssh" = {
        target = ".ssh/config";
        source = ../.ssh/config;
      };
    };
    packages = mypkgs;
  };
  services = {
    swaync = {
      enable = true;
    };
    clipcat = {
      enable = true;
      enableSystemdUnit = true;
      ctlSettings = {
        server_endpoint = "/run/user/1000/clipcat/grpc.sock";
        log = {
          file_path = "/tmp/clpcat/clipcatctl.log";
          emit_journald = true;
          emit_stdout = false;
          emit_stderr = false;
          level = "INFO";
        };
      };
      daemonSettings = {
        daemonize = true;
        max_history = 100;
        primary_threshold_ms = 5000;
        log = {
          file_path = "/tmp/clipcat/clipcatd.log";
          emit_journald = true;
          emit_stdout = false;
          emit_stderr = false;
          level = "INFO";
        };
        watcher = {
          enable_clipboard = true;
          enable_primary = true;
          sensitive_mime_types = [ "x-kde-passwordManagerHint" ];
          denied_text_regex_patterns = [ ];
          filter_text_min_length = 1;
          filter_text_max_length = 65536;
          capture_image = true;
          filter_image_max_size = 5242880;
        };
        grpc = {
          enable_http = true;
          enable_local_socket = true;
          host = "127.0.0.1";
          port = 45045;
        };
        dbus = {
          enable = true;
          identifier = "instance-0";
        };
        desktop_notification = {
          enable = true;
          timeout_ms = 2000;
          long_plaintext_length = 2000;
        };
      };
      menuSettings = {
        server_endpoint = "/run/user/1000/clipcat/grpc.sock";
        log = {
          file_path = "/tmp/clipcat/clipcat-menu.log";
          emit_journald = true;
          emit_stdout = false;
          emit_stderr = false;
          level = "INFO";
        };
      };
    };
  };
  programs = {
    vesktop = {
      enable = true;
    };
    anyrun = {
      enable = true;
      config = {
        y = {
          fraction = 0.25;
        };
        width = {
          fraction = 0.3;
        };
        height = {
          fraction = 0.3;
        };
        closeOnClick = true;
        showResultsImmediately = true;
        maxEntries = 40;
        plugins = [
          "${pkgs.anyrun}/lib/libapplications.so"
          "${pkgs.anyrun}/lib/libsymbols.so"
          "${pkgs.anyrun}/lib/librink.so"
          "${pkgs.anyrun}/lib/libshell.so"
          # "${pkgs.anyrun}/lib/libtranslate.so"
          # "${pkgs.anyrun}/lib/libkidex.so"
          # "${pkgs.anyrun}/lib/librandr.so" this plugin only support hyprland
          # "${pkgs.anyrun}/lib/libstdin.so"
          "${pkgs.anyrun}/lib/libdictionary.so"
          "${pkgs.anyrun}/lib/libwebsearch.so"
          # "${pkgs.anyrun}/lib/libnix_run.so"
          "${pkgs.anyrun}/lib/libniri-focus.so"
        ];
      };
      extraConfigFiles = {
        "symbols.ron" = {
          source = ./home/anyrun/symbols.ron;
        };
        "applications.ron" = {
          source = ./home/anyrun/applications.ron;
        };
      };
      extraCss = builtins.readFile ./home/anyrun/anyrun.css;
    };
    firefox = {
      enable = true;
      profiles = {
        dflt = {
          isDefault = true;
          extensions = {
            force = true;
          };
          settings = {
            "browser.startup.homepage" = "https://www.google.com";
            "browser.toolbars.bookmarks.visibility" = "never";
            "browser.bookmarks.restore_default_bookmarks" = false;
            "browser.bookmarks.showMobileBookmarks" = false;
            "browser.crashReports.unsubmittedCheck.autoSubmit2" = true;
            "browser.search.region" = "US";
            "browser.toolbarbuttons.introduced.sidebar-button" = false;
            "sidebar.main.tools" = "syncedtabs,bookmarks,passwords";
            "sidebar.verticalTabs" = false;
            "sidebar.visibility" = "hide-sidebar";
            "widget.use-xdg-desktop-portal.file-picker" = 1;
            "widget.use-xdg-desktop-portal.mime-handler" = 1;
            "widget.use-xdg-desktop-portal.settings" = 1;
            "widget.use-xdg-desktop-portal.open-url" = 1;
          };
        };
      };
    };
  };
  xdg = {
    desktopEntries = {
      jf = {
        type = "Application";
        terminal = true;
        startupNotify = true;
        name = "jf";
        mimeType = [ "text/plain" ];
        icon = "nvim";
        genericName = "Text Editor";
        exec = "nvim";
        categories = [
          "Utility"
          "TextEditor"
        ];
      };
    };
    mimeApps = {
      enable = true;
      # defaultApplications = {
      #   "inode/directory" = "yazi.desktop";
      # };
    };
    portal = {
      enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-termfilechooser
        pkgs.xdg-desktop-portal-gnome
        pkgs.xdg-desktop-portal-gtk
      ];
      config = {
        common = {
          "org.freedesktop.impl.portal.FileChooser" = "termfilechooser";
        };
      };
    };
  };
  # dconf = {
  #   settings = {
  #     "org/gnome/desktop/interface".color-scheme = "prefer-dark";
  #   };
  # };
  systemd =
    if os == "darwin" then
      null
    else
      {
        user = {
          services = {
            # clipcat = {
            #   Unit = {
            #     Description = "clipcat daemon";
            #     PartOf = [ "graphical-session.target" ];
            #   };
            #   Install = {
            #     WantedBy = [ "graphical-session.target" ];
            #   };
            #   Service = {
            #     ExecStartPre = "${pkgs.coreutils-full}/bin/rm -f %t/clipcat/grpc.sock";
            #     ExecStart = "${pkgs.clipcat.out}/bin/clipcatd --no-daemon --replace";
            #     Restart = "on-failure";
            #     Type = "simple";
            #   };
            # };
            awww-daemon = {
              Install = {
                WantedBy = [ "graphical-session.target" ];
              };
              Unit = {
                Description = "simple wallpaper manager for wayland written in rust";
                After = [ "graphical-session.target" ];
                PartOf = [ "graphical-session.target" ];
                Requisite = [ "graphical-session.target" ];
              };
              Service = {
                ExecStart = "${awww.packages.${pkgs.system}.awww}/bin/awww-daemon";
                Restart = "on-failure";
              };
            };
            awww-random = {
              Unit = {
                Description = "randomly choose wallpaper";
              };
              Service = {
                ExecStart = "${pkgs.fish.out}/bin/fish -c 'rw'";
              };
            };
            system-appearance = {
              Unit = {
                Description = "set system appearance light/dark based on time";
              };
              Service = {
                ExecStart = "${pkgs.fish.out}/bin/fish -c 'auto_theme'";
              };
            };
            system-appearance-on-login = {
              Install = {
                WantedBy = [ "graphical-session.target" ];
              };
              Unit = {
                Description = "determines system appearance of on graphical-session login";
              };
              Service = {
                Type = "oneshot";
                ExecStart = "${pkgs.fish.out}/bin/fish -c 'auto_theme'";
                Restart = "on-failure";
              };
            };
          };
          timers = {
            awww-random = {
              Unit = {
                Description = "choose wallpaper randomly";
              };
              Timer = {
                OnCalendar = "*:0/5";
              };
              Install = {
                WantedBy = [ "graphical-session.target" ];
              };
            };
            system-appearance = {
              Unit = {
                Description = "system-appearance switcher based on time. set light theme at daytime and dark theme at night";
              };
              Timer = {
                OnCalendar = [
                  "*-*-* 06:00:00"
                  "*-*-* 18:00:00"
                ];
                Persistent = true;
              };
              Install = {
                WantedBy = [ "graphical-session.target" ];
              };
            };
          };
        };
      };
  launchd =
    if os == "linux" then
      { }
    else
      {
        agents = {
          tailscaled = {
            enable = true;
            config = {
              Label = "com.a.tailscaled";
              ProgramArguments = [
                "${pkgs.tailscale}/bin/tailscaled"
                "-tun userspace-networking"
                "-state ${home}/.tailscale.state"
              ];
              RunAtLoad = true;
              KeepAlive = true;
            };
          };
        };
      };
  catppuccin = {
    enable = true;
    accent = "sky";
    # flavor = "mocha";
    cursors = {
      enable = true;
      accent = "blue";
    };
    eza = {
      accent = "blue";
    };
    fcitx5 = {
      accent = "peach";
      enableRounded = true;
    };
    firefox = {
      accent = "sapphire";
      force = true;

    };
    gtk = {
      icon = {
        accent = "blue";
      };
    };
    swaync = {
      font = "PlemolJP Console NF";
    };
    vesktop = {
      accent = "mauve";
    };
    yazi = {
      accent = "green";
    };
  };
}
