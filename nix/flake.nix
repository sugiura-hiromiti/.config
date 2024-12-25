{
	description = "nix";
	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
		home-manager={
			url="github:nix-community/home-manager/release-24.05";
			inputs.nixpkgs.follows="nixpkgs";
		};
		neovim-nightly-overlay={
			url="github:nix-community/neovim-nightly-overlay";
		};
		rust-overlay={
			url="github:oxalica/rust-overlay";
			inputs.nixpkgs.follows="nixpkgs";
		};
	};
	outputs={nixpkgs,home-manager, ...} @inputs :{
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
		};
	};
}
