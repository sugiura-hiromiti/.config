{pkgs, ...}: let
  common = import ./common {};
in {
  system = common.system;
}
