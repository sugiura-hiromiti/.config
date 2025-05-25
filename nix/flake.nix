# make
{
	description="nix";
	inputs={
		nixpkgs.url="github:NixOS/nixpkgs/nixos-unstable";
		home-manager={
			url="github:nix-community/home-manager";
			inputs={
				nixpkgs = {
					follows="nixpkgs";
				};
			};
		};
		nix-darwin={
			url = "github:LnL7/nix-darwin";
			inputs = {
				nixpkgs = {
					follows = "nixpkgs";
				};
			};
		};
		neovim-nightly-overlay = {
			url = "github:nix-community/neovim-nightly-overlay";
		};
		rust-overlay = {
			url = "github:oxalica/rust-overlay";
			inputs = {
				nixpkgs = {
					follows = "nixpkgs";
				};
			};
		};
	};
	outputs = {nixpkgs, home-manager, nix-darwin, neovim-nightly-overlay, rust-overlay, ...}@inputs:
	{
		darwinConfigurations.a=nix-darwin.lib.darwinSystem{
			system="aarch64-darwin";
			modules=[
				./aarch64/darwin
				{
					nixpkgs={
						config={
							allowUnfree=true;
						};
					};
				}
			];
			specialArgs={inherit inputs;};
		};

		# packages.aarch64-darwin.default=nixpkgs.legacyPackages.aarch64-darwin.buildEnv{
		# 	name="mypkgs";
		# 	paths = import ./aarch64/darwin;
		# };
		# package.aarch64-linux.default=nixpkgs.legacyPackages.aarch64-linux.buildEnv{
		# 	name="mypkg";
		# 	paths = [
		# 		import ./aarch64/linux
		# 	];
		# };
	};
}
