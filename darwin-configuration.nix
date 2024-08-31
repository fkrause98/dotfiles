{ config, pkgs, ... }:

{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages =
    [ pkgs.vim
    ];

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  #environment.darwinConfig = "$HOME/.config/nixpkgs/darwin/configuration.nix";

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  nix = {
	  package = pkgs.nix;
	  settings = {
	  "extra-experimental-features" = [ "nix-command" "flakes" ];
	};
  };
  homebrew = {
		enable = true;
		casks =  [ "firefox" "rectangle" "tg-pro" ];
	};
  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true;  # default shell on catalina
  programs.fish.enable = true;
  fonts.packages = with pkgs; [
    fira-code
    jetbrains-mono
  ];

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
  system.defaults = {
        finder = {
		ShowPathbar = true;
		AppleShowAllExtensions = true;
		FXEnableExtensionChangeWarning = false;
        };
  };
}
