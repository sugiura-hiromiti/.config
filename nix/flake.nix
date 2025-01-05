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
		rust-overlay={ url="github:oxalica/rust-overlay"; inputs = {
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
			system = ("${cpu}" + "-" + "${os}");
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
			# 		}
			# 	];
			# };
			utm_nix_a = mkPlatform "aarch64" "linux" "utm_nix_a" home-manager.nixosModules nixpkgs.lib.nixosSystem;
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
			a = mkPlatform "aarch64" "darwin" "a" home-manager.darwinModules nix-darwin.lib.darwinSystem;
		};
	};
}
