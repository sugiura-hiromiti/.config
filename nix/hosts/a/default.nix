{config, lib, pkgs, inputs, ...}:{
	imports=[
		../../home-manager/darwin
	];
	home = {
		username = "a";
		homeDirectory = "/Users/a";
	};
}
