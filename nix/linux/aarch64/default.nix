# linux/aarch64
{pkgs}: let
  common = import ../common {inherit pkgs;};
  aarch64 = import ../../common/aarch64 {inherit pkgs;};
in
  common
  ++ aarch64
  ++ [
    pkgs.slacky
  ]
