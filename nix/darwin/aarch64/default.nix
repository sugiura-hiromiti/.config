# darwin/aarch64
{...} @ inputs: let
  common = import ../common {legacy = inputs.pkgs;};
  arch = import ../../common/aarch64 {legacy = inputs.pkgs;};
in
  common
  ++ arch
  ++ [
  ]
