{pkgs, ...}:{
	nixpkgs = {
		config = {
			allowUnfree = true;
			allowBroken = true;
		};
	};
	environment={
		systemPackages = with pkgs; [
			curl
			wget
			git
			discord-ptb
			docker
			slack
		];
	};
}
