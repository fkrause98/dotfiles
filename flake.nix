# ~/.config/nix/flake.nix

{
  description = "Fran's mac config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager }:
    let
      pkgs = (import nixpkgs) { allowUnfree = true; };

      configuration = { pkgs, ... }: {
        services.nix-daemon.enable = true;
        # Necessary for using flakes on this system.
        nix.settings.experimental-features = "nix-command flakes";
        nixpkgs.config.allowUnfree = true;
        system.configurationRevision = self.rev or self.dirtyRev or null;

        # Used for backwards compatibility. please read the changelog
        # before changing: `darwin-rebuild changelog`.
        system.stateVersion = 4;

        # The platform the configuration will be used on.
        # If you're on an Intel system, replace with "x86_64-darwin"
        nixpkgs.hostPlatform = "aarch64-darwin";

        # Declare the user that will be running `nix-darwin`.
        users.users.fran = {
          name = "fran";
          home = "/Users/fran";
        };

        # Create /etc/zshrc that loads the nix-darwin environment.
        programs.zsh.enable = true;
        programs.fish.enable = true;

        environment.systemPackages = [
          pkgs.fastfetch
          pkgs.vim
          pkgs.darwin.CF
          pkgs.darwin.apple_sdk.frameworks.SystemConfiguration
        ];
        homebrew = {
          enable = true;
          taps = [ ];
          brews = [ "docker" ];
          casks = [ "rectangle" "tg-pro" "iterm2" ];
        };
        security.pam.enableSudoTouchIdAuth = true;
        # Enable tap to click
        system.defaults.NSGlobalDomain."com.apple.mouse.tapBehavior" = 1;
      };
    in {
      darwinConfigurations."fran-mbp" = nix-darwin.lib.darwinSystem {
        modules = [
          configuration
          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.verbose = true;
            home-manager.users.fran = import ./home-manager/home.nix;
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
    };
}
