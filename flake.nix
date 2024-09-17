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
    darwin-emacs = {
      url = "github:c4710n/nix-darwin-emacs";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    darwin-emacs-packages = {
      url = "github:nix-community/emacs-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager
    , darwin-emacs-packages, darwin-emacs }:
    let
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

        programs.zsh.enable = true;
        services.emacs = { enable = false; };

        environment.systemPackages = with pkgs;
          [
            cmake
            fastfetch
            vim
            colima
            asdf-vm
            wxGTK32
            erlang-ls
            elixir-ls
            iterm2
            ngrok
            protobuf
            libiconv
            just
            # omnisharp-roslyn
            # dotnet-sdk_7
            rustup
            (import ./home-manager/lsp-booster.nix { pkgs = pkgs; })
            nodejs_18
            yarn
            sqlx-cli
            gleam
            go
            neovim
          ] ++
          # Rust build dependencies
          [
            pkgs.darwin.CF
            pkgs.darwin.apple_sdk.frameworks.SystemConfiguration
            pkgs.libiconv
          ];

        homebrew = {
          enable = true;
          taps = [
            "shaunsingh/SFMono-Nerd-Font-Ligaturized"
            "d12frosted/emacs-plus"
          ];
          brews = [
            "mosh"
            "ansible"
            "qemu"
            "docker"
            {
              name = "emacs-plus@30";
              args = [
                "with-debug"
                "with-xwidgets"
                "with-imagemagick"
                "with-native-comp"
                "with-poll"
                "with-savchenkovaleriy-big-sur-curvy-3d-icon"
              ];
            }
          ];
          casks = [
            "rectangle"
            "vagrant"
            "tg-pro"
            "iterm2"
            "docker"
            "font-sf-mono-nerd-font-ligaturized"
          ];
          onActivation.extraFlags = [ "--verbose" ];
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
          # inputs.nix-doom-emacs-unstraightened.hmModule
          {
            nixpkgs = {
              overlays = [
                darwin-emacs.overlays.emacs
                darwin-emacs-packages.overlays.package
              ];
            };
          }
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
      darwinConfigurations."dune" = darwin_conf;
      darwinConfigurations."arrakis" = darwin_conf;
    };
}
