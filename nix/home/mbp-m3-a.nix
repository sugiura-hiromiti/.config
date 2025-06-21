{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: let
  username = "a";
  mypkgs = import ../darwin/aarch64 {inherit pkgs;} ++ [];
  common = import ./common {
    inherit username;
    inherit mypkgs;
  };
in {
  nixpkgs = common.nixpkgs;
  home = common.home;
}
