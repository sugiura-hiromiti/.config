{config, lib, pkgs, inputs, ...}:{
	imports=[
		../../home-manager/darwin
	];
	users = {
		users = {
			a = {
				#isNormalUser = true;
				description = "default user";
				#extraGroups = ["wheel" "networkmanager"];
				shell = pkgs.zsh;
			};
		};
	};
	home = {
		username = "a";
		homeDirectory = "/Users/a";
	};
}
