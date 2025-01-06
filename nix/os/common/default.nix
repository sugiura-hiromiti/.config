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
			dprint
			lua
			lua-language-server
			marksman
			taplo
			google-java-format
		];
	};
}
