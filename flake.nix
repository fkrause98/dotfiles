# ~/.config/nix/flake.nix

{
  description = "Fran's mac config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
        url = "github:LnL7/nix-darwin";
        inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs }:
  let
    configuration = {pkgs, ... }: {

        services.nix-daemon.enable = true;
        # Necessary for using flakes on this system.
        nix.settings.experimental-features = "nix-command flakes";

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

	environment.systemPackages = [ pkgs.fastfetch pkgs.vim ];
	homebrew = {
		enable = true;
		taps = [];
		brews = [];
		casks = [ "tgpro" "rectangle" ];
	};
	security.pam.enableSudoTouchIdAuth = true;
   };
  in
  {
    darwinConfigurations."fran-mbp" = nix-darwin.lib.darwinSystem {
      modules = [
         configuration
      ];
    };
  };
}
