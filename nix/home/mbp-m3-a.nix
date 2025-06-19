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
    packages = mypkgs ++ [ ];
  };
}
