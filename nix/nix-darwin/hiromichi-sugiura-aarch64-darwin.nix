{pkgs, ...}: let
  common = import ./common {
    username = "hiromichi.sugiura";
    pkgs = pkgs;
  };
in
  common
