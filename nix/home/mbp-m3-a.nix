{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: let
  username = "a";
  mypkgs = import ../darwin/common {inherit pkgs;};
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
    packages = mypkgs ++ [];
  };
  programs = {
    home-manager = {
      enable = true;
    };
  };
}
