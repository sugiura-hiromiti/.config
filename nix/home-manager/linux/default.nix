{ config, pkgs, lib, ... }:{
	imports = [
		../common
	];
	home = {
		username = "utm_nix_a";
		homeDirectory = lib.mkForce "/home/utm_nix_a";
		# packages = with pkgs; [
		# 	spice-vdagent
		# ];
	};
}
