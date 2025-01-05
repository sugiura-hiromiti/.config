{ config, pkgs, ... }:
{
	imports = [
		../common
	];
	home = {
		stateVersion = "24.05";
		username = "utm_nix_a";
		homeDirectory = "/home/utm_nix_a";
	};
}
