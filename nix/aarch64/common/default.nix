# aarch64/common/default.nix
{pkgs, neovim-nightly-overlay,  ...}:{
	imports=[
		../../common/common
	];

	home-manager.darwinModules.home-manager ={
		useGlobalPkgs=true;
			useUserPackages=true;
			users = {
				a = {
					home = {
						packages = with pkgs; [
					];
				};
			};
		};
	};
}
