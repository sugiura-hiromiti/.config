# darwin/aarch64
{pkgs} @ inputs: let
  common = import ../common {inherit pkgs;};
  arch = import ../../common/aarch64 {inherit pkgs;};
in
  common
  ++ arch
  ++ [
  ]
