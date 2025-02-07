{ config, pkgs, lib, ... }:{
	imports = [
		../common
	];
	home = {
		username = "utm_nix_a";
		homeDirectory = lib.mkForce "/home/utm_nix_a";
		#stateVersion="25.05";
		# packages = with pkgs; [
		# 	spice-vdagent
		# ];
	};
}
