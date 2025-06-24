# ~/.config/nix/flake.nix
{
  description = "nixxxxxxxxxxxxxxxxxxxxxxxx";
  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs?ref=nixos-unstable";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs = {
        nixpkgs = {
          follows = "nixpkgs";
        };
      };
    };
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs = {
        nixpkgs = {
          follows = "nixpkgs";
        };
      };
    };
    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
    };
  };
  outputs = {
    self,
    nixpkgs,
    neovim-nightly-overlay,
    home-manager,
    nix-darwin,
  } @ inputs: let
    secret = import ./secret.nix {};
    user = builtins.replaceStrings ["."] ["-"] secret.username;
    system = secret.system;
    user-system = "${user}-${system}";
    nixpkgs-overlayed = import nixpkgs {
      overlays = [inputs.neovim-nightly-overlay.overlays.default];
      inherit system;
    };
  in {
    homeConfigurations = {
      conf = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs-overlayed;
        extraSpecialArgs = {
          inherit inputs;
        };
        modules = [
          ./home/${user-system}.nix
          # ./darwin/aarch64
        ];
      };
      # mbp-m2-hiromichi-sugiura-aarch64-darwin = home-manager.lib.homeManagerConfiguration {
      #   pkgs = import nixpkgs-overlayed;
      #   extraSpecialArgs = {
      #     inherit inputs;
      #   };
      #   modules = [
      #     ./home/mbp-m2-hiromichi-sugiura.nix
      #     # ./darwin/aarch64
      #   ];
      # };
    };

    darwinConfigurations = {
      conf = nix-darwin.lib.darwinSystem {
        inherit system;
        modules = [
          ./nix-darwin/${user-system}.nix
        ];
      };
      # mbp-m2-hiromichi-sugiura-aarch64 = nix-darwin.lib.darwinSystem {
      #   system = "aarch64-darwin";
      #   modules = [
      #     ./nix-darwin/mbp-m2-hiromichi-sugiura.nix
      #   ];
      # };
    };
    # darwinConfigurations."${user}-${system}".system = system;

    apps.${system}.update = {
      type = "app";
      program = toString (
        nixpkgs-overlayed.writeShellScript "update-script" ''
          set -e
          echo "
          -------------------------------------------"
          echo "user: ${user}"
          echo "system: ${system}"
          echo "-------------------------------------------
          "
          git stage .
          echo "

          -------------------------------------------"
          echo "updating flake"
          echo "-------------------------------------------
          "
          nix flake update
          echo "

          -------------------------------------------"
          echo "updating home-manager"
          echo "-------------------------------------------
          "
          nix run nixpkgs#home-manager -- switch --flake .#conf
          echo "

          -------------------------------------------"
          echo "updating nix-darwin"
          echo "-------------------------------------------
          "
          sudo nix run nix-darwin -- switch --flake .#conf
          echo "

          -------------------------------------------"
          echo "update complete!"
          echo "-------------------------------------------
          "
        ''
      );
    };
    # apps.aarch64-darwin.update-flkt = {
    #   type = "app";
    #   program = toString (
    #     (import nixpkgs-overlayed { system = "aarch64-darwin"; }).writeShellScript "update-script" ''
    #       set -e
    #       echo "reflect file change"
    #       git stage .
    #       echo "updating flake..."
    #       nix flake update
    #       echo "updating home-manager..."
    #       nix run nixpkgs#home-manager -- switch --flake .#mbp-m2-hiromichi-sugiura-aarch64-darwin
    #       echo "updating nix-darwin..."
    #       sudo nix run nix-darwin -- switch --flake .#mbp-m2-hiromichi-sugiura-aarch64
    #       echo "update complete!"
    #     ''
    #   );
    # };

    # packages.aarch64-darwin.default = (pkgsFor "aarch64-darwin").buildEnv {
    #   name = "mypkg";
    #   paths = import ./darwin/aarch64 { legacy = pkgsFor "aarch64-darwin"; };
    # };
    #
    # packages.aarch64-linux.default = (pkgsFor "aarch64-linux").buildEnv {
    #   name = "mypkg";
    #   paths = import ./linux/aarch64 { legacy = pkgsFor "aarch64-linux"; };
    # };
    #
    # packages.x86_64-darwin.default = (pkgsFor "x86_64-darwin").buildEnv {
    #   name = "mypkg";
    #   paths = import ./darwin/x86_64 { legacy = pkgsFor "x86_64-darwin"; };
    # };
    #
    # packages.x86_64-linux.default = (pkgsFor "x86_64-linux").buildEnv {
    #   name = "mypkg";
    #   paths = import ./linux/x86_64 { legacy = pkgsFor "x86_64-linux"; };
    # };

    #   homeConfigurations = {
    #     a = home-manager.lib.homeManagerConfiguration {
    #       pkgs = import nixpkgs {
    #         system = "aarch64-darwin";
    #         config.allowUnfree = true;
    #       };
    #       extraSpecialArgs = {inherit inputs;};
    #       modules = [
    #         ./plugin/home-manager.nix
    #       ];
    #     };
    #   };
    #   darwinConfigurations = {
    #     a = nix-darwin.lib.darwinSystem {
    #       pkgs = import nixpkgs {
    #         system = "aarch64-darwin";
    #         hostPlatform = "aarch64-darwin";
    #         config.allowUnfree = true;
    #       };
    #       modules = [./plugin/nix-darwin.nix];
    #     };
    #   };
  };
}
