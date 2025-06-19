# linux/aarch64
{legacy}: let
  common = import ../common {inherit legacy;};
  aarch64 = import ../../common/aarch64 {inherit legacy;};
in
  common
  ++ aarch64
  ++ [
    legacy.slacky
  ]
