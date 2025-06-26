{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: let
  username = "xsugiurah";
  mypkgs = import ../linux/x86 {inherit pkgs;} ++ [];
  common = import ./common {
    inherit username;
    inherit mypkgs;
  };
in {
  nixpkgs = common.nixpkgs;
  home = common.home;
}
