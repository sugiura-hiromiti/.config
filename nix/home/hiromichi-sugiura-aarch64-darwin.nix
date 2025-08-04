{
  inputs,
  user,
  os,
  arch,
  home,
  system,
  user-system,
  lib,
  config,
  pkgs,
  ...
}: let
  username = "hiromichi.sugiura";
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
