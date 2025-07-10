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
  outputs =
    {
      self,
      nixpkgs,
      neovim-nightly-overlay,
      home-manager,
      nix-darwin,
    }@inputs:
    let
      secret = import ./secret.nix { };
      user = builtins.replaceStrings [ "." ] [ "-" ] secret.username;
      system = secret.system;
      user-system = "${user}-${system}";
      nixpkgs-overlayed = import nixpkgs {
        overlays = [ inputs.neovim-nightly-overlay.overlays.default ];
        inherit system;
      };
    in
    {
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
      };

      darwinConfigurations = {
        conf = nix-darwin.lib.darwinSystem {
          inherit system;
          modules = [
            ./nix-darwin/${user-system}.nix
          ];
        };
      };

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
            echo "cleaning up store"
            echo "-------------------------------------------
            "

            echo "

            -------------------------------------------"
            echo "update complete!"
            echo "-------------------------------------------
            "
          ''
        );
      };
    };
}
