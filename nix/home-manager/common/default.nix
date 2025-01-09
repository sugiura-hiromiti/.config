{ pkgs, ... }@inputs:{
	nixpkgs = {
		config = {
			allowUnfree = true;
		};
		overlays = [
			inputs.inputs.rust-overlay.overlays.default
			inputs.inputs.neovim-nightly-overlay.overlays.default
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
		stateVersion = "24.11";
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
			git
			discord-ptb
			docker
			slack
			dprint
			lua
			lua-language-server
			taplo
			google-java-format
			zellij
			sqlite
			jdtls
			tailwindcss-language-server
			docker-compose-language-service
			dockerfile-language-server-nodejs
			vscode-langservers-extracted
			nil
			typescript
			typescript-language-server
			nixfmt-rfc-style
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
			autocd = true;
			syntaxHighlighting = {
				enable = true;
			};
			history = {
				save = 1000;
			};
			shellAliases = {
				n = "nvim";
				s = "eza";
				zo = "z $OLDPWD";
				wh = "which -a";
			};
			envExtra = ''
				function chpwd_print_dir() {
					if [[ $(pwd) != $HOME ]]; then;
						# alias `s` will be expanded
						s
					fi
				}

				# register hook function
				autoload -Uz add-zsh-hook
				add-zsh-hook chpwd chpwd_print_dir
			'';
			initExtraFirst = ''
				[[ -f "''${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh" ]] && builtin source "''${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh"
			'';
			initExtra = ''
				[[ -f "''${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh" ]] && builtin source "''${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh"
			'';
			profileExtra = ''
				[[ -f "''${HOME}/Library/Application Support/amazon-q/shell/zprofile.pre.zsh" ]] && builtin source "''${HOME}/Library/Application Support/amazon-q/shell/zprofile.pre.zsh"

[[ -f "''${HOME}/Library/Application Support/amazon-q/shell/zprofile.post.zsh" ]] && builtin source "''${HOME}/Library/Application Support/amazon-q/shell/zprofile.post.zsh"
			'';
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
	};
}
