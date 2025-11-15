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
  mypkgs = import ./pkg {
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
      MYSQLCLIENT_LIB_DIR = "${pkgs.libmysqlclient.out}/lib/mariadb";
      MYSQLCLIENT_VERSION = "${pkgs.libmysqlclient.version}";
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
      "AGENTS.md" = {
        target = ".codex/AGENTS.md";
        source = ../codex/AGENTS.md;
      };
      "prompts" = {
        target = ".codex/prompts";
        source = ../codex/prompts;
        recursive = false;
      };
    };
    packages = mypkgs;
  };
  programs = {
    niri = {
      settings = null;
      enable = true;
    };
  };
}
