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
  # NOTE: idk this is required or not
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
      # ".clang-format" = {
      #   target = ".clang-format";
      #   source = ../.clang-format;
      # };
      # ".editorconfig" = {
      #   target = ".editorconfig";
      #   source = ../.editorconfig;
      # };
      ".gitconfig" = {
        target = ".gitconfig";
        source = ../.gitconfig;
      };
      ".gitconfig_p" = {
        target = ".gitconfig_p";
        source = ../.gitconfig_p;
      };
      # ".dprint.json" = {
      #   target = ".dprint.json";
      #   source = ../.dprint.json;
      # };
      # ".rustfmt.toml" = {
      #   target = ".rustfmt.toml";
      #   source = ../.rustfmt.toml;
      # };
      # ".stylua.toml" = {
      #   target = ".stylua.toml";
      #   source = ../.stylua.toml;
      # };
      ".npmrc" = {
        target = ".npmrc";
        source = ../.npmrc;
      };
      # "AGENTS.md" = {
      #   target = ".codex/AGENTS.md";
      #   source = ../codex/AGENTS.md;
      # };
      # "prompts" = {
      #   target = ".codex/prompts";
      #   source = ../codex/prompts;
      #   recursive = false;
      # };
    };
    packages = mypkgs;
  };
  programs = {
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
          settings = {
            "browser.startup.homepage" = "https://www.google.com";
            "browser.toolbars.bookmarks.visibility" = "never";
            "browser.bookmarks.restore_default_bookmarks" = false;
            "browser.bookmarks.showMobileBookmarks" = false;
            "browser.crashReports.unsubmittedCheck.autoSubmit2" = true;
            "browser.search.region" = "US";
            "browser.toolbarbuttons.introduced.sidebar-button" = true;
            "extensions.pictureinpicture.enable_picture_in_picture_overrides" = true;
            "media.videocontrols.picture-in-picture.enable-when-switching-tabs.enabled" = true;
            "sidebar.main.tools" = "syncedtabs,bookmarks,passwords";
            "sidebar.verticalTabs" = true;
          };
        };
      };
    };
  };
  # services = {
  #   darkman = {
  #     enable = true;
  #   };
  # };
  # xdg = {
  #   portal = {
  #     enable = true;
  #     config = {
  #       common = {
  #         "org.freedesktop.impl.portal.Settings" = "darkman";
  #       };
  #     };
  #   };
  # };
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
            # tailscaled = {
            #   Unit = {
            #     Description = "tailscale daemon";
            #     After = [ "network.target" ];
            #   };
            #   Service = {
            #     ExecStart = "${pkgs.tailscale}/bin/tailscaled -tun userspace-networking -state ~/.tailscale.state";
            #     Restart = "always";
            #   };
            #   Install = {
            #     WantedBy = [ "default.target" ];
            #   };
            # };
            system-appearance-sunrise = {
              Unit = {
                Description = "set system appearance light";
              };
              Service = {
                ExecStart = "${pkgs.dconf.out}/bin/dconf write /org/gnome/desktop/interface/color-scheme \"'prefer-light'\"";
              };
            };
            system-appearance-sunset = {
              Unit = {
                Description = "set system appearance dark";
              };
              Service = {
                ExecStart = "${pkgs.dconf.out}/bin/dconf write /org/gnome/desktop/interface/color-scheme \"'prefer-dark'\"";
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
                ExecStart = ''${pkgs.bash.out}/bin/sh -c '[ $(${pkgs.coreutils-full.out}/bin/date +%H) -ge 6 ] && [ $(${pkgs.coreutils-full.out}/bin/date +%H) -lt 18 ] && ${pkgs.dconf.out}/bin/dconf write /org/gnome/desktop/interface/color-scheme "\'prefer-light\'" || ${pkgs.dconf.out}/bin/dconf write /org/gnome/desktop/interface/color-scheme "\'prefer-dark\'"' '';
              };
            };
          };
          timers = {
            system-appearance-sunrise = {
              Unit = {
                Description = "system-appearance switcher based on time. set light theme on sunrise";
              };
              Timer = {
                OnCalendar = [
                  "*-*-* 06:00:00"
                ];
                Persistent = true;
              };
              Install = {
                WantedBy = [ "graphical-session.target" ];
              };
            };
            system-appearance-sunset = {
              Unit = {
                Description = "system-appearance switcher based on time. set dark theme on sunset";
              };
              Timer = {
                OnCalendar = [
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
}
