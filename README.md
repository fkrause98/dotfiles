# 📓 dotfiles

This repo contains my configuration files for the programs I use, managed with nix through home-manager.
It should work both on Mac and Linux.

## Setup
## 🐧 Linux nix install:
```
$ sh <(curl -L https://nixos.org/nix/install) --daemon --yes
```
## 🍎 Mac nix install:
```
$ sh <(curl -L https://nixos.org/nix/install) --yes
```

If for some reason the install fails, be sure to remove every
backup file that nix creates:
```
$ sudo find /etc/ -name '*nix*' -print0 | sudo xargs --null rm
```
## ❄️  Nix
After installing nix, restart the terminal, currently open sessions won't work properly.
1. Check If this command runs without sudo, this means the setup is working
```
$ nix-instantiate '<nixpkgs>' -A hello
```
2. Link this repo's config (make sure you're in the repo's local folder)
```
$ ln -s $(pwd)/home.nix ~/.config/home-manager/home.nix
```
3. Install home-manager:
```
$ nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager &&
  nix-channel --update &&
  nix-shell '<home-manager>' -A install
```
4. Finally, run home-manager:
```
$ home-manager switch
```
## 🐃 Emacs:
The home.nix provides a convenient alias to install Emacs and Doom:
```
$  install-emacs
```
And then, remove the default config and link this repo's:
```
$ rm -rf ~/.config/doom &&
ln -s $(pwd)/doom-emacs ~/.config/doom &&
~/.config/emacs/bin/doom sync &&
```
