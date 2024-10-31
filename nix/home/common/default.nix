{ ... }: {
	imports = [
		./home-manager.nix
		./git.nix
	];
	home = {
		packages = with pkgs; [
			ripgrep
			eza
		];
	};
}
