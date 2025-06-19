# darwin/aarch64
{pkgs, ...} @ inputs: let
  common = import ../common {legacy = pkgs;};
  arch = import ../../common/aarch64 {legacy = pkgs;};
in
  common
  ++ arch
  ++ [
  ]
