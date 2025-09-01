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
  ...
}:
let
  mypkgs = import ../pkg {
    inherit user;
    inherit os;
    inherit arch;
    inherit system;
    inherit pkgs;
    inherit fenix;
  };
in
{
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
      SBARLUA_DYLIB_PATH = if os == "darwin" then "${pkgs.sbarlua.out}" else "";
    };
    file = {
      ".clang-format" = {
        target = ".clang-format";
        source = ../../.clang-format;
      };
      ".editorconfig" = {
        target = ".editorconfig";
        source = ../../.editorconfig;
      };
      ".gitconfig" = {
        target = ".gitconfig";
        source = ../../.gitconfig;
      };
      ".gitconfig_p" = {
        target = ".gitconfig_p";
        source = ../../.gitconfig_p;
      };
      ".dprint.json" = {
        target = ".dprint.json";
        source = ../../.dprint.json;
      };
      ".rustfmt.toml" = {
        target = ".rustfmt.toml";
        source = ../../.rustfmt.toml;
      };
      ".stylua.toml" = {
        target = ".stylua.toml";
        source = ../../.stylua.toml;
      };
      ".zshenv" = {
        target = ".zshenv";
        source = ../../.zshenv;
      };
      ".zshrc" = {
        target = ".zshrc";
        source = ../../.zshrc;
      };
      ".npmrc" = {
        target = ".npmrc";
        source = ../../.npmrc;
      };
      # "codex" = {
      #   target = ".codex/config.toml";
      #   source = ../../codex/config.toml;
      # };
    };
    packages = mypkgs;
  };
  wayland = {
    windowManager = {
      hyprland = {
        enable = true;
        settings = {
          "$mod" = "SUPER";
        };
      };
    };
  };
}
