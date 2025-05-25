{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: let
  username = "a";
in {
  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };
  home = {
    username = username;
    homeDirectory = "/Users/${username}";
    stateVersion = "25.11";
  };
  programs = {
    home-manager = {
      enable = true;
    };
    neovim = {
      plugins = [
        {
          plugin = pkgs.vimPlugins.sqlite-lua;
          config = "vim.g.sqlite_clib_path = '${pkgs.sqlite.out}/lib/libsqlite3${builtins.stdenv.hostPlatform.extensions.sharedLibrary}'";
        }
      ];
    };
  };
}
