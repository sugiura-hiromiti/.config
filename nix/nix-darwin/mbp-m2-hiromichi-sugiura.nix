{pkgs, ...}: let
  common = import ./common {
    username = "hiromichi.sugiura";
    inherit pkgs;
  };
in
  common
