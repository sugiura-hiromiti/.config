{ config, pkgs, ... }:{
	imports = [
		../common
	];
	home = {
		username = "utm_nix_a";
		homeDirectory = "/home/utm_nix_a";
		# packages = with pkgs; [
		# 	spice-vdagent
		# ];
		stateVersion = "24.05";
	};
}
