# linux/x86
{pkgs}: let
  common = import ../common {inherit pkgs;};
  x86 = import ../../common/x86 {inherit pkgs;};
in
  common
  ++ x86
  ++ [
    pkgs.discord
    # pkgs.minecraft
    pkgs.slack
    pkgs.vital
  ]
