# 📓 dotfiles

This repo contains my configuration files for the programs I use, managed with nix through home-manager.
It should work both on Mac and Linux.

##  Setup
## ❄️ NixOs
Simply link the nixos config to /etc/nixos
```
sudo ln -s $(pwd)/nixos /etc/nixos
```
## 🐧 Linux  nix install:
```
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix >> nix.sh && sh nix.sh rm nix.sh
```

And now, follow the steps to install home manager.
## 🍎 Mac nix install:
```
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix >> nix.sh && sh nix.sh rm nix.sh
```

If for some reason the install fails, be sure to remove every
backup file that nix creates:
```
# sudo find /etc/ -name '*nix*' -print0 | sudo xargs --null rm
```
And now, follow the steps to install home manager.

## ❄️  Home Manager (non NixOs)
After installing nix, restart the terminal, currently open sessions won't work properly.
1. Check If this command runs without sudo, this means the setup is working
```
$ nix-instantiate '<nixpkgs>' -A hello
```
You migh need to add a channel first, this one adds the unstable one:
```
$ nix-channel --add https://nixos.org/channels/nixpkgs-unstable
```
Here are the available [channel](https://channels.nixos.org/)

2. Link this repo's config (make s
ure you're in the repo's local folder)
```
$ mkdir -p ~/.config/home-manager && ln -s $(pwd)/home-manager/home.nix ~/.config/home-manager/home.nix
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
