{ config, lib, pkgs, modulePath, ... }:{
	imports = [ ];
	boot = {
		initrd = {
			availableKernelModules = ["xhci_pci"];
			kernelModules = [ ];
		};
		kernelModules = [ ];
		extraModulePackages = [ ];
	};
	fileSystems = {
		"/" = {
			device = "/dev/disk/by-uuid/07a98c34-f31b-497e-be53-18627891bbc5";
			fsType = "ext4";
		};
		"/boot" = {
			device = "/dev/disk/by-uuid/EF1A-BB40";
			fsType = "vfat";
			options = [ "fmask=0077" "dmask=0077" ];
		};
	};
	swapDevices = [ ];
	networking = {
		useDHCP = lib.mkDefault true;
	};
	nixpkgs = {
		hostPlatform = lib.mkDefault "aarch64-linux";
	};
}
