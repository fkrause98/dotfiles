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
      configuration = { pkgs, ... }: rec {
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

        programs.zsh.enable = false;
        programs.fish.enable = true;
        services.emacs = {
          enable = true;
          package = pkgs.emacs-macport;
        };

        environment.systemPackages = with pkgs; [
          ((emacsPackagesFor emacs-macport).emacsWithPackages
            (epkgs: [ epkgs.vterm ]))
          fastfetch
          vim
          darwin.CF
          darwin.apple_sdk.frameworks.SystemConfiguration
          colima
          asdf-vm
          wxGTK32
          elixir-ls
          iterm2
          ngrok
          protobuf
          libiconv
          # omnisharp-roslyn
          # dotnet-sdk_7
          rustup
          (import ./home-manager/lsp-booster.nix { pkgs = pkgs; })
          nodejs_18
          yarn
          sqlx-cli
        ];

        homebrew = {
          enable = true;
          taps = [ "jorgelbg/tap" "shaunsingh/SFMono-Nerd-Font-Ligaturized" ];
          brews = [ ];
          casks = [
            "rectangle"
            "tg-pro"
            "iterm2"
            "font-sf-mono-nerd-font-ligaturized"
          ];
        };

        security.pam.enableSudoTouchIdAuth = true;
        # Enable tap to click
        system.defaults.trackpad.Clicking = true;
        # system.defaults.trackpad.Clicking = true;
        # Enable Rosetta 2
        system.activationScripts.extraActivation.text = ''
          softwareupdate --install-rosetta --agree-to-license
          if test -f $HOME/.config/emacs/bin/doom; then
             $HOME/.config/emacs/bin/doom sync
          fi
        '';
      };
      darwin_conf = nix-darwin.lib.darwinSystem {
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
    in {
      darwinConfigurations."atreides" = darwin_conf;
      darwinConfigurations."harkonnen" = darwin_conf;
    };
}
