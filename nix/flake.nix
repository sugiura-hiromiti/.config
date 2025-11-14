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
    fenix = {
      url = "github:nix-community/fenix";
      inputs = {
        nixpkgs = {
          follows = "nixpkgs";
        };
      };
    };
  };
  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      nix-darwin,
      neovim-nightly-overlay,
      fenix,
    }@inputs:
    let
      secret = import ./secret.nix { };
      user = secret.user;
      arch = secret.arch;
      os = secret.os;
      home = secret.home;
      system = "${arch}-${os}";
      user-system = "${builtins.replaceStrings [ "." ] [ "-" ] user}-${system}";
      nixpkgs-overlayed = import nixpkgs {
        overlays = [ neovim-nightly-overlay.overlays.default ];
        inherit system;
      };
    in
    {
      nixosConfigurations = {
        conf = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./nixos/configuration.nix
          ];
        };
      };

      homeConfigurations = {
        conf = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs-overlayed;
          extraSpecialArgs = {
            inherit inputs;
            inherit user;
            inherit os;
            inherit arch;
            inherit home;
            inherit system;
            inherit user-system;
            inherit fenix;
          };
          modules = [
            ./home.nix
          ];
        };
      };

      darwinConfigurations = {
        conf = nix-darwin.lib.darwinSystem {
          inherit system;
          specialArgs = {
            inherit user;
            inherit arch;
            inherit os;
          };
          modules = [
            ./nix-darwin
          ];
        };
      };

      apps.${system}.update = {
        type = "app";
        program = toString (
          nixpkgs-overlayed.writeShellScript "update-script" ''
            set -e
            echo "-------------------------------------------"
            echo "user: ${user}"
            echo "system: ${system}"
            echo "-------------------------------------------"
            git stage .
            echo "
            -------------------------------------------"
            echo "updating flake"
            echo "-------------------------------------------
            "
            echo -ne "\033]0;updating flake\007"
            nix flake update
            echo "
            -------------------------------------------"
            echo "updating home-manager"
            echo "-------------------------------------------
            "
            echo -ne "\033]0;updating home-manager\007"
            nix run nixpkgs#home-manager -- switch --flake .#conf

            if [ $(uname) = "Darwin" ]; then
              echo "
              -------------------------------------------"
              echo "updating nix-darwin"
              echo "-------------------------------------------
              "
              echo -ne "\033]0;updating nix-darwin\007"
              sudo nix run nix-darwin -- switch --flake .#conf
            elif grep -qi nixos /etc/os-release; then
              echo "
              -------------------------------------------"
              echo "updating nix-darwin"
              echo "-------------------------------------------
              "
              echo -ne "\033]0;updating nix-darwin\007"
              sudo nixos-rebuild switch --flake .#conf
            fi

            echo "
            -------------------------------------------"
            echo "update complete!"
            echo "-------------------------------------------
            "

            echo -e "\033]777;notify;nix;update completed\007"
          ''
        );
      };
    };
}
