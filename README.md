# 📓 dotfiles

This repo contains my configuration files for the programs I use, managed with nix through home-manager.
It should work both on Mac and Linux.

##  Setup
## 🐧 Linux:
1. Install nix
```sh
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix >> nix.sh && sh nix.sh install && rm nix.sh
```
2. Add unstable channel
```sh
nix-channel --add https://nixos.org/channels/nixpkgs-unstable
```
3. Clone the repo and bootstrap home-manager:
```
git clone git@github.com:fkrause98/dotfiles.git ~/dotfiles && nix run home-manager/master -- init --switch ~/dotfiles 
```
## 🍎 Mac install:

For Mac, I'm using both home-manager and nix-darwin.

1. Install nix
```
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix >> nix.sh && sh nix.sh install && rm nix.sh
```
2. Add unstable channel
```sh
nix-channel --add https://nixos.org/channels/nixpkgs-unstable && nix-channel --update
```
3. Install brew manually since nix-darwin needs it:
```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" \
 && eval "$(/opt/homebrew/bin/brew shellenv)" 
```
4. Update the mac's host-name to match with the one expected on the config, use
one of these two:
```sh
   sudo scutil --set LocalHostName muaddib
```
```sh
   sudo scutil --set LocalHostName arrakis
```
5. Install nix-darwin
```sh
nix run nix-darwin --extra-experimental-features nix-command --extra-experimental-features flakes -- switch --flake ~/dotfiles
```
6. Setup fish's prompt, install doom emacs:
```sh
fish && tide-setup && install-doom-emacs
```

## Some useful Nix references:

- [CPP Flake Template](https://github.com/nkoturovic/cpp-nix-project-template)
- [The nix book](https://nixos-and-flakes.thiscute.world/)
