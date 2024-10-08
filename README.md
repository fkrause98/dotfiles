# 📓 dotfiles

This repo contains my configuration files for the programs I use, managed with nix through home-manager.
It should work both on Mac and Linux.

##  Setup
## 🐧 Linux  nix setup:
For linux, I'm using home-manager alone.
1. Install nix
```sh
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix >> nix.sh && sh nix.sh install && rm nix.sh
```
2. Add unstable channel
```sh
nix-channel --add https://nixos.org/channels/nixpkgs-unstable
```
3. Link this repo's config (make s
ure you're in the repo's local folder)
```
mkdir -p ~/.config/home-manager && ln -s $(pwd)/home-manager/home.nix ~/.config/home-manager/home.nix
```
4. Install home-manager:
```
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager &&
  nix-channel --update &&
  nix-shell '<home-manager>' -A install
```
5. Finally, run home-manager:
```
home-manager switch
```
And now, follow the steps to install home manager.
## 🍎 Mac nix install:

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
