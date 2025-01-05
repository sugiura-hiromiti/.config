{
	description = "nix";
	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
		home-manager={
			url="github:nix-community/home-manager/release-24.11";
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
	outputs={nixpkgs,home-manager, nix-darwin, ...} @inputs :
	let
		# make sure hostname is equal to username
		mkPlatform = { cpu, os, name, hmModule, setter }: setter {
			system = cpu + "-" + os;
			modules = [
				(./hosts + "/${name}")
				hmModule.home-manager {
					home-manager = {
						extraSpecialArgs = {
							inherit inputs;
						};
					};
					home-manager = {
						users = {
							${name} = import (./home-manager + "/${os}");
						};
					};
				}
			];
		};
	in
	{
		nixosConfigurations={
			# utm_nix_a=nixpkgs.lib.nixosSystem{
			# 	system="aarch64-linux";
			# 	modules=[
			# 		./hosts/utm_nix_a
			# 		home-manager.nixosModules.home-manager{
			# 			home-manager.extraSpecialArgs = {
			# 				inherit inputs;
			# 			};
			# 			home-manager.users.utm_nix_a = import ./home-manager/linux;
			# 		}
			# 	];
			# };
				utm_nix_a = mkPlatform {
					cpu="aarch64";
					os= "linux";
					name="utm_nix_a";
					hmModule	= home-manager.nixosModules;
					setter=nixpkgs.lib.nixosSystem;
				};
		};
		darwinConfigurations = {
			# a = nix-darwin.lib.darwinSystem {
			# 	system = "aarch64-darwin";
			# 	modules = [
			# 		./hosts/a
			# 		home-manager.darwinModules.home-manager{
			# 			home-manager.extraSpecialArgs = {
			# 				inherit inputs;
			# 			};
			# 			home-manager.users.a = import ./home-manager/darwin;
			# 		}
			# 	];
			# };
			a = mkPlatform {
				cpu="aarch64";
				os= "darwin";
				name="a";
				hmModule	= home-manager.darwinModules;
				setter=nix-darwin.lib.darwinSystem;
			};
		};
	};
}
