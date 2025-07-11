{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: let
  username = "xsugiurah";
  homeDir = "/home/xsugiurah";
  mypkgs = import ../linux/x86 {inherit pkgs;} ++ [];
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
