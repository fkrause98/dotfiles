# dotfiles

This repo contains my configuration files for the programs I use, managed with nix through home-manager.

## Linux setup:
### Linux Install
Simply run the install.sh and wait for it to finish (more info in home_manager.md), this
is a single-user nix install. The script will also install doom emacs and 
symlink the config.
## Mac install
### Nix
MacOS only allows multi-user install, it can get a bit messy so I haven't yet
created a script.

1. Install Nix, you will probably be asked to use sudo: 
```
$ sh <(curl -L https://nixos.org/nix/install)
```
2. Restart your terminal, currently open sessions won't work properly.
3. If this command runs without sudo, the setup is working
```
$ nix-instantiate '<nixpkgs>' -A hello
```
4. Install home-manager:
```
$ nix-channel --add https://github.com/nix-community/home-manager/archive/release-22.11.tar.gz home-manager &&
  nix-channel --update &&
  nix-shell '<home-manager>' -A install
```
## Adding programs:
To add a program, add a nix pkg to the home.nix file.
## Emacs setup:
After the nix setup, emacs should be installed, so:
1. Get doom:
```
git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.config/emacs
~/.config/emacs/bin/doom install
```
2. Remove default config and link this repo's:
```
rm -rf ~/.config/doom
ln -s $(pwd)/doom-emacs ~/.config/doom
~/.config/emacs/bin/doom sync
```
