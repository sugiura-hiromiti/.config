# darwin/aarch64
{legacy, ...} @ inputs: let
  common = import ../common {inherit legacy;};
  arch = import ../../common/aarch64 {inherit legacy;};
in
  common
  ++ arch
  ++ [
  ]
