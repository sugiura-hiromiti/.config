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
    pkgsFor = system:
      import nixpkgs {
        inherit system;
        overlays = [inputs.neovim-nightly-overlay.overlays.default];
        config.allowUnfree = true;
      };
  in {
    homeConfigurations = {
      mbp-m3-a-aarch64-darwin = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          system = "aarch64-darwin";
        };
        extraSpecialArgs = {
          inherit inputs;
        };
        modules = [
          ./home/mbp-m3-a.nix
          # ./darwin/aarch64
        ];
      };
      mbp-m2-hiromichi-sugiura-aarch64-darwin = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          system = "aarch64-darwin";
        };
        extraSpecialArgs = {
          inherit inputs;
        };
        modules = [
          ./home/mbp-m2-hiromichi-sugiura.nix
          # ./darwin/aarch64
        ];
      };
    };

    darwinConfigurations = {
      mbp-m3-a-aarch64 = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          ./nix-darwin/mbp-m3-a.nix
        ];
      };
    };

    # apps.aarch64-darwin.update = {
    #   type = "app";
    #   program = toString (
    #     pkgs.writeShellScript "update-script" ''
    #       set -e
    #       echo "updating flake..."
    #       nix flake update
    #       echo "updating home-manager..."
    #       nix run nixpkgs#home-manager -- switch --flake .#mbp-m3-a-aarch64-darwin
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
