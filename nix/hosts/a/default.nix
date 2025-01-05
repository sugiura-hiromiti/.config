{config, lib, pkgs, inputs, ...}:{
	imports=[
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
}
