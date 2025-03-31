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
	outputs = {nixpkgs, home-manager, nix-darwin, ...} @inputs :{};
}
