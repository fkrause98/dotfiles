# ~/.config/nix/flake.nix

{
  description = "Fran's mac config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/24.11";

    nix-darwin = {
      url = "github:LnL7/nix-darwin/nix-darwin-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    darwin-emacs = {
      url = "github:c4710n/nix-darwin-emacs";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nix-darwin, nixpkgs, home-manager, darwin-emacs }:
    let
      darwinConfig = import ./nix-configs/mac.nix {
        pkgs = nixpkgs.legacyPackages.aarch64-darwin;
        self = self;
      };
      darwinSystem = nix-darwin.lib.darwinSystem {
        modules = [
          { nixpkgs = { overlays = [ darwin-emacs.overlays.emacs ]; }; }
          darwinConfig
          home-manager.darwinModules.home-manager
          {
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = ".manager.backup";
            home-manager.verbose = true;
            home-manager.users.fran = import ./home.nix;
            home-manager.extraSpecialArgs = {
              vars = rec {
                isMac = true;
                isLinux = false;
                home = "/Users/fran";
                emacsConfig = ./doom;
                fishNixPath = home + "/.nix-profile/bin/fish";
              };
            };
          }
        ];
      };
    in {
      homeConfigurations."fran" = home-manager.lib.homeManagerConfiguration {
        modules = [ ./home.nix ];
        pkgs = nixpkgs.legacyPackages."x86_64-linux";
        extraSpecialArgs = {
          vars = rec {
            isMac = false;
            isLinux = true;
            home = "/home/fran";
            emacsConfig = ./doom;
            fishNixPath = home + "/.nix-profile/bin/fish";
          };
        };
      };
      darwinConfigurations.arrakis = darwinSystem;
      darwinConfigurations.fran-mbp = darwinSystem;
    };
}
