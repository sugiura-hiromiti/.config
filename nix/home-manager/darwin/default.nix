{pkgs, lib, ...}:{
	imports = [
		../common
	];
	home={
		homeDirectory = lib.mkForce "/Users/a";
	};
}
