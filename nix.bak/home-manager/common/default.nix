{ pkgs, ... }@inputs:{
	nixpkgs = {
		config = {
			allowUnfree = true;
		};
		overlays = [
			inputs.inputs.rust-overlay.overlays.default
			# NOTE: avoid using
			# inputs.inputs.neovim-nightly-overlay.overlays.default
		];
	};
	nix = {
		settings = {
			experimental-features = ["nix-command" "flakes"];
		};
	};
	# wayland = {
	# 	windowManager = {
	# 		hyprland = {
	# 			enable =true;
	# 		};
	# 	};
	# };
	home = {
		stateVersion = "25.05";
		packages = with pkgs; [
			ripgrep
			eza
			clang
			starship
			marksman
			deno
			nodejs
			rm-improved
			skim
			fd
			gitui
			stylua
			wabt
			zoxide
			gh
			rust-bin.nightly.latest.complete
			neovim
			curl
			wget
			# git
			docker
			dprint
			lua
			lua-language-server
			taplo
			google-java-format
			zellij
			sqlite
			jdt-language-server
			tailwindcss-language-server
			docker-compose-language-service
			dockerfile-language-server-nodejs
			vscode-langservers-extracted
			nil
			typescript
			typescript-language-server
			nixfmt-rfc-style
			firefox
		];
	};
	programs = {
		home-manager = {
			enable = true;
		};
		git = {
			enable = true;
			userName = "sugiura-hiromiti";
			userEmail = "sugiura130418@icloud.com";
		};
		zsh = {
			enable = true;
		};
		ripgrep = {
			enable = true;
		};
		eza = {
			enable = true;
			git = true;
			icons = "auto";
			extraOptions = [
				"-a"
				"-h"
				"-l"
				"--group-directories-first"
				"--sort=extension"
				"--time-style=iso"
				"--no-user"
				"--no-time"
			];
		};
		starship = {
			enable = true;
		};
		skim = {
			enable =true;
			defaultCommand = "fd";
			changeDirWidgetCommand = "fd --type d";
			fileWidgetCommand = "fd --type f";
		};
		fd = {
			enable = true;
			hidden = true;
		};
		gitui = {
			enable = true;
		};
		zoxide = {
			enable = true;
		};
		firefox={enable =true;};
	};
}
