{
	description = "A simple NixOS flake";
	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
		home-manager = {
			url = "github:nix-community/home-manager/release-24.05";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
	};
	outputs = { self, nixpkgs, home-manager, neovim-nightly-overlay, ... }@inputs: {
		nixosConfigurations = {
			utm_nix_a = nixpkgs.lib.nixosSystem {
				system = "aarch64-linux";
				specialArgs = {inherit inputs; };
				modules = [
					./hosts/utm_nix_a
					home-manager.nixosModules.home-manager{
						home-manager.useGlobalPkgs = true;
						home-manager.useUserPackages = true;
						home-manager.users.utm_nix_a = import ./home-manager/linux;
					}
				];
			};
		};
	};
}
