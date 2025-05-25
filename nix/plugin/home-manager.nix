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
  };
}
