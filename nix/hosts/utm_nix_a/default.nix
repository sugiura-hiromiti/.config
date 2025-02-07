{ config, lib, pkgs, inputs, ... }:{
	imports =[
		./hardware-configuration.nix
	];
	users = {
		users = {
			utm_nix_a = {
				isNormalUser = true;
				description = "default user";
				extraGroups = ["wheel" "networkmanager"];
				shell = pkgs.zsh;
			};
		};
	};
	networking = {
		networkmanager ={
			enable = true;
		};
		hostName = "utm_nix_a";
		# wireless = {
		# 	enable =true;
		# };
	};
	boot = {
		loader = {
			systemd-boot = {
				enable = true;
			};
			efi = {
				canTouchEfiVariables = true;
			};
		};
	};
	time = {
		timeZone = "Asia/Tokyo";
	};
	environment= {
		systemPackages = with pkgs; [
			wget
			curl
			# zsh
			git
		];
		# variables={
		# 	EDITOR="nvim";
		# };
	};
	system = {
		#copySystemConfiguration = true;
		stateVersion = "25.05";
	};
	programs = {
		zsh = {
			enable = true;
		};
	};
	# nix = {
	# 	settings = {
	# 		experimental-features = ["nix-command" "flakes"];
	# 	};
	# };
}
