{ config, pkgs, ... }:
{
	home = {
		stateVersion = "24.05";
		username = "utm_nix_a";
		homeDirectory = "/home/utm_nix_a";
		packages = with pkgs; [
			ripgrep
			eza
		];
	};
	programs = {
		git = {
			enable = true;
			userName = "sugiura-hiromiti";
			userEmail = "sugiura130418@icloud.com";
		};
		home-manager.enable = true;
	};
}
