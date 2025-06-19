{
  inputs,
  lib,
  config,
  pkgs,
  ...
}:
let
  username = "a";
  mypkgs = import ../darwin/aarch64 { inherit pkgs; };
in
{
  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };
  home = {
    username = username;
    homeDirectory = "/Users/${username}";
    stateVersion = "25.11";
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
    };
    packages = mypkgs ++ [ ];
  };
}
