{
	description = "nix";
	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
		home-manager={
			url="github:nix-community/home-manager";
			inputs = {
				nixpkgs = {
					follows = "nixpkgs";
				};
			};
		};
		nix-darwin = {
			url = "github:LnL7/nix-darwin";
			inputs = {
				nixpkgs = {
					follows = "nixpkgs";
				};
			};
		};
		neovim-nightly-overlay={
			url="github:nix-community/neovim-nightly-overlay";
		};
		rust-overlay={
			url="github:oxalica/rust-overlay";
			inputs = {
				nixpkgs = {
					follows = "nixpkgs";
				};
			};
		};
	};
	outputs={nixpkgs,home-manager, nix-darwin, pkgs, ...} @inputs :
	# let
	# 	# make sure hostname is equal to username
	# 	mkPlatform = { cpu, os, name, hmModule, setter }: setter {
	# 		system = cpu + "-" + os;
	# 		users = {
	# 			users = {
	# 				${name} = {
	# 					#isNormalUser = true;
	# 					description = "default user";
	# 					#extraGroups = ["wheel" "networkmanager"];
	# 					shell = pkgs.zsh;
	# 				};
	# 			};
	# 		};
	# 		modules = [
	# 			(./os + "/${os}")
	# 			hmModule.home-manager {
	# 				home-manager = {
	# 					extraSpecialArgs = {
	# 						inherit inputs;
	# 					};
	# 				};
	# 				home-manager = {
	# 					users = {
	# 						${name} = import (./hosts + "/${name}");
	# 					};
	# 				};
	# 			}
	# 		];
	# 	};
	# in
	{
		nixpkgs = {
			config = {
				allowUnfree = true;
			};
		};
		nixosConfigurations={
			utm_nix_a=nixpkgs.lib.nixosSystem{
				system="aarch64-linux";
				modules=[
					./hosts/utm_nix_a
					home-manager.nixosModules.home-manager{
						home-manager.extraSpecialArgs = {
							inherit inputs;
						};
						home-manager.users.utm_nix_a = import ./home-manager/linux;
					}
				];
			};
				# utm_nix_a = mkPlatform {
				# 	cpu="aarch64";
				# 	os= "linux";
				# 	name="utm_nix_a";
				# 	hmModule	= home-manager.nixosModules;
				# 	setter=nixpkgs.lib.nixosSystem;
				# };
		};
		darwinConfigurations = {
			a = nix-darwin.lib.darwinSystem {
				system = "aarch64-darwin";
				modules = [
					./hosts/a
					# home-manager.darwinModules.home-manager{
					# 	home-manager.extraSpecialArgs = {
					# 		inherit inputs;
					# 	};
					# 	home-manager.users.a = import ./home-manager/darwin;
					# }
				];
				specialArgs={inherit	inputs;};
			};
			# a = mkPlatform {
			# 	cpu="aarch64";
			# 	os= "darwin";
			# 	name="a";
			# 	hmModule = home-manager.darwinModules;
			# 	setter=nix-darwin.lib.darwinSystem;
			# };
		};
	};
}
