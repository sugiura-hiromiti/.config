{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: let
  username = "hiromichi.sugiura";
  mypkgs = import ../darwin/aarch64 {inherit pkgs;} ++ [];
  common = import ./common {
    inherit username;
    inherit mypkgs;
  };
in {
  nixpkgs = common.nixpkgs;
  home = common.home;
}
