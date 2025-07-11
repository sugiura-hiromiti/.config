{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: let
  username = "a";
  homeDir = "/Users/${username}";
  mypkgs = import ../darwin/aarch64 {inherit pkgs;} ++ [];
  common = import ./common {
    inherit username;
    inherit mypkgs;
    inherit homeDir;
    inherit pkgs;
  };
in {
  nixpkgs = common.nixpkgs;
  home = common.home;
}
